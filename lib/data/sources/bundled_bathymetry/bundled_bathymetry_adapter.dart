import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;

import '../../../core/types/condition_result.dart';
import '../../../core/types/lat_lng.dart';
import '../source_adapter.dart';
import 'bathymetry_tile.dart';

/// Signature for fetching a raw bundled asset as bytes. Injectable so
/// tests can feed synthetic tiles/manifests without the Flutter asset
/// bundle.
typedef AssetLoader = Future<Uint8List> Function(String path);

/// Bundled FL bathymetry adapter — point depth from the gzipped
/// 1°×1° tile set produced by `scripts/build_fl_bathymetry.dart`.
///
/// **Why bundled, not an API.** Depth matters most when you're on the
/// water deciding where to fish — which offshore is exactly when you
/// have no cell signal. A bundled grid is always available. GMRT
/// (BlueTopo/CRM-blended, ~16–90 m) feeds the build script; the live
/// OpenTopoData GEBCO adapter remains the global fallback for water
/// outside the FL tile set.
///
/// **Memory.** Tiles are LRU-cached after decode; only the handful
/// near the query stay resident (~1.4 M int16 ≈ 2.8 MB each, cap
/// [_maxCachedTiles]). The full FL set is never all in RAM at once.
///
/// **Confidence 0.85** — higher than GEBCO's model-tier 0.7 (finer
/// grid, NOAA-sourced) but below a live in-situ buoy reading. Static
/// data, so `observedAt` is intentionally null (no freshness subtitle
/// on the card).
class BundledBathymetryAdapter extends SourceAdapter<double> {
  BundledBathymetryAdapter({
    AssetLoader? assetLoader,
    this.manifestPath = 'assets/bathymetry/fl/manifest.json',
  }) : _load = assetLoader ?? _defaultLoader;

  static const double _confidence = 0.85;
  static const int _maxCachedTiles = 6;

  final String manifestPath;
  final AssetLoader _load;

  static Future<Uint8List> _defaultLoader(String path) async {
    final data = await rootBundle.load(path);
    return data.buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes,
    );
  }

  // Lazy one-time manifest load. _manifestMissing latches true when
  // the asset isn't bundled (build script not run yet) so we stop
  // retrying and the conditions service falls straight to GEBCO.
  bool _manifestLoaded = false;
  bool _manifestMissing = false;
  String _tileDir = 'assets/bathymetry/fl';
  final Set<int> _tileKeys = <int>{}; // key = tileLat*1000 + (tileLon+500)

  final Map<int, BathymetryTile> _tileCache = <int, BathymetryTile>{};
  final List<int> _lru = <int>[];

  @override
  DataSource get sourceId => DataSource.bundledBathymetry;

  @override
  Duration get defaultTtl => const Duration(days: 365);

  static int _key(int tileLat, int tileLon) => tileLat * 1000 + (tileLon + 500);

  Future<void> _ensureManifest() async {
    if (_manifestLoaded || _manifestMissing) return;
    try {
      final raw = await _load(manifestPath);
      final json = jsonDecode(utf8.decode(raw)) as Map<String, dynamic>;
      _tileDir = (json['tileDir'] as String?) ?? _tileDir;
      final tiles = (json['tiles'] as List).cast<Map<String, dynamic>>();
      for (final t in tiles) {
        _tileKeys.add(_key(t['lat'] as int, t['lon'] as int));
      }
      if (_tileKeys.isEmpty) {
        // Placeholder manifest shipped before the build script has
        // generated real tiles — behave exactly as "not present" so
        // the service falls straight through to GEBCO.
        _manifestMissing = true;
        return;
      }
      _manifestLoaded = true;
    } catch (_) {
      // No manifest bundled (build script not run) or it's malformed —
      // latch missing so canServe() returns false and the service
      // falls through to GEBCO without per-query retries.
      _manifestMissing = true;
    }
  }

  @override
  bool canServe(LatLng location, DateTime time) {
    // Synchronous contract — if the manifest hasn't loaded yet we
    // optimistically say yes for FL-ish latitudes; fetch() does the
    // authoritative check and throws if the tile is absent.
    if (_manifestMissing) return false;
    final lat = location.latitude;
    final lon = location.longitude;
    return lat >= 24 && lat <= 31 && lon >= -88 && lon <= -79;
  }

  @override
  Future<ConditionResult<double>> fetch(
    LatLng location,
    DateTime time,
  ) async {
    await _ensureManifest();
    if (_manifestMissing) {
      throw const SourceException(
        'Bundled FL bathymetry asset not present',
        source: DataSource.bundledBathymetry,
      );
    }
    final tileLat = location.latitude.floor();
    final tileLon = location.longitude.floor();
    final key = _key(tileLat, tileLon);
    if (!_tileKeys.contains(key)) {
      throw const SourceException(
        'No bundled bathymetry tile covers this location',
        source: DataSource.bundledBathymetry,
      );
    }
    final tile = await _tile(key, tileLat, tileLon);
    final depthFt = tile.depthFtAt(location.latitude, location.longitude);
    if (depthFt == null) {
      throw const SourceException(
        'Bundled bathymetry cell is land or unsurveyed',
        source: DataSource.bundledBathymetry,
      );
    }
    final now = DateTime.now().toUtc();
    return ConditionResult<double>(
      value: depthFt,
      unit: 'ft',
      source: DataSource.bundledBathymetry,
      sourceDetails: const SourceDetails(),
      fetchedAt: now,
      validUntil: now.add(defaultTtl),
      confidence: _confidence,
    );
  }

  Future<BathymetryTile> _tile(int key, int tileLat, int tileLon) async {
    final cached = _tileCache[key];
    if (cached != null) {
      _touch(key);
      return cached;
    }
    final fileLat = tileLat >= 0 ? 'N$tileLat' : 'S${-tileLat}';
    final fileLon = tileLon >= 0 ? 'E$tileLon' : 'W${-tileLon}';
    final path = '$_tileDir/${fileLat}_$fileLon.bin.gz';
    final gz = await _load(path);
    final raw = Uint8List.fromList(gzip.decode(gz));
    final tile = BathymetryTile.parse(raw);
    _tileCache[key] = tile;
    _touch(key);
    _evictIfNeeded();
    return tile;
  }

  void _touch(int key) {
    _lru
      ..remove(key)
      ..add(key);
  }

  void _evictIfNeeded() {
    while (_tileCache.length > _maxCachedTiles && _lru.isNotEmpty) {
      final oldest = _lru.removeAt(0);
      _tileCache.remove(oldest);
    }
  }
}
