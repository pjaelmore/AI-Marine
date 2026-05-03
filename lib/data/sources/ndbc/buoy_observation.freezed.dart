// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'buoy_observation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BuoyObservation _$BuoyObservationFromJson(Map<String, dynamic> json) {
  return _BuoyObservation.fromJson(json);
}

/// @nodoc
mixin _$BuoyObservation {
  String get stationId => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  double? get waterTempC => throw _privateConstructorUsedError;
  double? get airTempC => throw _privateConstructorUsedError;
  double? get windDirDegT => throw _privateConstructorUsedError;
  double? get windSpeedMps => throw _privateConstructorUsedError;
  double? get gustMps => throw _privateConstructorUsedError;
  double? get waveHeightM => throw _privateConstructorUsedError;
  double? get dominantPeriodSec => throw _privateConstructorUsedError;
  double? get pressureHpa => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BuoyObservationCopyWith<BuoyObservation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BuoyObservationCopyWith<$Res> {
  factory $BuoyObservationCopyWith(
          BuoyObservation value, $Res Function(BuoyObservation) then) =
      _$BuoyObservationCopyWithImpl<$Res, BuoyObservation>;
  @useResult
  $Res call(
      {String stationId,
      DateTime timestamp,
      double? waterTempC,
      double? airTempC,
      double? windDirDegT,
      double? windSpeedMps,
      double? gustMps,
      double? waveHeightM,
      double? dominantPeriodSec,
      double? pressureHpa});
}

/// @nodoc
class _$BuoyObservationCopyWithImpl<$Res, $Val extends BuoyObservation>
    implements $BuoyObservationCopyWith<$Res> {
  _$BuoyObservationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stationId = null,
    Object? timestamp = null,
    Object? waterTempC = freezed,
    Object? airTempC = freezed,
    Object? windDirDegT = freezed,
    Object? windSpeedMps = freezed,
    Object? gustMps = freezed,
    Object? waveHeightM = freezed,
    Object? dominantPeriodSec = freezed,
    Object? pressureHpa = freezed,
  }) {
    return _then(_value.copyWith(
      stationId: null == stationId
          ? _value.stationId
          : stationId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      waterTempC: freezed == waterTempC
          ? _value.waterTempC
          : waterTempC // ignore: cast_nullable_to_non_nullable
              as double?,
      airTempC: freezed == airTempC
          ? _value.airTempC
          : airTempC // ignore: cast_nullable_to_non_nullable
              as double?,
      windDirDegT: freezed == windDirDegT
          ? _value.windDirDegT
          : windDirDegT // ignore: cast_nullable_to_non_nullable
              as double?,
      windSpeedMps: freezed == windSpeedMps
          ? _value.windSpeedMps
          : windSpeedMps // ignore: cast_nullable_to_non_nullable
              as double?,
      gustMps: freezed == gustMps
          ? _value.gustMps
          : gustMps // ignore: cast_nullable_to_non_nullable
              as double?,
      waveHeightM: freezed == waveHeightM
          ? _value.waveHeightM
          : waveHeightM // ignore: cast_nullable_to_non_nullable
              as double?,
      dominantPeriodSec: freezed == dominantPeriodSec
          ? _value.dominantPeriodSec
          : dominantPeriodSec // ignore: cast_nullable_to_non_nullable
              as double?,
      pressureHpa: freezed == pressureHpa
          ? _value.pressureHpa
          : pressureHpa // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BuoyObservationImplCopyWith<$Res>
    implements $BuoyObservationCopyWith<$Res> {
  factory _$$BuoyObservationImplCopyWith(_$BuoyObservationImpl value,
          $Res Function(_$BuoyObservationImpl) then) =
      __$$BuoyObservationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String stationId,
      DateTime timestamp,
      double? waterTempC,
      double? airTempC,
      double? windDirDegT,
      double? windSpeedMps,
      double? gustMps,
      double? waveHeightM,
      double? dominantPeriodSec,
      double? pressureHpa});
}

/// @nodoc
class __$$BuoyObservationImplCopyWithImpl<$Res>
    extends _$BuoyObservationCopyWithImpl<$Res, _$BuoyObservationImpl>
    implements _$$BuoyObservationImplCopyWith<$Res> {
  __$$BuoyObservationImplCopyWithImpl(
      _$BuoyObservationImpl _value, $Res Function(_$BuoyObservationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stationId = null,
    Object? timestamp = null,
    Object? waterTempC = freezed,
    Object? airTempC = freezed,
    Object? windDirDegT = freezed,
    Object? windSpeedMps = freezed,
    Object? gustMps = freezed,
    Object? waveHeightM = freezed,
    Object? dominantPeriodSec = freezed,
    Object? pressureHpa = freezed,
  }) {
    return _then(_$BuoyObservationImpl(
      stationId: null == stationId
          ? _value.stationId
          : stationId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      waterTempC: freezed == waterTempC
          ? _value.waterTempC
          : waterTempC // ignore: cast_nullable_to_non_nullable
              as double?,
      airTempC: freezed == airTempC
          ? _value.airTempC
          : airTempC // ignore: cast_nullable_to_non_nullable
              as double?,
      windDirDegT: freezed == windDirDegT
          ? _value.windDirDegT
          : windDirDegT // ignore: cast_nullable_to_non_nullable
              as double?,
      windSpeedMps: freezed == windSpeedMps
          ? _value.windSpeedMps
          : windSpeedMps // ignore: cast_nullable_to_non_nullable
              as double?,
      gustMps: freezed == gustMps
          ? _value.gustMps
          : gustMps // ignore: cast_nullable_to_non_nullable
              as double?,
      waveHeightM: freezed == waveHeightM
          ? _value.waveHeightM
          : waveHeightM // ignore: cast_nullable_to_non_nullable
              as double?,
      dominantPeriodSec: freezed == dominantPeriodSec
          ? _value.dominantPeriodSec
          : dominantPeriodSec // ignore: cast_nullable_to_non_nullable
              as double?,
      pressureHpa: freezed == pressureHpa
          ? _value.pressureHpa
          : pressureHpa // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BuoyObservationImpl implements _BuoyObservation {
  const _$BuoyObservationImpl(
      {required this.stationId,
      required this.timestamp,
      this.waterTempC,
      this.airTempC,
      this.windDirDegT,
      this.windSpeedMps,
      this.gustMps,
      this.waveHeightM,
      this.dominantPeriodSec,
      this.pressureHpa});

  factory _$BuoyObservationImpl.fromJson(Map<String, dynamic> json) =>
      _$$BuoyObservationImplFromJson(json);

  @override
  final String stationId;
  @override
  final DateTime timestamp;
  @override
  final double? waterTempC;
  @override
  final double? airTempC;
  @override
  final double? windDirDegT;
  @override
  final double? windSpeedMps;
  @override
  final double? gustMps;
  @override
  final double? waveHeightM;
  @override
  final double? dominantPeriodSec;
  @override
  final double? pressureHpa;

  @override
  String toString() {
    return 'BuoyObservation(stationId: $stationId, timestamp: $timestamp, waterTempC: $waterTempC, airTempC: $airTempC, windDirDegT: $windDirDegT, windSpeedMps: $windSpeedMps, gustMps: $gustMps, waveHeightM: $waveHeightM, dominantPeriodSec: $dominantPeriodSec, pressureHpa: $pressureHpa)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BuoyObservationImpl &&
            (identical(other.stationId, stationId) ||
                other.stationId == stationId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.waterTempC, waterTempC) ||
                other.waterTempC == waterTempC) &&
            (identical(other.airTempC, airTempC) ||
                other.airTempC == airTempC) &&
            (identical(other.windDirDegT, windDirDegT) ||
                other.windDirDegT == windDirDegT) &&
            (identical(other.windSpeedMps, windSpeedMps) ||
                other.windSpeedMps == windSpeedMps) &&
            (identical(other.gustMps, gustMps) || other.gustMps == gustMps) &&
            (identical(other.waveHeightM, waveHeightM) ||
                other.waveHeightM == waveHeightM) &&
            (identical(other.dominantPeriodSec, dominantPeriodSec) ||
                other.dominantPeriodSec == dominantPeriodSec) &&
            (identical(other.pressureHpa, pressureHpa) ||
                other.pressureHpa == pressureHpa));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      stationId,
      timestamp,
      waterTempC,
      airTempC,
      windDirDegT,
      windSpeedMps,
      gustMps,
      waveHeightM,
      dominantPeriodSec,
      pressureHpa);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BuoyObservationImplCopyWith<_$BuoyObservationImpl> get copyWith =>
      __$$BuoyObservationImplCopyWithImpl<_$BuoyObservationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BuoyObservationImplToJson(
      this,
    );
  }
}

abstract class _BuoyObservation implements BuoyObservation {
  const factory _BuoyObservation(
      {required final String stationId,
      required final DateTime timestamp,
      final double? waterTempC,
      final double? airTempC,
      final double? windDirDegT,
      final double? windSpeedMps,
      final double? gustMps,
      final double? waveHeightM,
      final double? dominantPeriodSec,
      final double? pressureHpa}) = _$BuoyObservationImpl;

  factory _BuoyObservation.fromJson(Map<String, dynamic> json) =
      _$BuoyObservationImpl.fromJson;

  @override
  String get stationId;
  @override
  DateTime get timestamp;
  @override
  double? get waterTempC;
  @override
  double? get airTempC;
  @override
  double? get windDirDegT;
  @override
  double? get windSpeedMps;
  @override
  double? get gustMps;
  @override
  double? get waveHeightM;
  @override
  double? get dominantPeriodSec;
  @override
  double? get pressureHpa;
  @override
  @JsonKey(ignore: true)
  _$$BuoyObservationImplCopyWith<_$BuoyObservationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
