import 'package:freezed_annotation/freezed_annotation.dart';

part 'buoy_observation.freezed.dart';
part 'buoy_observation.g.dart';

/// One parsed NDBC observation row. Every measurement is nullable because
/// the raw feed uses 'MM' (missing) liberally — the spec says columns can
/// drop out independently and the engine handles the absence by skipping
/// the dependent modifier (TDD §2.1.3).
///
/// Units mirror the NDBC realtime2 file format: degC for temperatures,
/// m/s for winds, metres for waves, hPa for pressure, degT for direction.
/// Unit conversion to engine-facing imperial values happens in the
/// ConditionsService extraction layer.
@freezed
class BuoyObservation with _$BuoyObservation {
  const factory BuoyObservation({
    required String stationId,
    required DateTime timestamp,
    double? waterTempC,
    double? airTempC,
    double? windDirDegT,
    double? windSpeedMps,
    double? gustMps,
    double? waveHeightM,
    double? dominantPeriodSec,
    double? pressureHpa,
  }) = _BuoyObservation;

  factory BuoyObservation.fromJson(Map<String, dynamic> json) =>
      _$BuoyObservationFromJson(json);
}
