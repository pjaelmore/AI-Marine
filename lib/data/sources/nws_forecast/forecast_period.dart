import 'package:freezed_annotation/freezed_annotation.dart';

part 'forecast_period.freezed.dart';
part 'forecast_period.g.dart';

/// One period of the NWS forecast — TDD §5.4.2. Shape mirrors the
/// `properties.periods[]` entries returned by the gridpoint forecast
/// endpoint, with only the fields the engine consumes.
@freezed
class ForecastPeriod with _$ForecastPeriod {
  const factory ForecastPeriod({
    required DateTime startTime,
    required DateTime endTime,
    required double temperature,
    required String temperatureUnit,
    required String windSpeedRaw,
    required String windDirectionRaw,
    required String shortForecast,
  }) = _ForecastPeriod;

  factory ForecastPeriod.fromJson(Map<String, dynamic> json) =>
      _$ForecastPeriodFromJson(json);
}
