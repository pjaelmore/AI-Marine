// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forecast_period.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ForecastPeriod _$ForecastPeriodFromJson(Map<String, dynamic> json) {
  return _ForecastPeriod.fromJson(json);
}

/// @nodoc
mixin _$ForecastPeriod {
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  double get temperature => throw _privateConstructorUsedError;
  String get temperatureUnit => throw _privateConstructorUsedError;
  String get windSpeedRaw => throw _privateConstructorUsedError;
  String get windDirectionRaw => throw _privateConstructorUsedError;
  String get shortForecast => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ForecastPeriodCopyWith<ForecastPeriod> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForecastPeriodCopyWith<$Res> {
  factory $ForecastPeriodCopyWith(
          ForecastPeriod value, $Res Function(ForecastPeriod) then) =
      _$ForecastPeriodCopyWithImpl<$Res, ForecastPeriod>;
  @useResult
  $Res call(
      {DateTime startTime,
      DateTime endTime,
      double temperature,
      String temperatureUnit,
      String windSpeedRaw,
      String windDirectionRaw,
      String shortForecast});
}

/// @nodoc
class _$ForecastPeriodCopyWithImpl<$Res, $Val extends ForecastPeriod>
    implements $ForecastPeriodCopyWith<$Res> {
  _$ForecastPeriodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startTime = null,
    Object? endTime = null,
    Object? temperature = null,
    Object? temperatureUnit = null,
    Object? windSpeedRaw = null,
    Object? windDirectionRaw = null,
    Object? shortForecast = null,
  }) {
    return _then(_value.copyWith(
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      temperature: null == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as double,
      temperatureUnit: null == temperatureUnit
          ? _value.temperatureUnit
          : temperatureUnit // ignore: cast_nullable_to_non_nullable
              as String,
      windSpeedRaw: null == windSpeedRaw
          ? _value.windSpeedRaw
          : windSpeedRaw // ignore: cast_nullable_to_non_nullable
              as String,
      windDirectionRaw: null == windDirectionRaw
          ? _value.windDirectionRaw
          : windDirectionRaw // ignore: cast_nullable_to_non_nullable
              as String,
      shortForecast: null == shortForecast
          ? _value.shortForecast
          : shortForecast // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ForecastPeriodImplCopyWith<$Res>
    implements $ForecastPeriodCopyWith<$Res> {
  factory _$$ForecastPeriodImplCopyWith(_$ForecastPeriodImpl value,
          $Res Function(_$ForecastPeriodImpl) then) =
      __$$ForecastPeriodImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime startTime,
      DateTime endTime,
      double temperature,
      String temperatureUnit,
      String windSpeedRaw,
      String windDirectionRaw,
      String shortForecast});
}

/// @nodoc
class __$$ForecastPeriodImplCopyWithImpl<$Res>
    extends _$ForecastPeriodCopyWithImpl<$Res, _$ForecastPeriodImpl>
    implements _$$ForecastPeriodImplCopyWith<$Res> {
  __$$ForecastPeriodImplCopyWithImpl(
      _$ForecastPeriodImpl _value, $Res Function(_$ForecastPeriodImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startTime = null,
    Object? endTime = null,
    Object? temperature = null,
    Object? temperatureUnit = null,
    Object? windSpeedRaw = null,
    Object? windDirectionRaw = null,
    Object? shortForecast = null,
  }) {
    return _then(_$ForecastPeriodImpl(
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      temperature: null == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as double,
      temperatureUnit: null == temperatureUnit
          ? _value.temperatureUnit
          : temperatureUnit // ignore: cast_nullable_to_non_nullable
              as String,
      windSpeedRaw: null == windSpeedRaw
          ? _value.windSpeedRaw
          : windSpeedRaw // ignore: cast_nullable_to_non_nullable
              as String,
      windDirectionRaw: null == windDirectionRaw
          ? _value.windDirectionRaw
          : windDirectionRaw // ignore: cast_nullable_to_non_nullable
              as String,
      shortForecast: null == shortForecast
          ? _value.shortForecast
          : shortForecast // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ForecastPeriodImpl implements _ForecastPeriod {
  const _$ForecastPeriodImpl(
      {required this.startTime,
      required this.endTime,
      required this.temperature,
      required this.temperatureUnit,
      required this.windSpeedRaw,
      required this.windDirectionRaw,
      required this.shortForecast});

  factory _$ForecastPeriodImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForecastPeriodImplFromJson(json);

  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  final double temperature;
  @override
  final String temperatureUnit;
  @override
  final String windSpeedRaw;
  @override
  final String windDirectionRaw;
  @override
  final String shortForecast;

  @override
  String toString() {
    return 'ForecastPeriod(startTime: $startTime, endTime: $endTime, temperature: $temperature, temperatureUnit: $temperatureUnit, windSpeedRaw: $windSpeedRaw, windDirectionRaw: $windDirectionRaw, shortForecast: $shortForecast)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForecastPeriodImpl &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            (identical(other.temperatureUnit, temperatureUnit) ||
                other.temperatureUnit == temperatureUnit) &&
            (identical(other.windSpeedRaw, windSpeedRaw) ||
                other.windSpeedRaw == windSpeedRaw) &&
            (identical(other.windDirectionRaw, windDirectionRaw) ||
                other.windDirectionRaw == windDirectionRaw) &&
            (identical(other.shortForecast, shortForecast) ||
                other.shortForecast == shortForecast));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, startTime, endTime, temperature,
      temperatureUnit, windSpeedRaw, windDirectionRaw, shortForecast);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ForecastPeriodImplCopyWith<_$ForecastPeriodImpl> get copyWith =>
      __$$ForecastPeriodImplCopyWithImpl<_$ForecastPeriodImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ForecastPeriodImplToJson(
      this,
    );
  }
}

abstract class _ForecastPeriod implements ForecastPeriod {
  const factory _ForecastPeriod(
      {required final DateTime startTime,
      required final DateTime endTime,
      required final double temperature,
      required final String temperatureUnit,
      required final String windSpeedRaw,
      required final String windDirectionRaw,
      required final String shortForecast}) = _$ForecastPeriodImpl;

  factory _ForecastPeriod.fromJson(Map<String, dynamic> json) =
      _$ForecastPeriodImpl.fromJson;

  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  double get temperature;
  @override
  String get temperatureUnit;
  @override
  String get windSpeedRaw;
  @override
  String get windDirectionRaw;
  @override
  String get shortForecast;
  @override
  @JsonKey(ignore: true)
  _$$ForecastPeriodImplCopyWith<_$ForecastPeriodImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
