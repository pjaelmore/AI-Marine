import 'dart:convert';

import '../../core/types/catch_record.dart';
import '../../core/types/condition_result.dart';
import '../../core/types/conditions.dart';
import '../../core/types/lat_lng.dart';
import '../../data/cache/cache_manager.dart';
import '../../data/cache/result_codec.dart';
import '../../data/database/daos/catches_dao.dart';
import '../../data/sources/ndbc/buoy_observation.dart';
import '../../data/sources/ndbc/ndbc_adapter.dart';
import '../../data/sources/nws_forecast/nws_adapter.dart';
import '../../data/sources/open_meteo_marine/open_meteo_marine_adapter.dart';
import '../../data/sources/open_topo_data/open_topo_data_adapter.dart';
import '../../data/sources/solunar/solunar_adapter.dart';
import '../../data/sources/source_adapter.dart';
import '../../data/sources/tides_currents/tide_phase_computer.dart';
import '../../data/sources/tides_currents/tide_prediction.dart';
import '../../data/sources/tides_currents/tides_currents_adapter.dart';
import 'conditions_service.dart';

/// Wires the per-source adapters into the unified [ConditionsService]
/// surface — TDD §2.1.2 / §5.7.
///
/// Each method extracts the right field from the right adapter, converts
/// units to engine-facing values, and either wraps in a `ConditionResult`
/// with full provenance or returns `unavailable`. `SourceException` from
/// any adapter is caught here so the service interface never throws —
/// the engine treats unavailable as "skip the modifier" per §2.1.3.
class ConditionsServiceImpl implements ConditionsService {
  ConditionsServiceImpl({
    required this.ndbc,
    required this.tides,
    required this.nws,
    required this.solunar,
    this.openMeteo,
    this.bathymetry,
    this.catches,
    this.cache,
  });

  final NdbcAdapter ndbc;
  final TidesAndCurrentsAdapter tides;
  final NwsAdapter nws;
  final SolunarAdapter solunar;

  /// Open-Meteo Marine SST fallback. When null, water-temp lookups
  /// stop at NDBC (Phase 6 behavior); when wired, NDBC misses fall
  /// through to this model-derived SST source so offshore points get
  /// a real reading instead of "no data."
  final OpenMeteoMarineAdapter? openMeteo;

  /// OpenTopoData GEBCO bathymetry source. When null, `getDepth` stays
  /// in the Phase 3 "unavailable" placeholder mode; when wired, depth
  /// queries route through this adapter so the depth modifier can
  /// finally fire against species `depthPreference` profiles.
  final OpenTopoDataAdapter? bathymetry;

  final CatchesDao? catches;

  /// Optional four-tier cache. When null, every method goes straight
  /// to its adapter — preserves the existing test-fixture path that
  /// constructs the service without a database. The Riverpod
  /// `conditionsServiceProvider` always wires a real manager.
  final CacheManager? cache;

  /// Lat/lng bucketed to 0.1° (~10 km) for cache keys. Two lookups in
  /// the same general area share one warm-cache entry — that's the
  /// score-grid loop's cache hit. Different fishing spots tens of km
  /// apart get their own entries.
  String _locKey(LatLng loc) => '${(loc.latitude * 10).round() / 10},'
      '${(loc.longitude * 10).round() / 10}';

  /// `YYYY-MM-DD` for the UTC day of [time] — the cold-tier tide cache
  /// key per (station, day).
  String _dayBucket(DateTime time) {
    final t = time.toUtc();
    final m = t.month.toString().padLeft(2, '0');
    final d = t.day.toString().padLeft(2, '0');
    return '${t.year}-$m-$d';
  }

  /// Bridges a typed adapter [fetch] through the four-tier cache when a
  /// manager is wired, or runs it bare when the service was constructed
  /// without one. Centralizes the encode/decode + warmTtl wiring so per-
  /// method bodies stay focused on the source-specific extraction.
  Future<ConditionResult<T>?> _cachedFetch<T>({
    required String key,
    required String dataType,
    required String source,
    required Object? Function(T value) toJsonT,
    required T Function(Object? raw) fromJsonT,
    required Future<ConditionResult<T>?> Function() fetch,
  }) async {
    final mgr = cache;
    if (mgr == null) return fetch();
    return mgr.readThrough<ConditionResult<T>>(
      key: key,
      dataType: dataType,
      source: source,
      // Uniform 1h TTL across condition types in v1: NDBC realtime2 and
      // NWS hourly forecast both update on roughly hourly cadence, so
      // tighter wastes refetches and looser is stale-on-the-hour. Slice
      // post-Phase-5 calibration can tune per data type.
      warmTtl: const Duration(hours: 1),
      encode: (r) => encodeConditionResult(r, toJsonT),
      decode: (s) => decodeConditionResult(s, fromJsonT),
      fetcher: fetch,
    );
  }

