import '../../core/types/catch_record.dart';
import '../../core/types/condition_result.dart';
import '../../core/types/conditions.dart';
import '../../core/types/lat_lng.dart';
import '../../data/database/daos/catches_dao.dart';
import '../../data/sources/ndbc/buoy_observation.dart';
import '../../data/sources/ndbc/ndbc_adapter.dart';
import '../../data/sources/nws_forecast/nws_adapter.dart';
import '../../data/sources/solunar/solunar_adapter.dart';
import '../../data/sources/source_adapter.dart';
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
    this.catches,
  });

  final NdbcAdapter ndbc;
  final TidesAndCurrentsAdapter tides;
  final NwsAdapter nws;
  final SolunarAdapter solunar;
  final CatchesDao? catches;

  @override
  Future<ConditionResult<double>> getWaterTemp(
    LatLng loc,
    DateTime time,
  ) async {
    if (!ndbc.canServe(loc, time)) return _unavailableDouble(time);
    try {
      final r = await ndbc.fetch(loc, time);
      final c = r.value.waterTempC;
      if (c == null) return _unavailableDouble(time);
      return _wrapDoubleFromBuoy(r, value: c * 1.8 + 32, unit: 'F');
    } on SourceException {
      return _unavailableDouble(time);
    }
  }

  @override
  Future<ConditionResult<TideState>> getTideState(
    LatLng loc,
    DateTime time,
  ) async {
    if (!tides.canServe(loc, time)) {
      return ConditionResult<TideState>.unavailable(
        value: const TideState(
          phase: TidePhase.slackHigh,
          toNextChange: Duration.zero,
        ),
        time: time,
      );
    }
    try {
      return await tides.fetch(loc, time);
    } on SourceException {
      return ConditionResult<TideState>.unavailable(
        value: const TideState(
          phase: TidePhase.slackHigh,
          toNextChange: Duration.zero,
        ),
        time: time,
      );
    }
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
    // NWS forecast first (point-resolved, no station-distance falloff);
    // fall back to NDBC if NWS can't serve.
    if (nws.canServe(loc, time)) {
      try {
        return await nws.fetch(loc, time);
      } on SourceException {
        // Try NDBC.
      }
    }
    if (!ndbc.canServe(loc, time)) return _unavailableWind(time);
    try {
      final r = await ndbc.fetch(loc, time);
      final speed = r.value.windSpeedMps;
      final dir = r.value.windDirDegT;
      if (speed == null || dir == null) return _unavailableWind(time);
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
      return _unavailableWind(time);
    }
  }

  @override
  Future<ConditionResult<WaveState>> getWaves(
    LatLng loc,
    DateTime time,
  ) async {
    if (!ndbc.canServe(loc, time)) return _unavailableWaves(time);
    try {
      final r = await ndbc.fetch(loc, time);
      final h = r.value.waveHeightM;
      if (h == null) return _unavailableWaves(time);
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
      return _unavailableWaves(time);
    }
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
    // Depth is sourced from ENC chart bathymetry / NMEA 2000; not in v1.
    return _unavailableDouble(DateTime.now().toUtc());
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
    if (!ndbc.canServe(loc, time)) return _unavailableBaro(time);
    try {
      final r = await ndbc.fetch(loc, time);
      final p = r.value.pressureHpa;
      if (p == null) return _unavailableBaro(time);
      // NDBC realtime2 doesn't expose a tendency value reliably; v1
      // reports stable + zero rate-of-change. Phase 4+ derives a real
      // trend from the cache history (multiple successive observations).
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
      return _unavailableBaro(time);
    }
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
  );
}
