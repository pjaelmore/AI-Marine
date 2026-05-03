import '../../core/types/catch_record.dart';
import '../../core/types/condition_result.dart';
import '../../core/types/conditions.dart';
import '../../core/types/lat_lng.dart';

/// Unified data layer the engine consumes — TDD §2.1.2.
///
/// Every method is asynchronous and may return `ConditionResult` with
/// `source = DataSource.unavailable` when no source can satisfy the
/// request (TDD §2.1.3). The Probability Calculator interprets unavailable
/// inputs by suppressing the affected modifier.
///
/// Phase 3 v1 implements the methods served by current adapters (NDBC,
/// Tides & Currents, NWS, Solunar). Methods that depend on data sources
/// not yet wired (CoastWatch SST, NMEA 2000, depth/structure inference)
/// return `unavailable` until later phases bring those sources online.
abstract class ConditionsService {
  Future<ConditionResult<double>> getWaterTemp(LatLng loc, DateTime time);
  Future<ConditionResult<TideState>> getTideState(LatLng loc, DateTime time);
  Future<ConditionResult<CurrentVector>> getCurrent(
    LatLng loc,
    DateTime time, {
    double? depthMeters,
  });
  Future<ConditionResult<WindVector>> getWind(LatLng loc, DateTime time);
  Future<ConditionResult<WaveState>> getWaves(LatLng loc, DateTime time);
  Future<ConditionResult<SolunarState>> getSolunar(LatLng loc, DateTime time);
  Future<ConditionResult<double>> getDepth(LatLng loc);
  Future<ConditionResult<StructureInfo>> getStructure(LatLng loc);
  Future<ConditionResult<BarometricState>> getBarometric(
    LatLng loc,
    DateTime time,
  );
  Future<List<CatchRecord>> getRecentCatches(
    LatLng loc,
    double radiusNm, {
    String? speciesId,
    DateTime? since,
  });
}
