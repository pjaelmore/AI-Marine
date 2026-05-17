import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:ai_marine_engine/core/types/condition_result.dart';
import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/data/sources/bundled_bathymetry/bundled_bathymetry_adapter.dart';
import 'package:ai_marine_engine/data/sources/source_adapter.dart';
import 'package:flutter_test/flutter_test.dart';

import 'bathymetry_tile_test.dart' show encodeTile;

const _manifestPath = 'assets/bathymetry/fl/manifest.json';

Uint8List _manifest(List<Map<String, int>> tiles) => Uint8List.fromList(
      utf8.encode(
        jsonEncode({
          'version': 1,
          'tileDir': 'assets/bathymetry/fl',
          'cellsPerSide': 2,
          'cellSizeDeg': 0.5,
          'nodata': -32768,
          'tiles': tiles,
        }),
      ),
    );

// Same 2×2 tile as the tile-parser test: SW (28°N,81°W), 0.5° cells.
//   NW=-10 m (32.8 ft)  NE=-100 m (328 ft)
//   SW=+5 m (land)      SE=nodata
Uint8List _tileGz() => Uint8List.fromList(
      gzip.encode(
        encodeTile(
          side: 2,
          swLat: 28,
          swLon: -81,
          cell: 0.5,
          nodata: -32768,
          data: [-10, -100, 5, -32768],
        ),
      ),
    );

/// Fake asset loader backed by an in-memory path→bytes map. Missing
/// paths throw, mirroring rootBundle's behaviour for absent assets.
AssetLoader _loader(Map<String, Uint8List> assets) {
  return (path) async {
    final b = assets[path];
    if (b == null) throw Exception('asset not found: $path');
    return b;
  };
}

void main() {
  group('BundledBathymetryAdapter — wiring', () {
    test('sourceId is bundledBathymetry', () {
      final a = BundledBathymetryAdapter(assetLoader: _loader({}));
      expect(a.sourceId, DataSource.bundledBathymetry);
    });

    test('canServe is true for FL-box coords before the manifest loads', () {
      final a = BundledBathymetryAdapter(assetLoader: _loader({}));
      expect(
        a.canServe(
          const LatLng(latitude: 28.5, longitude: -80.5),
          DateTime.now(),
        ),
        isTrue,
      );
      expect(
        a.canServe(const LatLng(latitude: 45, longitude: -70), DateTime.now()),
        isFalse,
      );
    });
  });

  group('BundledBathymetryAdapter — fetch', () {
    BundledBathymetryAdapter build({
      required List<Map<String, int>> tiles,
      bool includeTile = true,
    }) {
      final assets = <String, Uint8List>{
        _manifestPath: _manifest(tiles),
        if (includeTile) 'assets/bathymetry/fl/N28_W81.bin.gz': _tileGz(),
      };
      return BundledBathymetryAdapter(assetLoader: _loader(assets));
    }

    test('returns depth in feet for an ocean cell', () async {
      final a = build(
        tiles: [
          {'lat': 28, 'lon': -81},
        ],
      );
      final r = await a.fetch(
        const LatLng(latitude: 28.75, longitude: -80.25), // NE = -100 m
        DateTime.now(),
      );
      expect(r.value, closeTo(328.084, 1e-2));
      expect(r.unit, 'ft');
      expect(r.source, DataSource.bundledBathymetry);
      expect(r.confidence, greaterThan(0.7)); // finer than GEBCO's 0.7
    });

    test('land cell surfaces as SourceException', () async {
      final a = build(
        tiles: [
          {'lat': 28, 'lon': -81},
        ],
      );
      expect(
        () => a.fetch(
          const LatLng(latitude: 28.25, longitude: -80.75), // SW = +5 m land
          DateTime.now(),
        ),
        throwsA(isA<SourceException>()),
      );
    });

    test('location with no tile in the manifest surfaces as SourceException',
        () async {
      final a = build(
        tiles: [
          {'lat': 28, 'lon': -81},
        ],
      );
      // 26°N,-82°W is in the FL box but no manifest tile covers it.
      expect(
        () => a.fetch(
          const LatLng(latitude: 26.5, longitude: -81.5),
          DateTime.now(),
        ),
        throwsA(isA<SourceException>()),
      );
    });

    test('placeholder manifest (zero tiles) behaves as not-present', () async {
      final a = build(tiles: const []);
      // Await the rejection so _manifestMissing latches before the
      // synchronous canServe check below.
      await expectLater(
        a.fetch(
          const LatLng(latitude: 28.5, longitude: -80.5),
          DateTime.now(),
        ),
        throwsA(isA<SourceException>()),
      );
      expect(
        a.canServe(
          const LatLng(latitude: 28.5, longitude: -80.5),
          DateTime.now(),
        ),
        isFalse,
      );
    });

    test('missing manifest asset → canServe false after first probe', () async {
      final a = BundledBathymetryAdapter(assetLoader: _loader({}));
      await expectLater(
        a.fetch(
          const LatLng(latitude: 28.5, longitude: -80.5),
          DateTime.now(),
        ),
        throwsA(isA<SourceException>()),
      );
      expect(
        a.canServe(
          const LatLng(latitude: 28.5, longitude: -80.5),
          DateTime.now(),
        ),
        isFalse,
      );
    });

    test('second query for the same tile is served from the LRU cache',
        () async {
      var tileReads = 0;
      final assets = <String, Uint8List>{
        _manifestPath: _manifest([
          {'lat': 28, 'lon': -81},
        ]),
        'assets/bathymetry/fl/N28_W81.bin.gz': _tileGz(),
      };
      final a = BundledBathymetryAdapter(
        assetLoader: (path) async {
          if (path.endsWith('.bin.gz')) tileReads++;
          final b = assets[path];
          if (b == null) throw Exception('not found: $path');
          return b;
        },
      );
      await a.fetch(
        const LatLng(latitude: 28.75, longitude: -80.25),
        DateTime.now(),
      );
      await a.fetch(
        const LatLng(latitude: 28.75, longitude: -80.75),
        DateTime.now(),
      );
      expect(tileReads, 1, reason: 'tile decoded once, then cached');
    });
  });
}
