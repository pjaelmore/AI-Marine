// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conditions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TideState _$TideStateFromJson(Map<String, dynamic> json) {
  return _TideState.fromJson(json);
}

/// @nodoc
mixin _$TideState {
  TidePhase get phase => throw _privateConstructorUsedError;
  Duration get toNextChange => throw _privateConstructorUsedError;
  double? get amplitudeFt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TideStateCopyWith<TideState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TideStateCopyWith<$Res> {
  factory $TideStateCopyWith(TideState value, $Res Function(TideState) then) =
      _$TideStateCopyWithImpl<$Res, TideState>;
  @useResult
  $Res call({TidePhase phase, Duration toNextChange, double? amplitudeFt});
}

/// @nodoc
class _$TideStateCopyWithImpl<$Res, $Val extends TideState>
    implements $TideStateCopyWith<$Res> {
  _$TideStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phase = null,
    Object? toNextChange = null,
    Object? amplitudeFt = freezed,
  }) {
    return _then(_value.copyWith(
      phase: null == phase
          ? _value.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as TidePhase,
      toNextChange: null == toNextChange
          ? _value.toNextChange
          : toNextChange // ignore: cast_nullable_to_non_nullable
              as Duration,
      amplitudeFt: freezed == amplitudeFt
          ? _value.amplitudeFt
          : amplitudeFt // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TideStateImplCopyWith<$Res>
    implements $TideStateCopyWith<$Res> {
  factory _$$TideStateImplCopyWith(
          _$TideStateImpl value, $Res Function(_$TideStateImpl) then) =
      __$$TideStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TidePhase phase, Duration toNextChange, double? amplitudeFt});
}

/// @nodoc
class __$$TideStateImplCopyWithImpl<$Res>
    extends _$TideStateCopyWithImpl<$Res, _$TideStateImpl>
    implements _$$TideStateImplCopyWith<$Res> {
  __$$TideStateImplCopyWithImpl(
      _$TideStateImpl _value, $Res Function(_$TideStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phase = null,
    Object? toNextChange = null,
    Object? amplitudeFt = freezed,
  }) {
    return _then(_$TideStateImpl(
      phase: null == phase
          ? _value.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as TidePhase,
      toNextChange: null == toNextChange
          ? _value.toNextChange
          : toNextChange // ignore: cast_nullable_to_non_nullable
              as Duration,
      amplitudeFt: freezed == amplitudeFt
          ? _value.amplitudeFt
          : amplitudeFt // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TideStateImpl implements _TideState {
  const _$TideStateImpl(
      {required this.phase, required this.toNextChange, this.amplitudeFt});

  factory _$TideStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$TideStateImplFromJson(json);

  @override
  final TidePhase phase;
  @override
  final Duration toNextChange;
  @override
  final double? amplitudeFt;

  @override
  String toString() {
    return 'TideState(phase: $phase, toNextChange: $toNextChange, amplitudeFt: $amplitudeFt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TideStateImpl &&
            (identical(other.phase, phase) || other.phase == phase) &&
            (identical(other.toNextChange, toNextChange) ||
                other.toNextChange == toNextChange) &&
            (identical(other.amplitudeFt, amplitudeFt) ||
                other.amplitudeFt == amplitudeFt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, phase, toNextChange, amplitudeFt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TideStateImplCopyWith<_$TideStateImpl> get copyWith =>
      __$$TideStateImplCopyWithImpl<_$TideStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TideStateImplToJson(
      this,
    );
  }
}

abstract class _TideState implements TideState {
  const factory _TideState(
      {required final TidePhase phase,
      required final Duration toNextChange,
      final double? amplitudeFt}) = _$TideStateImpl;

  factory _TideState.fromJson(Map<String, dynamic> json) =
      _$TideStateImpl.fromJson;

  @override
  TidePhase get phase;
  @override
  Duration get toNextChange;
  @override
  double? get amplitudeFt;
  @override
  @JsonKey(ignore: true)
  _$$TideStateImplCopyWith<_$TideStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CurrentVector _$CurrentVectorFromJson(Map<String, dynamic> json) {
  return _CurrentVector.fromJson(json);
}

/// @nodoc
mixin _$CurrentVector {
  double get speedKnots => throw _privateConstructorUsedError;
  double get directionDegrees => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CurrentVectorCopyWith<CurrentVector> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrentVectorCopyWith<$Res> {
  factory $CurrentVectorCopyWith(
          CurrentVector value, $Res Function(CurrentVector) then) =
      _$CurrentVectorCopyWithImpl<$Res, CurrentVector>;
  @useResult
  $Res call({double speedKnots, double directionDegrees});
}

/// @nodoc
class _$CurrentVectorCopyWithImpl<$Res, $Val extends CurrentVector>
    implements $CurrentVectorCopyWith<$Res> {
  _$CurrentVectorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? speedKnots = null,
    Object? directionDegrees = null,
  }) {
    return _then(_value.copyWith(
      speedKnots: null == speedKnots
          ? _value.speedKnots
          : speedKnots // ignore: cast_nullable_to_non_nullable
              as double,
      directionDegrees: null == directionDegrees
          ? _value.directionDegrees
          : directionDegrees // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CurrentVectorImplCopyWith<$Res>
    implements $CurrentVectorCopyWith<$Res> {
  factory _$$CurrentVectorImplCopyWith(
          _$CurrentVectorImpl value, $Res Function(_$CurrentVectorImpl) then) =
      __$$CurrentVectorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double speedKnots, double directionDegrees});
}

/// @nodoc
class __$$CurrentVectorImplCopyWithImpl<$Res>
    extends _$CurrentVectorCopyWithImpl<$Res, _$CurrentVectorImpl>
    implements _$$CurrentVectorImplCopyWith<$Res> {
  __$$CurrentVectorImplCopyWithImpl(
      _$CurrentVectorImpl _value, $Res Function(_$CurrentVectorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? speedKnots = null,
    Object? directionDegrees = null,
  }) {
    return _then(_$CurrentVectorImpl(
      speedKnots: null == speedKnots
          ? _value.speedKnots
          : speedKnots // ignore: cast_nullable_to_non_nullable
              as double,
      directionDegrees: null == directionDegrees
          ? _value.directionDegrees
          : directionDegrees // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CurrentVectorImpl implements _CurrentVector {
  const _$CurrentVectorImpl(
      {required this.speedKnots, required this.directionDegrees});

  factory _$CurrentVectorImpl.fromJson(Map<String, dynamic> json) =>
      _$$CurrentVectorImplFromJson(json);

  @override
  final double speedKnots;
  @override
  final double directionDegrees;

  @override
  String toString() {
    return 'CurrentVector(speedKnots: $speedKnots, directionDegrees: $directionDegrees)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CurrentVectorImpl &&
            (identical(other.speedKnots, speedKnots) ||
                other.speedKnots == speedKnots) &&
            (identical(other.directionDegrees, directionDegrees) ||
                other.directionDegrees == directionDegrees));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, speedKnots, directionDegrees);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CurrentVectorImplCopyWith<_$CurrentVectorImpl> get copyWith =>
      __$$CurrentVectorImplCopyWithImpl<_$CurrentVectorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CurrentVectorImplToJson(
      this,
    );
  }
}

abstract class _CurrentVector implements CurrentVector {
  const factory _CurrentVector(
      {required final double speedKnots,
      required final double directionDegrees}) = _$CurrentVectorImpl;

  factory _CurrentVector.fromJson(Map<String, dynamic> json) =
      _$CurrentVectorImpl.fromJson;

  @override
  double get speedKnots;
  @override
  double get directionDegrees;
  @override
  @JsonKey(ignore: true)
  _$$CurrentVectorImplCopyWith<_$CurrentVectorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WindVector _$WindVectorFromJson(Map<String, dynamic> json) {
  return _WindVector.fromJson(json);
}

/// @nodoc
mixin _$WindVector {
  double get speedKnots => throw _privateConstructorUsedError;
  double get directionDegrees => throw _privateConstructorUsedError;
  double? get gustsKnots => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WindVectorCopyWith<WindVector> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WindVectorCopyWith<$Res> {
  factory $WindVectorCopyWith(
          WindVector value, $Res Function(WindVector) then) =
      _$WindVectorCopyWithImpl<$Res, WindVector>;
  @useResult
  $Res call({double speedKnots, double directionDegrees, double? gustsKnots});
}

/// @nodoc
class _$WindVectorCopyWithImpl<$Res, $Val extends WindVector>
    implements $WindVectorCopyWith<$Res> {
  _$WindVectorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? speedKnots = null,
    Object? directionDegrees = null,
    Object? gustsKnots = freezed,
  }) {
    return _then(_value.copyWith(
      speedKnots: null == speedKnots
          ? _value.speedKnots
          : speedKnots // ignore: cast_nullable_to_non_nullable
              as double,
      directionDegrees: null == directionDegrees
          ? _value.directionDegrees
          : directionDegrees // ignore: cast_nullable_to_non_nullable
              as double,
      gustsKnots: freezed == gustsKnots
          ? _value.gustsKnots
          : gustsKnots // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WindVectorImplCopyWith<$Res>
    implements $WindVectorCopyWith<$Res> {
  factory _$$WindVectorImplCopyWith(
          _$WindVectorImpl value, $Res Function(_$WindVectorImpl) then) =
      __$$WindVectorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double speedKnots, double directionDegrees, double? gustsKnots});
}

/// @nodoc
class __$$WindVectorImplCopyWithImpl<$Res>
    extends _$WindVectorCopyWithImpl<$Res, _$WindVectorImpl>
    implements _$$WindVectorImplCopyWith<$Res> {
  __$$WindVectorImplCopyWithImpl(
      _$WindVectorImpl _value, $Res Function(_$WindVectorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? speedKnots = null,
    Object? directionDegrees = null,
    Object? gustsKnots = freezed,
  }) {
    return _then(_$WindVectorImpl(
      speedKnots: null == speedKnots
          ? _value.speedKnots
          : speedKnots // ignore: cast_nullable_to_non_nullable
              as double,
      directionDegrees: null == directionDegrees
          ? _value.directionDegrees
          : directionDegrees // ignore: cast_nullable_to_non_nullable
              as double,
      gustsKnots: freezed == gustsKnots
          ? _value.gustsKnots
          : gustsKnots // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WindVectorImpl implements _WindVector {
  const _$WindVectorImpl(
      {required this.speedKnots,
      required this.directionDegrees,
      this.gustsKnots});

  factory _$WindVectorImpl.fromJson(Map<String, dynamic> json) =>
      _$$WindVectorImplFromJson(json);

  @override
  final double speedKnots;
  @override
  final double directionDegrees;
  @override
  final double? gustsKnots;

  @override
  String toString() {
    return 'WindVector(speedKnots: $speedKnots, directionDegrees: $directionDegrees, gustsKnots: $gustsKnots)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WindVectorImpl &&
            (identical(other.speedKnots, speedKnots) ||
                other.speedKnots == speedKnots) &&
            (identical(other.directionDegrees, directionDegrees) ||
                other.directionDegrees == directionDegrees) &&
            (identical(other.gustsKnots, gustsKnots) ||
                other.gustsKnots == gustsKnots));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, speedKnots, directionDegrees, gustsKnots);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WindVectorImplCopyWith<_$WindVectorImpl> get copyWith =>
      __$$WindVectorImplCopyWithImpl<_$WindVectorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WindVectorImplToJson(
      this,
    );
  }
}

abstract class _WindVector implements WindVector {
  const factory _WindVector(
      {required final double speedKnots,
      required final double directionDegrees,
      final double? gustsKnots}) = _$WindVectorImpl;

  factory _WindVector.fromJson(Map<String, dynamic> json) =
      _$WindVectorImpl.fromJson;

  @override
  double get speedKnots;
  @override
  double get directionDegrees;
  @override
  double? get gustsKnots;
  @override
  @JsonKey(ignore: true)
  _$$WindVectorImplCopyWith<_$WindVectorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WaveState _$WaveStateFromJson(Map<String, dynamic> json) {
  return _WaveState.fromJson(json);
}

/// @nodoc
mixin _$WaveState {
  double get significantHeightFt => throw _privateConstructorUsedError;
  double? get dominantPeriodSec => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WaveStateCopyWith<WaveState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WaveStateCopyWith<$Res> {
  factory $WaveStateCopyWith(WaveState value, $Res Function(WaveState) then) =
      _$WaveStateCopyWithImpl<$Res, WaveState>;
  @useResult
  $Res call({double significantHeightFt, double? dominantPeriodSec});
}

/// @nodoc
class _$WaveStateCopyWithImpl<$Res, $Val extends WaveState>
    implements $WaveStateCopyWith<$Res> {
  _$WaveStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? significantHeightFt = null,
    Object? dominantPeriodSec = freezed,
  }) {
    return _then(_value.copyWith(
      significantHeightFt: null == significantHeightFt
          ? _value.significantHeightFt
          : significantHeightFt // ignore: cast_nullable_to_non_nullable
              as double,
      dominantPeriodSec: freezed == dominantPeriodSec
          ? _value.dominantPeriodSec
          : dominantPeriodSec // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WaveStateImplCopyWith<$Res>
    implements $WaveStateCopyWith<$Res> {
  factory _$$WaveStateImplCopyWith(
          _$WaveStateImpl value, $Res Function(_$WaveStateImpl) then) =
      __$$WaveStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double significantHeightFt, double? dominantPeriodSec});
}

/// @nodoc
class __$$WaveStateImplCopyWithImpl<$Res>
    extends _$WaveStateCopyWithImpl<$Res, _$WaveStateImpl>
    implements _$$WaveStateImplCopyWith<$Res> {
  __$$WaveStateImplCopyWithImpl(
      _$WaveStateImpl _value, $Res Function(_$WaveStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? significantHeightFt = null,
    Object? dominantPeriodSec = freezed,
  }) {
    return _then(_$WaveStateImpl(
      significantHeightFt: null == significantHeightFt
          ? _value.significantHeightFt
          : significantHeightFt // ignore: cast_nullable_to_non_nullable
              as double,
      dominantPeriodSec: freezed == dominantPeriodSec
          ? _value.dominantPeriodSec
          : dominantPeriodSec // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WaveStateImpl implements _WaveState {
  const _$WaveStateImpl(
      {required this.significantHeightFt, this.dominantPeriodSec});

  factory _$WaveStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$WaveStateImplFromJson(json);

  @override
  final double significantHeightFt;
  @override
  final double? dominantPeriodSec;

  @override
  String toString() {
    return 'WaveState(significantHeightFt: $significantHeightFt, dominantPeriodSec: $dominantPeriodSec)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WaveStateImpl &&
            (identical(other.significantHeightFt, significantHeightFt) ||
                other.significantHeightFt == significantHeightFt) &&
            (identical(other.dominantPeriodSec, dominantPeriodSec) ||
                other.dominantPeriodSec == dominantPeriodSec));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, significantHeightFt, dominantPeriodSec);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WaveStateImplCopyWith<_$WaveStateImpl> get copyWith =>
      __$$WaveStateImplCopyWithImpl<_$WaveStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WaveStateImplToJson(
      this,
    );
  }
}

abstract class _WaveState implements WaveState {
  const factory _WaveState(
      {required final double significantHeightFt,
      final double? dominantPeriodSec}) = _$WaveStateImpl;

  factory _WaveState.fromJson(Map<String, dynamic> json) =
      _$WaveStateImpl.fromJson;

  @override
  double get significantHeightFt;
  @override
  double? get dominantPeriodSec;
  @override
  @JsonKey(ignore: true)
  _$$WaveStateImplCopyWith<_$WaveStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SolunarWindow _$SolunarWindowFromJson(Map<String, dynamic> json) {
  return _SolunarWindow.fromJson(json);
}

/// @nodoc
mixin _$SolunarWindow {
  DateTime get start => throw _privateConstructorUsedError;
  DateTime get end => throw _privateConstructorUsedError;
  SolunarStrength get strength => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SolunarWindowCopyWith<SolunarWindow> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SolunarWindowCopyWith<$Res> {
  factory $SolunarWindowCopyWith(
          SolunarWindow value, $Res Function(SolunarWindow) then) =
      _$SolunarWindowCopyWithImpl<$Res, SolunarWindow>;
  @useResult
  $Res call({DateTime start, DateTime end, SolunarStrength strength});
}

/// @nodoc
class _$SolunarWindowCopyWithImpl<$Res, $Val extends SolunarWindow>
    implements $SolunarWindowCopyWith<$Res> {
  _$SolunarWindowCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = null,
    Object? strength = null,
  }) {
    return _then(_value.copyWith(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime,
      strength: null == strength
          ? _value.strength
          : strength // ignore: cast_nullable_to_non_nullable
              as SolunarStrength,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SolunarWindowImplCopyWith<$Res>
    implements $SolunarWindowCopyWith<$Res> {
  factory _$$SolunarWindowImplCopyWith(
          _$SolunarWindowImpl value, $Res Function(_$SolunarWindowImpl) then) =
      __$$SolunarWindowImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime start, DateTime end, SolunarStrength strength});
}

/// @nodoc
class __$$SolunarWindowImplCopyWithImpl<$Res>
    extends _$SolunarWindowCopyWithImpl<$Res, _$SolunarWindowImpl>
    implements _$$SolunarWindowImplCopyWith<$Res> {
  __$$SolunarWindowImplCopyWithImpl(
      _$SolunarWindowImpl _value, $Res Function(_$SolunarWindowImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = null,
    Object? strength = null,
  }) {
    return _then(_$SolunarWindowImpl(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime,
      strength: null == strength
          ? _value.strength
          : strength // ignore: cast_nullable_to_non_nullable
              as SolunarStrength,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SolunarWindowImpl extends _SolunarWindow {
  const _$SolunarWindowImpl(
      {required this.start, required this.end, required this.strength})
      : super._();

  factory _$SolunarWindowImpl.fromJson(Map<String, dynamic> json) =>
      _$$SolunarWindowImplFromJson(json);

  @override
  final DateTime start;
  @override
  final DateTime end;
  @override
  final SolunarStrength strength;

  @override
  String toString() {
    return 'SolunarWindow(start: $start, end: $end, strength: $strength)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SolunarWindowImpl &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.strength, strength) ||
                other.strength == strength));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, start, end, strength);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SolunarWindowImplCopyWith<_$SolunarWindowImpl> get copyWith =>
      __$$SolunarWindowImplCopyWithImpl<_$SolunarWindowImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SolunarWindowImplToJson(
      this,
    );
  }
}

abstract class _SolunarWindow extends SolunarWindow {
  const factory _SolunarWindow(
      {required final DateTime start,
      required final DateTime end,
      required final SolunarStrength strength}) = _$SolunarWindowImpl;
  const _SolunarWindow._() : super._();

  factory _SolunarWindow.fromJson(Map<String, dynamic> json) =
      _$SolunarWindowImpl.fromJson;

  @override
  DateTime get start;
  @override
  DateTime get end;
  @override
  SolunarStrength get strength;
  @override
  @JsonKey(ignore: true)
  _$$SolunarWindowImplCopyWith<_$SolunarWindowImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SolunarState _$SolunarStateFromJson(Map<String, dynamic> json) {
  return _SolunarState.fromJson(json);
}

/// @nodoc
mixin _$SolunarState {
  double get sunAltitudeDegrees => throw _privateConstructorUsedError;
  double get sunAzimuthDegrees => throw _privateConstructorUsedError;
  MoonPhase get moonPhase => throw _privateConstructorUsedError;
  double get moonIlluminationFraction => throw _privateConstructorUsedError;
  SolunarWindow? get majorWindow => throw _privateConstructorUsedError;
  SolunarWindow? get minorWindow => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SolunarStateCopyWith<SolunarState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SolunarStateCopyWith<$Res> {
  factory $SolunarStateCopyWith(
          SolunarState value, $Res Function(SolunarState) then) =
      _$SolunarStateCopyWithImpl<$Res, SolunarState>;
  @useResult
  $Res call(
      {double sunAltitudeDegrees,
      double sunAzimuthDegrees,
      MoonPhase moonPhase,
      double moonIlluminationFraction,
      SolunarWindow? majorWindow,
      SolunarWindow? minorWindow});

  $SolunarWindowCopyWith<$Res>? get majorWindow;
  $SolunarWindowCopyWith<$Res>? get minorWindow;
}

/// @nodoc
class _$SolunarStateCopyWithImpl<$Res, $Val extends SolunarState>
    implements $SolunarStateCopyWith<$Res> {
  _$SolunarStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sunAltitudeDegrees = null,
    Object? sunAzimuthDegrees = null,
    Object? moonPhase = null,
    Object? moonIlluminationFraction = null,
    Object? majorWindow = freezed,
    Object? minorWindow = freezed,
  }) {
    return _then(_value.copyWith(
      sunAltitudeDegrees: null == sunAltitudeDegrees
          ? _value.sunAltitudeDegrees
          : sunAltitudeDegrees // ignore: cast_nullable_to_non_nullable
              as double,
      sunAzimuthDegrees: null == sunAzimuthDegrees
          ? _value.sunAzimuthDegrees
          : sunAzimuthDegrees // ignore: cast_nullable_to_non_nullable
              as double,
      moonPhase: null == moonPhase
          ? _value.moonPhase
          : moonPhase // ignore: cast_nullable_to_non_nullable
              as MoonPhase,
      moonIlluminationFraction: null == moonIlluminationFraction
          ? _value.moonIlluminationFraction
          : moonIlluminationFraction // ignore: cast_nullable_to_non_nullable
              as double,
      majorWindow: freezed == majorWindow
          ? _value.majorWindow
          : majorWindow // ignore: cast_nullable_to_non_nullable
              as SolunarWindow?,
      minorWindow: freezed == minorWindow
          ? _value.minorWindow
          : minorWindow // ignore: cast_nullable_to_non_nullable
              as SolunarWindow?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SolunarWindowCopyWith<$Res>? get majorWindow {
    if (_value.majorWindow == null) {
      return null;
    }

    return $SolunarWindowCopyWith<$Res>(_value.majorWindow!, (value) {
      return _then(_value.copyWith(majorWindow: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SolunarWindowCopyWith<$Res>? get minorWindow {
    if (_value.minorWindow == null) {
      return null;
    }

    return $SolunarWindowCopyWith<$Res>(_value.minorWindow!, (value) {
      return _then(_value.copyWith(minorWindow: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SolunarStateImplCopyWith<$Res>
    implements $SolunarStateCopyWith<$Res> {
  factory _$$SolunarStateImplCopyWith(
          _$SolunarStateImpl value, $Res Function(_$SolunarStateImpl) then) =
      __$$SolunarStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double sunAltitudeDegrees,
      double sunAzimuthDegrees,
      MoonPhase moonPhase,
      double moonIlluminationFraction,
      SolunarWindow? majorWindow,
      SolunarWindow? minorWindow});

  @override
  $SolunarWindowCopyWith<$Res>? get majorWindow;
  @override
  $SolunarWindowCopyWith<$Res>? get minorWindow;
}

/// @nodoc
class __$$SolunarStateImplCopyWithImpl<$Res>
    extends _$SolunarStateCopyWithImpl<$Res, _$SolunarStateImpl>
    implements _$$SolunarStateImplCopyWith<$Res> {
  __$$SolunarStateImplCopyWithImpl(
      _$SolunarStateImpl _value, $Res Function(_$SolunarStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sunAltitudeDegrees = null,
    Object? sunAzimuthDegrees = null,
    Object? moonPhase = null,
    Object? moonIlluminationFraction = null,
    Object? majorWindow = freezed,
    Object? minorWindow = freezed,
  }) {
    return _then(_$SolunarStateImpl(
      sunAltitudeDegrees: null == sunAltitudeDegrees
          ? _value.sunAltitudeDegrees
          : sunAltitudeDegrees // ignore: cast_nullable_to_non_nullable
              as double,
      sunAzimuthDegrees: null == sunAzimuthDegrees
          ? _value.sunAzimuthDegrees
          : sunAzimuthDegrees // ignore: cast_nullable_to_non_nullable
              as double,
      moonPhase: null == moonPhase
          ? _value.moonPhase
          : moonPhase // ignore: cast_nullable_to_non_nullable
              as MoonPhase,
      moonIlluminationFraction: null == moonIlluminationFraction
          ? _value.moonIlluminationFraction
          : moonIlluminationFraction // ignore: cast_nullable_to_non_nullable
              as double,
      majorWindow: freezed == majorWindow
          ? _value.majorWindow
          : majorWindow // ignore: cast_nullable_to_non_nullable
              as SolunarWindow?,
      minorWindow: freezed == minorWindow
          ? _value.minorWindow
          : minorWindow // ignore: cast_nullable_to_non_nullable
              as SolunarWindow?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SolunarStateImpl implements _SolunarState {
  const _$SolunarStateImpl(
      {required this.sunAltitudeDegrees,
      required this.sunAzimuthDegrees,
      required this.moonPhase,
      required this.moonIlluminationFraction,
      this.majorWindow,
      this.minorWindow});

  factory _$SolunarStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$SolunarStateImplFromJson(json);

  @override
  final double sunAltitudeDegrees;
  @override
  final double sunAzimuthDegrees;
  @override
  final MoonPhase moonPhase;
  @override
  final double moonIlluminationFraction;
  @override
  final SolunarWindow? majorWindow;
  @override
  final SolunarWindow? minorWindow;

  @override
  String toString() {
    return 'SolunarState(sunAltitudeDegrees: $sunAltitudeDegrees, sunAzimuthDegrees: $sunAzimuthDegrees, moonPhase: $moonPhase, moonIlluminationFraction: $moonIlluminationFraction, majorWindow: $majorWindow, minorWindow: $minorWindow)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SolunarStateImpl &&
            (identical(other.sunAltitudeDegrees, sunAltitudeDegrees) ||
                other.sunAltitudeDegrees == sunAltitudeDegrees) &&
            (identical(other.sunAzimuthDegrees, sunAzimuthDegrees) ||
                other.sunAzimuthDegrees == sunAzimuthDegrees) &&
            (identical(other.moonPhase, moonPhase) ||
                other.moonPhase == moonPhase) &&
            (identical(
                    other.moonIlluminationFraction, moonIlluminationFraction) ||
                other.moonIlluminationFraction == moonIlluminationFraction) &&
            (identical(other.majorWindow, majorWindow) ||
                other.majorWindow == majorWindow) &&
            (identical(other.minorWindow, minorWindow) ||
                other.minorWindow == minorWindow));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      sunAltitudeDegrees,
      sunAzimuthDegrees,
      moonPhase,
      moonIlluminationFraction,
      majorWindow,
      minorWindow);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SolunarStateImplCopyWith<_$SolunarStateImpl> get copyWith =>
      __$$SolunarStateImplCopyWithImpl<_$SolunarStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SolunarStateImplToJson(
      this,
    );
  }
}

abstract class _SolunarState implements SolunarState {
  const factory _SolunarState(
      {required final double sunAltitudeDegrees,
      required final double sunAzimuthDegrees,
      required final MoonPhase moonPhase,
      required final double moonIlluminationFraction,
      final SolunarWindow? majorWindow,
      final SolunarWindow? minorWindow}) = _$SolunarStateImpl;

  factory _SolunarState.fromJson(Map<String, dynamic> json) =
      _$SolunarStateImpl.fromJson;

  @override
  double get sunAltitudeDegrees;
  @override
  double get sunAzimuthDegrees;
  @override
  MoonPhase get moonPhase;
  @override
  double get moonIlluminationFraction;
  @override
  SolunarWindow? get majorWindow;
  @override
  SolunarWindow? get minorWindow;
  @override
  @JsonKey(ignore: true)
  _$$SolunarStateImplCopyWith<_$SolunarStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NamedFeature _$NamedFeatureFromJson(Map<String, dynamic> json) {
  return _NamedFeature.fromJson(json);
}

/// @nodoc
mixin _$NamedFeature {
  String get name => throw _privateConstructorUsedError;
  LatLng get location => throw _privateConstructorUsedError;
  double? get distanceM => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NamedFeatureCopyWith<NamedFeature> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NamedFeatureCopyWith<$Res> {
  factory $NamedFeatureCopyWith(
          NamedFeature value, $Res Function(NamedFeature) then) =
      _$NamedFeatureCopyWithImpl<$Res, NamedFeature>;
  @useResult
  $Res call({String name, LatLng location, double? distanceM});

  $LatLngCopyWith<$Res> get location;
}

/// @nodoc
class _$NamedFeatureCopyWithImpl<$Res, $Val extends NamedFeature>
    implements $NamedFeatureCopyWith<$Res> {
  _$NamedFeatureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? location = null,
    Object? distanceM = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LatLng,
      distanceM: freezed == distanceM
          ? _value.distanceM
          : distanceM // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LatLngCopyWith<$Res> get location {
    return $LatLngCopyWith<$Res>(_value.location, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NamedFeatureImplCopyWith<$Res>
    implements $NamedFeatureCopyWith<$Res> {
  factory _$$NamedFeatureImplCopyWith(
          _$NamedFeatureImpl value, $Res Function(_$NamedFeatureImpl) then) =
      __$$NamedFeatureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, LatLng location, double? distanceM});

  @override
  $LatLngCopyWith<$Res> get location;
}

/// @nodoc
class __$$NamedFeatureImplCopyWithImpl<$Res>
    extends _$NamedFeatureCopyWithImpl<$Res, _$NamedFeatureImpl>
    implements _$$NamedFeatureImplCopyWith<$Res> {
  __$$NamedFeatureImplCopyWithImpl(
      _$NamedFeatureImpl _value, $Res Function(_$NamedFeatureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? location = null,
    Object? distanceM = freezed,
  }) {
    return _then(_$NamedFeatureImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LatLng,
      distanceM: freezed == distanceM
          ? _value.distanceM
          : distanceM // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NamedFeatureImpl implements _NamedFeature {
  const _$NamedFeatureImpl(
      {required this.name, required this.location, this.distanceM});

  factory _$NamedFeatureImpl.fromJson(Map<String, dynamic> json) =>
      _$$NamedFeatureImplFromJson(json);

  @override
  final String name;
  @override
  final LatLng location;
  @override
  final double? distanceM;

  @override
  String toString() {
    return 'NamedFeature(name: $name, location: $location, distanceM: $distanceM)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NamedFeatureImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.distanceM, distanceM) ||
                other.distanceM == distanceM));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, location, distanceM);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NamedFeatureImplCopyWith<_$NamedFeatureImpl> get copyWith =>
      __$$NamedFeatureImplCopyWithImpl<_$NamedFeatureImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NamedFeatureImplToJson(
      this,
    );
  }
}

abstract class _NamedFeature implements NamedFeature {
  const factory _NamedFeature(
      {required final String name,
      required final LatLng location,
      final double? distanceM}) = _$NamedFeatureImpl;

  factory _NamedFeature.fromJson(Map<String, dynamic> json) =
      _$NamedFeatureImpl.fromJson;

  @override
  String get name;
  @override
  LatLng get location;
  @override
  double? get distanceM;
  @override
  @JsonKey(ignore: true)
  _$$NamedFeatureImplCopyWith<_$NamedFeatureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StructureInfo _$StructureInfoFromJson(Map<String, dynamic> json) {
  return _StructureInfo.fromJson(json);
}

/// @nodoc
mixin _$StructureInfo {
  StructureType get type => throw _privateConstructorUsedError;
  List<NamedFeature> get nearbyFeatures => throw _privateConstructorUsedError;
  double? get distanceToContourTransitionM =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StructureInfoCopyWith<StructureInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StructureInfoCopyWith<$Res> {
  factory $StructureInfoCopyWith(
          StructureInfo value, $Res Function(StructureInfo) then) =
      _$StructureInfoCopyWithImpl<$Res, StructureInfo>;
  @useResult
  $Res call(
      {StructureType type,
      List<NamedFeature> nearbyFeatures,
      double? distanceToContourTransitionM});
}

/// @nodoc
class _$StructureInfoCopyWithImpl<$Res, $Val extends StructureInfo>
    implements $StructureInfoCopyWith<$Res> {
  _$StructureInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? nearbyFeatures = null,
    Object? distanceToContourTransitionM = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as StructureType,
      nearbyFeatures: null == nearbyFeatures
          ? _value.nearbyFeatures
          : nearbyFeatures // ignore: cast_nullable_to_non_nullable
              as List<NamedFeature>,
      distanceToContourTransitionM: freezed == distanceToContourTransitionM
          ? _value.distanceToContourTransitionM
          : distanceToContourTransitionM // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StructureInfoImplCopyWith<$Res>
    implements $StructureInfoCopyWith<$Res> {
  factory _$$StructureInfoImplCopyWith(
          _$StructureInfoImpl value, $Res Function(_$StructureInfoImpl) then) =
      __$$StructureInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StructureType type,
      List<NamedFeature> nearbyFeatures,
      double? distanceToContourTransitionM});
}

/// @nodoc
class __$$StructureInfoImplCopyWithImpl<$Res>
    extends _$StructureInfoCopyWithImpl<$Res, _$StructureInfoImpl>
    implements _$$StructureInfoImplCopyWith<$Res> {
  __$$StructureInfoImplCopyWithImpl(
      _$StructureInfoImpl _value, $Res Function(_$StructureInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? nearbyFeatures = null,
    Object? distanceToContourTransitionM = freezed,
  }) {
    return _then(_$StructureInfoImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as StructureType,
      nearbyFeatures: null == nearbyFeatures
          ? _value._nearbyFeatures
          : nearbyFeatures // ignore: cast_nullable_to_non_nullable
              as List<NamedFeature>,
      distanceToContourTransitionM: freezed == distanceToContourTransitionM
          ? _value.distanceToContourTransitionM
          : distanceToContourTransitionM // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StructureInfoImpl implements _StructureInfo {
  const _$StructureInfoImpl(
      {required this.type,
      final List<NamedFeature> nearbyFeatures = const <NamedFeature>[],
      this.distanceToContourTransitionM})
      : _nearbyFeatures = nearbyFeatures;

  factory _$StructureInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$StructureInfoImplFromJson(json);

  @override
  final StructureType type;
  final List<NamedFeature> _nearbyFeatures;
  @override
  @JsonKey()
  List<NamedFeature> get nearbyFeatures {
    if (_nearbyFeatures is EqualUnmodifiableListView) return _nearbyFeatures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nearbyFeatures);
  }

  @override
  final double? distanceToContourTransitionM;

  @override
  String toString() {
    return 'StructureInfo(type: $type, nearbyFeatures: $nearbyFeatures, distanceToContourTransitionM: $distanceToContourTransitionM)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StructureInfoImpl &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality()
                .equals(other._nearbyFeatures, _nearbyFeatures) &&
            (identical(other.distanceToContourTransitionM,
                    distanceToContourTransitionM) ||
                other.distanceToContourTransitionM ==
                    distanceToContourTransitionM));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      const DeepCollectionEquality().hash(_nearbyFeatures),
      distanceToContourTransitionM);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StructureInfoImplCopyWith<_$StructureInfoImpl> get copyWith =>
      __$$StructureInfoImplCopyWithImpl<_$StructureInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StructureInfoImplToJson(
      this,
    );
  }
}

abstract class _StructureInfo implements StructureInfo {
  const factory _StructureInfo(
      {required final StructureType type,
      final List<NamedFeature> nearbyFeatures,
      final double? distanceToContourTransitionM}) = _$StructureInfoImpl;

  factory _StructureInfo.fromJson(Map<String, dynamic> json) =
      _$StructureInfoImpl.fromJson;

  @override
  StructureType get type;
  @override
  List<NamedFeature> get nearbyFeatures;
  @override
  double? get distanceToContourTransitionM;
  @override
  @JsonKey(ignore: true)
  _$$StructureInfoImplCopyWith<_$StructureInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BarometricState _$BarometricStateFromJson(Map<String, dynamic> json) {
  return _BarometricState.fromJson(json);
}

/// @nodoc
mixin _$BarometricState {
  double get pressureMillibars => throw _privateConstructorUsedError;
  BarometricTrend get trend => throw _privateConstructorUsedError;
  double get rateOfChangeMillibarsPerHour => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BarometricStateCopyWith<BarometricState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BarometricStateCopyWith<$Res> {
  factory $BarometricStateCopyWith(
          BarometricState value, $Res Function(BarometricState) then) =
      _$BarometricStateCopyWithImpl<$Res, BarometricState>;
  @useResult
  $Res call(
      {double pressureMillibars,
      BarometricTrend trend,
      double rateOfChangeMillibarsPerHour});
}

/// @nodoc
class _$BarometricStateCopyWithImpl<$Res, $Val extends BarometricState>
    implements $BarometricStateCopyWith<$Res> {
  _$BarometricStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pressureMillibars = null,
    Object? trend = null,
    Object? rateOfChangeMillibarsPerHour = null,
  }) {
    return _then(_value.copyWith(
      pressureMillibars: null == pressureMillibars
          ? _value.pressureMillibars
          : pressureMillibars // ignore: cast_nullable_to_non_nullable
              as double,
      trend: null == trend
          ? _value.trend
          : trend // ignore: cast_nullable_to_non_nullable
              as BarometricTrend,
      rateOfChangeMillibarsPerHour: null == rateOfChangeMillibarsPerHour
          ? _value.rateOfChangeMillibarsPerHour
          : rateOfChangeMillibarsPerHour // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BarometricStateImplCopyWith<$Res>
    implements $BarometricStateCopyWith<$Res> {
  factory _$$BarometricStateImplCopyWith(_$BarometricStateImpl value,
          $Res Function(_$BarometricStateImpl) then) =
      __$$BarometricStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double pressureMillibars,
      BarometricTrend trend,
      double rateOfChangeMillibarsPerHour});
}

/// @nodoc
class __$$BarometricStateImplCopyWithImpl<$Res>
    extends _$BarometricStateCopyWithImpl<$Res, _$BarometricStateImpl>
    implements _$$BarometricStateImplCopyWith<$Res> {
  __$$BarometricStateImplCopyWithImpl(
      _$BarometricStateImpl _value, $Res Function(_$BarometricStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pressureMillibars = null,
    Object? trend = null,
    Object? rateOfChangeMillibarsPerHour = null,
  }) {
    return _then(_$BarometricStateImpl(
      pressureMillibars: null == pressureMillibars
          ? _value.pressureMillibars
          : pressureMillibars // ignore: cast_nullable_to_non_nullable
              as double,
      trend: null == trend
          ? _value.trend
          : trend // ignore: cast_nullable_to_non_nullable
              as BarometricTrend,
      rateOfChangeMillibarsPerHour: null == rateOfChangeMillibarsPerHour
          ? _value.rateOfChangeMillibarsPerHour
          : rateOfChangeMillibarsPerHour // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BarometricStateImpl implements _BarometricState {
  const _$BarometricStateImpl(
      {required this.pressureMillibars,
      required this.trend,
      required this.rateOfChangeMillibarsPerHour});

  factory _$BarometricStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$BarometricStateImplFromJson(json);

  @override
  final double pressureMillibars;
  @override
  final BarometricTrend trend;
  @override
  final double rateOfChangeMillibarsPerHour;

  @override
  String toString() {
    return 'BarometricState(pressureMillibars: $pressureMillibars, trend: $trend, rateOfChangeMillibarsPerHour: $rateOfChangeMillibarsPerHour)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BarometricStateImpl &&
            (identical(other.pressureMillibars, pressureMillibars) ||
                other.pressureMillibars == pressureMillibars) &&
            (identical(other.trend, trend) || other.trend == trend) &&
            (identical(other.rateOfChangeMillibarsPerHour,
                    rateOfChangeMillibarsPerHour) ||
                other.rateOfChangeMillibarsPerHour ==
                    rateOfChangeMillibarsPerHour));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, pressureMillibars, trend, rateOfChangeMillibarsPerHour);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BarometricStateImplCopyWith<_$BarometricStateImpl> get copyWith =>
      __$$BarometricStateImplCopyWithImpl<_$BarometricStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BarometricStateImplToJson(
      this,
    );
  }
}

abstract class _BarometricState implements BarometricState {
  const factory _BarometricState(
          {required final double pressureMillibars,
          required final BarometricTrend trend,
          required final double rateOfChangeMillibarsPerHour}) =
      _$BarometricStateImpl;

  factory _BarometricState.fromJson(Map<String, dynamic> json) =
      _$BarometricStateImpl.fromJson;

  @override
  double get pressureMillibars;
  @override
  BarometricTrend get trend;
  @override
  double get rateOfChangeMillibarsPerHour;
  @override
  @JsonKey(ignore: true)
  _$$BarometricStateImplCopyWith<_$BarometricStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