  @override
  Future<ConditionResult<double>> getWaterTemp(
    LatLng loc,
    DateTime time,
  ) async {
    final result = await _cachedFetch<double>(
      key: 'water_temp:${_locKey(loc)}',
      dataType: 'water_temp',
      source: 'noaa_ndbc',
      toJsonT: (v) => v,
      fromJsonT: (j) => (j as num).toDouble(),
      fetch: () async {
        // Tier 1: nearest NDBC buoy. Higher fidelity (real reading,
        // confidence scaled by distance), preferred when available.
        if (ndbc.canServe(loc, time)) {
          try {
            final r = await ndbc.fetch(loc, time);
            final c = r.value.waterTempC;
            if (c != null) {
              return _wrapDoubleFromBuoy(r, value: c * 1.8 + 32, unit: 'F');
            }
            // Buoy is in range but didn't report `WTMP` this cycle —
            // common for wave-only stations. Fall through to model SST.
          } on SourceException {
            // Network or parsing failure — also fall through.
          }
        }
        // Tier 2: Open-Meteo global SST. Wider coverage than NDBC, at
        // a lower confidence flag so the breakdown reflects the
        // model-derived nature of the number.
        final om = openMeteo;
        if (om == null) return null;
        if (!om.canServe(loc, time)) return null;
        try {
          return await om.fetch(loc, time);
        } on SourceException {
          return null;
        }
      },
    );
    return result ?? _unavailableDouble(time);
  }

  @override
  Future<ConditionResult<TideState>> getTideState(
    LatLng loc,
    DateTime time,
  ) async {
    final mgr = cache;
    if (mgr == null) {
      // Back-compat: existing tests construct without a cache; route
      // through the all-in-one adapter.fetch() path.
      if (!tides.canServe(loc, time)) return _unavailableTide(time);
      try {
        return await tides.fetch(loc, time);
      } on SourceException {
        return _unavailableTide(time);
      }
    }

    final station = tides.findNearestStation(loc);
    if (station == null) return _unavailableTide(time);

    // The cold tier caches the *predictions list* (one row per
    // station+day), not the computed TideState. The same predictions
    // serve any time-of-day query within the 3-day window the adapter
    // fetches, so a single cold-tier hit can serve hundreds of phase
    // computations across a session. Phase compute is local and runs
    // on every lookup.
    final dayBucket = _dayBucket(time);
    final predictionsJson = await mgr.getTide(
      stationId: station.id,
      dayBucket: dayBucket,
      // 7-day TTL: NOAA tide predictions are stable for the full year,
      // so the limiting factor is "do we trust week-old data?" rather
      // than freshness. v1 picks 7 days — long enough for offline trip
      // use, short enough that astronomical-anomaly corrections
      // refresh within a fortnight.
      coldTtl: const Duration(days: 7),
      fetcher: () async {
        try {
          final preds = await tides.fetchPredictions(
            station: station,
            time: time,
          );
          return jsonEncode(preds.map((p) => p.toJson()).toList());
        } on SourceException {
          return null;
        }
      },
    );
    if (predictionsJson == null) return _unavailableTide(time);

    final predictions = (jsonDecode(predictionsJson) as List)
        .cast<Map<String, dynamic>>()
        .map(TidePrediction.fromJson)
        .toList();
    if (predictions.isEmpty) return _unavailableTide(time);

    final tide = computeTideStateAt(time.toUtc(), predictions);
    final fetchedAt = DateTime.now().toUtc();
    return ConditionResult<TideState>(
      value: tide,
      unit: 'phase',
      source: DataSource.noaaTidesAndCurrents,
      sourceDetails: SourceDetails(
        stationId: station.id,
        interpolationDistanceNm: station.distanceNmTo(loc),
      ),
      fetchedAt: fetchedAt,
      validUntil: fetchedAt.add(const Duration(minutes: 15)),
      confidence: confidenceFromDistance(station.distanceNmTo(loc)),
    );
  }

