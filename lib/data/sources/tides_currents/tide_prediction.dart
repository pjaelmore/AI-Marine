import 'package:freezed_annotation/freezed_annotation.dart';

part 'tide_prediction.freezed.dart';
part 'tide_prediction.g.dart';

/// High vs low extreme — matches the `type` field in NOAA's
/// predictions response (`H` / `L`).
enum TideType { high, low }

/// One predicted tide extreme (high or low) at a station — TDD §5.3.2.
/// `time` is UTC (we request `time_zone=GMT`).
@freezed
class TidePrediction with _$TidePrediction {
  const factory TidePrediction({
    required DateTime time,
    required double heightFt,
    required TideType type,
  }) = _TidePrediction;

  factory TidePrediction.fromJson(Map<String, dynamic> json) =>
      _$TidePredictionFromJson(json);
}
