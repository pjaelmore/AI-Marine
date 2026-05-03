import '../../../core/types/condition_result.dart';
import '../../../core/types/conditions.dart';
import '../../../core/types/lat_lng.dart';
import '../source_adapter.dart';
import 'solunar_computer.dart';

/// Wraps [SolunarComputer] in the [SourceAdapter] contract so the
/// Conditions Service registry treats it uniformly with NOAA HTTP
/// adapters. Per TDD §5.7 it's registered alongside the network adapters
/// even though it never makes a request.
class SolunarAdapter extends SourceAdapter<SolunarState> {
  SolunarAdapter([this._computer = const SolunarComputer()]);

  final SolunarComputer _computer;

  @override
  DataSource get sourceId => DataSource.computedLocal;

  /// Always answers — sun and moon mechanics are valid for any location at
  /// any time. (Polar latitudes have edge cases for lunar rise/set; the
  /// computer returns null windows there rather than failing.)
  @override
  bool canServe(LatLng location, DateTime time) =>
      location.isValid && time.isUtc || true;

  @override
  Duration get defaultTtl => const Duration(hours: 1);

  @override
  Future<ConditionResult<SolunarState>> fetch(
    LatLng location,
    DateTime time,
  ) async {
    final state = _computer.compute(location, time);
    final fetchedAt = DateTime.now().toUtc();
    return ConditionResult<SolunarState>(
      value: state,
      unit: 'composite',
      source: DataSource.computedLocal,
      sourceDetails: const SourceDetails(),
      fetchedAt: fetchedAt,
      validUntil: fetchedAt.add(defaultTtl),
      // Pure computation; no observational uncertainty.
      confidence: 1,
    );
  }
}