  @override
  Future<ConditionResult<CurrentVector>> getCurrent(
    LatLng loc,
    DateTime time, {
    double? depthMeters,
  }) async {
    // Tide-current adapter not implemented in Phase 3; v1 returns
    // unavailable so the engine suppresses any current-dependent modifier.
    return ConditionResult<CurrentVector>.unavailable(
      value: const CurrentVector(speedKnots: 0, directionDegrees: 0),
      time: time,
    );
  }

  @override
  Future<ConditionResult<WindVector>> getWind(
    LatLng loc,
    DateTime time,
  ) async {
    // One cache entry per location, regardless of which adapter filled
    // it — the cached ConditionResult.source records NWS vs NDBC. The
    // warm-cache row's `source` column is stamped with the *preferred*
    // adapter (noaa_marine_forecast); when an entry was actually filled
    // by the NDBC fallback, the inner ConditionResult stays accurate
    // and the row tag lies a little. v1 doesn't drive eviction-by-
    // source so this loss of fidelity is tolerable; Phase 5+ can
    // refine.
    final result = await _cachedFetch<WindVector>(
      key: 'wind:${_locKey(loc)}',
      dataType: 'wind',
      source: 'noaa_marine_forecast',
      toJsonT: (v) => v.toJson(),
      fromJsonT: (j) => WindVector.fromJson(j! as Map<String, dynamic>),
      fetch: () async {
        // NWS forecast first (point-resolved, no station-distance
        // falloff); fall back to NDBC if NWS can't serve.
        if (nws.canServe(loc, time)) {
          try {
            return await nws.fetch(loc, time);
          } on SourceException {
            // Try NDBC.
          }
        }
        if (!ndbc.canServe(loc, time)) return null;
        try {
          final r = await ndbc.fetch(loc, time);
          final speed = r.value.windSpeedMps;
          final dir = r.value.windDirDegT;
          if (speed == null || dir == null) return null;
          return ConditionResult<WindVector>(
            value: WindVector(
              speedKnots: speed * 1.94384, // m/s → knots
              directionDegrees: dir,
              gustsKnots:
                  r.value.gustMps == null ? null : r.value.gustMps! * 1.94384,
            ),
            unit: 'kt',
            source: r.source,
            sourceDetails: r.sourceDetails,
            fetchedAt: r.fetchedAt,
            validUntil: r.validUntil,
            confidence: r.confidence,
          );
        } on SourceException {
          return null;
        }
      },
    );
    return result ?? _unavailableWind(time);
  }

  @override
  Future<ConditionResult<WaveState>> getWaves(
    LatLng loc,
    DateTime time,
  ) async {
    final result = await _cachedFetch<WaveState>(
      key: 'waves:${_locKey(loc)}',
      dataType: 'waves',
      source: 'noaa_ndbc',
      toJsonT: (v) => v.toJson(),
      fromJsonT: (j) => WaveState.fromJson(j! as Map<String, dynamic>),
      fetch: () async {
        if (!ndbc.canServe(loc, time)) return null;
        try {
          final r = await ndbc.fetch(loc, time);
          final h = r.value.waveHeightM;
          if (h == null) return null;
          return ConditionResult<WaveState>(
            value: WaveState(
              significantHeightFt: h * 3.28084,
              dominantPeriodSec: r.value.dominantPeriodSec,
            ),
            unit: 'ft',
            source: r.source,
            sourceDetails: r.sourceDetails,
            fetchedAt: r.fetchedAt,
            validUntil: r.validUntil,
            confidence: r.confidence,
          );
        } on SourceException {
          return null;
        }
      },
    );
    return result ?? _unavailableWaves(time);
  }

  @override
  Future<ConditionResult<SolunarState>> getSolunar(
    LatLng loc,
    DateTime time,
  ) async {
    // Solunar adapter is local and never fails; no canServe gate needed.
    return solunar.fetch(loc, time);
  }

  @override
  Future<ConditionResult<double>> getDepth(LatLng loc) async {
    final bathy = bathymetry;
    if (bathy == null) {
      // No adapter wired — preserve the Phase 3 placeholder behavior
      // for tests and bare-bones service configurations.
      return _unavailableDouble(DateTime.now().toUtc());
    }
    final result = await _cachedFetch<double>(
      key: 'depth:${_locKey(loc)}',
      dataType: 'depth',
      source: 'open_topo_data',
      toJsonT: (v) => v,
      fromJsonT: (j) => (j as num).toDouble(),
      fetch: () async {
        if (!bathy.canServe(loc, DateTime.now().toUtc())) return null;
        try {
          return await bathy.fetch(loc, DateTime.now().toUtc());
        } on SourceException {
          // Land taps and network failures both flow through here —
          // the calculator surfaces the "no bathymetry" placeholder
          // either way.
          return null;
        }
      },
    );
    return result ?? _unavailableDouble(DateTime.now().toUtc());
  }

  @override
  Future<ConditionResult<StructureInfo>> getStructure(LatLng loc) async {
    // Structure inference combines depth gradient + bottom type; not in v1.
    return ConditionResult<StructureInfo>.unavailable(
      value: const StructureInfo(type: StructureType.unknown),
      time: DateTime.now().toUtc(),
    );
  }

  @override
  Future<ConditionResult<BarometricState>> getBarometric(
    LatLng loc,
    DateTime time,
  ) async {
    final result = await _cachedFetch<BarometricState>(
      key: 'barometric:${_locKey(loc)}',
      dataType: 'barometric',
      source: 'noaa_ndbc',
      toJsonT: (v) => v.toJson(),
      fromJsonT: (j) => BarometricState.fromJson(j! as Map<String, dynamic>),
      fetch: () async {
        if (!ndbc.canServe(loc, time)) return null;
        try {
          final r = await ndbc.fetch(loc, time);
          final p = r.value.pressureHpa;
          if (p == null) return null;
          // NDBC realtime2 doesn't expose a tendency value reliably; v1
          // reports stable + zero rate-of-change. Phase 4+ derives a real
          // trend from the cache history (successive observations).
          return ConditionResult<BarometricState>(
            value: BarometricState(
              pressureMillibars: p,
              trend: BarometricTrend.stable,
              rateOfChangeMillibarsPerHour: 0,
            ),
            unit: 'hPa',
            source: r.source,
            sourceDetails: r.sourceDetails,
            fetchedAt: r.fetchedAt,
            validUntil: r.validUntil,
            confidence: r.confidence,
          );
        } on SourceException {
          return null;
        }
      },
    );
    return result ?? _unavailableBaro(time);
  }

  @override
  Future<List<CatchRecord>> getRecentCatches(
    LatLng loc,
    double radiusNm, {
    String? speciesId,
    DateTime? since,
  }) async {
    final dao = catches;
    if (dao == null) return const [];
    final all = await dao.getAll();
    return all.where((c) {
      if (speciesId != null && c.speciesId != speciesId) return false;
      if (since != null && c.timestamp.isBefore(since)) return false;
      return c.location.distanceTo(loc) <= radiusNm;
    }).toList();
  }
}

ConditionResult<double> _unavailableDouble(DateTime time) =>
    ConditionResult<double>.unavailable(value: double.nan, time: time);

ConditionResult<WindVector> _unavailableWind(DateTime time) =>
    ConditionResult<WindVector>.unavailable(
      value: const WindVector(speedKnots: 0, directionDegrees: 0),
      time: time,
    );

ConditionResult<WaveState> _unavailableWaves(DateTime time) =>
    ConditionResult<WaveState>.unavailable(
      value: const WaveState(significantHeightFt: 0),
      time: time,
    );

ConditionResult<TideState> _unavailableTide(DateTime time) =>
    ConditionResult<TideState>.unavailable(
      value: const TideState(
        phase: TidePhase.slackHigh,
        toNextChange: Duration.zero,
      ),
      time: time,
    );

ConditionResult<BarometricState> _unavailableBaro(DateTime time) =>
    ConditionResult<BarometricState>.unavailable(
      value: const BarometricState(
        pressureMillibars: 0,
        trend: BarometricTrend.stable,
        rateOfChangeMillibarsPerHour: 0,
      ),
      time: time,
    );

ConditionResult<double> _wrapDoubleFromBuoy(
  ConditionResult<BuoyObservation> source, {
  required double value,
  required String unit,
}) {
  return ConditionResult<double>(
    value: value,
    unit: unit,
    source: source.source,
    sourceDetails: source.sourceDetails,
    fetchedAt: source.fetchedAt,
    validUntil: source.validUntil,
    confidence: source.confidence,
    // Preserve the buoy's own measurement time — 10-minute realtime2
    // cadence means the wrapped value can already be 50+ minutes old.
    observedAt: source.observedAt ?? source.value.timestamp,
  );
}
