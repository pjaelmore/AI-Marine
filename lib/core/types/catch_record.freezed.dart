// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catch_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ConditionSnapshot _$ConditionSnapshotFromJson(Map<String, dynamic> json) {
  return _ConditionSnapshot.fromJson(json);
}

/// @nodoc
mixin _$ConditionSnapshot {
  double? get waterTempF => throw _privateConstructorUsedError;
  double? get depthFt => throw _privateConstructorUsedError;
  TideState? get tideState => throw _privateConstructorUsedError;
  SolunarState? get solunarState => throw _privateConstructorUsedError;
  WindVector? get wind => throw _privateConstructorUsedError;
  WaveState? get waves => throw _privateConstructorUsedError;
  BarometricState? get barometric => throw _privateConstructorUsedError;
  MoonPhase? get moonPhase => throw _privateConstructorUsedError;
  String? get weatherSummary => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConditionSnapshotCopyWith<ConditionSnapshot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConditionSnapshotCopyWith<$Res> {
  factory $ConditionSnapshotCopyWith(
          ConditionSnapshot value, $Res Function(ConditionSnapshot) then) =
      _$ConditionSnapshotCopyWithImpl<$Res, ConditionSnapshot>;
  @useResult
  $Res call(
      {double? waterTempF,
      double? depthFt,
      TideState? tideState,
      SolunarState? solunarState,
      WindVector? wind,
      WaveState? waves,
      BarometricState? barometric,
      MoonPhase? moonPhase,
      String? weatherSummary});

  $TideStateCopyWith<$Res>? get tideState;
  $SolunarStateCopyWith<$Res>? get solunarState;
  $WindVectorCopyWith<$Res>? get wind;
  $WaveStateCopyWith<$Res>? get waves;
  $BarometricStateCopyWith<$Res>? get barometric;
}

/// @nodoc
class _$ConditionSnapshotCopyWithImpl<$Res, $Val extends ConditionSnapshot>
    implements $ConditionSnapshotCopyWith<$Res> {
  _$ConditionSnapshotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? waterTempF = freezed,
    Object? depthFt = freezed,
    Object? tideState = freezed,
    Object? solunarState = freezed,
    Object? wind = freezed,
    Object? waves = freezed,
    Object? barometric = freezed,
    Object? moonPhase = freezed,
    Object? weatherSummary = freezed,
  }) {
    return _then(_value.copyWith(
      waterTempF: freezed == waterTempF
          ? _value.waterTempF
          : waterTempF // ignore: cast_nullable_to_non_nullable
              as double?,
      depthFt: freezed == depthFt
          ? _value.depthFt
          : depthFt // ignore: cast_nullable_to_non_nullable
              as double?,
      tideState: freezed == tideState
          ? _value.tideState
          : tideState // ignore: cast_nullable_to_non_nullable
              as TideState?,
      solunarState: freezed == solunarState
          ? _value.solunarState
          : solunarState // ignore: cast_nullable_to_non_nullable
              as SolunarState?,
      wind: freezed == wind
          ? _value.wind
          : wind // ignore: cast_nullable_to_non_nullable
              as WindVector?,
      waves: freezed == waves
          ? _value.waves
          : waves // ignore: cast_nullable_to_non_nullable
              as WaveState?,
      barometric: freezed == barometric
          ? _value.barometric
          : barometric // ignore: cast_nullable_to_non_nullable
              as BarometricState?,
      moonPhase: freezed == moonPhase
          ? _value.moonPhase
          : moonPhase // ignore: cast_nullable_to_non_nullable
              as MoonPhase?,
      weatherSummary: freezed == weatherSummary
          ? _value.weatherSummary
          : weatherSummary // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TideStateCopyWith<$Res>? get tideState {
    if (_value.tideState == null) {
      return null;
    }

    return $TideStateCopyWith<$Res>(_value.tideState!, (value) {
      return _then(_value.copyWith(tideState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SolunarStateCopyWith<$Res>? get solunarState {
    if (_value.solunarState == null) {
      return null;
    }

    return $SolunarStateCopyWith<$Res>(_value.solunarState!, (value) {
      return _then(_value.copyWith(solunarState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $WindVectorCopyWith<$Res>? get wind {
    if (_value.wind == null) {
      return null;
    }

    return $WindVectorCopyWith<$Res>(_value.wind!, (value) {
      return _then(_value.copyWith(wind: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $WaveStateCopyWith<$Res>? get waves {
    if (_value.waves == null) {
      return null;
    }

    return $WaveStateCopyWith<$Res>(_value.waves!, (value) {
      return _then(_value.copyWith(waves: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $BarometricStateCopyWith<$Res>? get barometric {
    if (_value.barometric == null) {
      return null;
    }

    return $BarometricStateCopyWith<$Res>(_value.barometric!, (value) {
      return _then(_value.copyWith(barometric: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ConditionSnapshotImplCopyWith<$Res>
    implements $ConditionSnapshotCopyWith<$Res> {
  factory _$$ConditionSnapshotImplCopyWith(_$ConditionSnapshotImpl value,
          $Res Function(_$ConditionSnapshotImpl) then) =
      __$$ConditionSnapshotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double? waterTempF,
      double? depthFt,
      TideState? tideState,
      SolunarState? solunarState,
      WindVector? wind,
      WaveState? waves,
      BarometricState? barometric,
      MoonPhase? moonPhase,
      String? weatherSummary});

  @override
  $TideStateCopyWith<$Res>? get tideState;
  @override
  $SolunarStateCopyWith<$Res>? get solunarState;
  @override
  $WindVectorCopyWith<$Res>? get wind;
  @override
  $WaveStateCopyWith<$Res>? get waves;
  @override
  $BarometricStateCopyWith<$Res>? get barometric;
}

/// @nodoc
class __$$ConditionSnapshotImplCopyWithImpl<$Res>
    extends _$ConditionSnapshotCopyWithImpl<$Res, _$ConditionSnapshotImpl>
    implements _$$ConditionSnapshotImplCopyWith<$Res> {
  __$$ConditionSnapshotImplCopyWithImpl(_$ConditionSnapshotImpl _value,
      $Res Function(_$ConditionSnapshotImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? waterTempF = freezed,
    Object? depthFt = freezed,
    Object? tideState = freezed,
    Object? solunarState = freezed,
    Object? wind = freezed,
    Object? waves = freezed,
    Object? barometric = freezed,
    Object? moonPhase = freezed,
    Object? weatherSummary = freezed,
  }) {
    return _then(_$ConditionSnapshotImpl(
      waterTempF: freezed == waterTempF
          ? _value.waterTempF
          : waterTempF // ignore: cast_nullable_to_non_nullable
              as double?,
      depthFt: freezed == depthFt
          ? _value.depthFt
          : depthFt // ignore: cast_nullable_to_non_nullable
              as double?,
      tideState: freezed == tideState
          ? _value.tideState
          : tideState // ignore: cast_nullable_to_non_nullable
              as TideState?,
      solunarState: freezed == solunarState
          ? _value.solunarState
          : solunarState // ignore: cast_nullable_to_non_nullable
              as SolunarState?,
      wind: freezed == wind
          ? _value.wind
          : wind // ignore: cast_nullable_to_non_nullable
              as WindVector?,
      waves: freezed == waves
          ? _value.waves
          : waves // ignore: cast_nullable_to_non_nullable
              as WaveState?,
      barometric: freezed == barometric
          ? _value.barometric
          : barometric // ignore: cast_nullable_to_non_nullable
              as BarometricState?,
      moonPhase: freezed == moonPhase
          ? _value.moonPhase
          : moonPhase // ignore: cast_nullable_to_non_nullable
              as MoonPhase?,
      weatherSummary: freezed == weatherSummary
          ? _value.weatherSummary
          : weatherSummary // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConditionSnapshotImpl implements _ConditionSnapshot {
  const _$ConditionSnapshotImpl(
      {this.waterTempF,
      this.depthFt,
      this.tideState,
      this.solunarState,
      this.wind,
      this.waves,
      this.barometric,
      this.moonPhase,
      this.weatherSummary});

  factory _$ConditionSnapshotImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConditionSnapshotImplFromJson(json);

  @override
  final double? waterTempF;
  @override
  final double? depthFt;
  @override
  final TideState? tideState;
  @override
  final SolunarState? solunarState;
  @override
  final WindVector? wind;
  @override
  final WaveState? waves;
  @override
  final BarometricState? barometric;
  @override
  final MoonPhase? moonPhase;
  @override
  final String? weatherSummary;

  @override
  String toString() {
    return 'ConditionSnapshot(waterTempF: $waterTempF, depthFt: $depthFt, tideState: $tideState, solunarState: $solunarState, wind: $wind, waves: $waves, barometric: $barometric, moonPhase: $moonPhase, weatherSummary: $weatherSummary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConditionSnapshotImpl &&
            (identical(other.waterTempF, waterTempF) ||
                other.waterTempF == waterTempF) &&
            (identical(other.depthFt, depthFt) || other.depthFt == depthFt) &&
            (identical(other.tideState, tideState) ||
                other.tideState == tideState) &&
            (identical(other.solunarState, solunarState) ||
                other.solunarState == solunarState) &&
            (identical(other.wind, wind) || other.wind == wind) &&
            (identical(other.waves, waves) || other.waves == waves) &&
            (identical(other.barometric, barometric) ||
                other.barometric == barometric) &&
            (identical(other.moonPhase, moonPhase) ||
                other.moonPhase == moonPhase) &&
            (identical(other.weatherSummary, weatherSummary) ||
                other.weatherSummary == weatherSummary));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, waterTempF, depthFt, tideState,
      solunarState, wind, waves, barometric, moonPhase, weatherSummary);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConditionSnapshotImplCopyWith<_$ConditionSnapshotImpl> get copyWith =>
      __$$ConditionSnapshotImplCopyWithImpl<_$ConditionSnapshotImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConditionSnapshotImplToJson(
      this,
    );
  }
}

abstract class _ConditionSnapshot implements ConditionSnapshot {
  const factory _ConditionSnapshot(
      {final double? waterTempF,
      final double? depthFt,
      final TideState? tideState,
      final SolunarState? solunarState,
      final WindVector? wind,
      final WaveState? waves,
      final BarometricState? barometric,
      final MoonPhase? moonPhase,
      final String? weatherSummary}) = _$ConditionSnapshotImpl;

  factory _ConditionSnapshot.fromJson(Map<String, dynamic> json) =
      _$ConditionSnapshotImpl.fromJson;

  @override
  double? get waterTempF;
  @override
  double? get depthFt;
  @override
  TideState? get tideState;
  @override
  SolunarState? get solunarState;
  @override
  WindVector? get wind;
  @override
  WaveState? get waves;
  @override
  BarometricState? get barometric;
  @override
  MoonPhase? get moonPhase;
  @override
  String? get weatherSummary;
  @override
  @JsonKey(ignore: true)
  _$$ConditionSnapshotImplCopyWith<_$ConditionSnapshotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CatchRecord _$CatchRecordFromJson(Map<String, dynamic> json) {
  return _CatchRecord.fromJson(json);
}

/// @nodoc
mixin _$CatchRecord {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  LatLng get location => throw _privateConstructorUsedError;
  LocationSource get locationSource => throw _privateConstructorUsedError;
  String get speciesId => throw _privateConstructorUsedError;
  ConditionSnapshot get conditions => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  String? get sizeClassId => throw _privateConstructorUsedError;
  double? get lengthInches => throw _privateConstructorUsedError;
  double? get weightPounds => throw _privateConstructorUsedError;
  String? get baitOrLure => throw _privateConstructorUsedError;
  bool? get released => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String? get photoLocalPath => throw _privateConstructorUsedError;
  String? get recommendationPinId => throw _privateConstructorUsedError;
  double? get engineScoreAtCatch => throw _privateConstructorUsedError;
  ReasoningBreakdown? get engineReasoningAtCatch =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CatchRecordCopyWith<CatchRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CatchRecordCopyWith<$Res> {
  factory $CatchRecordCopyWith(
          CatchRecord value, $Res Function(CatchRecord) then) =
      _$CatchRecordCopyWithImpl<$Res, CatchRecord>;
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime timestamp,
      LatLng location,
      LocationSource locationSource,
      String speciesId,
      ConditionSnapshot conditions,
      DateTime createdAt,
      DateTime updatedAt,
      String? sizeClassId,
      double? lengthInches,
      double? weightPounds,
      String? baitOrLure,
      bool? released,
      String? notes,
      String? photoLocalPath,
      String? recommendationPinId,
      double? engineScoreAtCatch,
      ReasoningBreakdown? engineReasoningAtCatch});

  $LatLngCopyWith<$Res> get location;
  $ConditionSnapshotCopyWith<$Res> get conditions;
  $ReasoningBreakdownCopyWith<$Res>? get engineReasoningAtCatch;
}

/// @nodoc
class _$CatchRecordCopyWithImpl<$Res, $Val extends CatchRecord>
    implements $CatchRecordCopyWith<$Res> {
  _$CatchRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? timestamp = null,
    Object? location = null,
    Object? locationSource = null,
    Object? speciesId = null,
    Object? conditions = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? sizeClassId = freezed,
    Object? lengthInches = freezed,
    Object? weightPounds = freezed,
    Object? baitOrLure = freezed,
    Object? released = freezed,
    Object? notes = freezed,
    Object? photoLocalPath = freezed,
    Object? recommendationPinId = freezed,
    Object? engineScoreAtCatch = freezed,
    Object? engineReasoningAtCatch = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LatLng,
      locationSource: null == locationSource
          ? _value.locationSource
          : locationSource // ignore: cast_nullable_to_non_nullable
              as LocationSource,
      speciesId: null == speciesId
          ? _value.speciesId
          : speciesId // ignore: cast_nullable_to_non_nullable
              as String,
      conditions: null == conditions
          ? _value.conditions
          : conditions // ignore: cast_nullable_to_non_nullable
              as ConditionSnapshot,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sizeClassId: freezed == sizeClassId
          ? _value.sizeClassId
          : sizeClassId // ignore: cast_nullable_to_non_nullable
              as String?,
      lengthInches: freezed == lengthInches
          ? _value.lengthInches
          : lengthInches // ignore: cast_nullable_to_non_nullable
              as double?,
      weightPounds: freezed == weightPounds
          ? _value.weightPounds
          : weightPounds // ignore: cast_nullable_to_non_nullable
              as double?,
      baitOrLure: freezed == baitOrLure
          ? _value.baitOrLure
          : baitOrLure // ignore: cast_nullable_to_non_nullable
              as String?,
      released: freezed == released
          ? _value.released
          : released // ignore: cast_nullable_to_non_nullable
              as bool?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      photoLocalPath: freezed == photoLocalPath
          ? _value.photoLocalPath
          : photoLocalPath // ignore: cast_nullable_to_non_nullable
              as String?,
      recommendationPinId: freezed == recommendationPinId
          ? _value.recommendationPinId
          : recommendationPinId // ignore: cast_nullable_to_non_nullable
              as String?,
      engineScoreAtCatch: freezed == engineScoreAtCatch
          ? _value.engineScoreAtCatch
          : engineScoreAtCatch // ignore: cast_nullable_to_non_nullable
              as double?,
      engineReasoningAtCatch: freezed == engineReasoningAtCatch
          ? _value.engineReasoningAtCatch
          : engineReasoningAtCatch // ignore: cast_nullable_to_non_nullable
              as ReasoningBreakdown?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LatLngCopyWith<$Res> get location {
    return $LatLngCopyWith<$Res>(_value.location, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ConditionSnapshotCopyWith<$Res> get conditions {
    return $ConditionSnapshotCopyWith<$Res>(_value.conditions, (value) {
      return _then(_value.copyWith(conditions: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ReasoningBreakdownCopyWith<$Res>? get engineReasoningAtCatch {
    if (_value.engineReasoningAtCatch == null) {
      return null;
    }

    return $ReasoningBreakdownCopyWith<$Res>(_value.engineReasoningAtCatch!,
        (value) {
      return _then(_value.copyWith(engineReasoningAtCatch: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CatchRecordImplCopyWith<$Res>
    implements $CatchRecordCopyWith<$Res> {
  factory _$$CatchRecordImplCopyWith(
          _$CatchRecordImpl value, $Res Function(_$CatchRecordImpl) then) =
      __$$CatchRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime timestamp,
      LatLng location,
      LocationSource locationSource,
      String speciesId,
      ConditionSnapshot conditions,
      DateTime createdAt,
      DateTime updatedAt,
      String? sizeClassId,
      double? lengthInches,
      double? weightPounds,
      String? baitOrLure,
      bool? released,
      String? notes,
      String? photoLocalPath,
      String? recommendationPinId,
      double? engineScoreAtCatch,
      ReasoningBreakdown? engineReasoningAtCatch});

  @override
  $LatLngCopyWith<$Res> get location;
  @override
  $ConditionSnapshotCopyWith<$Res> get conditions;
  @override
  $ReasoningBreakdownCopyWith<$Res>? get engineReasoningAtCatch;
}

/// @nodoc
class __$$CatchRecordImplCopyWithImpl<$Res>
    extends _$CatchRecordCopyWithImpl<$Res, _$CatchRecordImpl>
    implements _$$CatchRecordImplCopyWith<$Res> {
  __$$CatchRecordImplCopyWithImpl(
      _$CatchRecordImpl _value, $Res Function(_$CatchRecordImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? timestamp = null,
    Object? location = null,
    Object? locationSource = null,
    Object? speciesId = null,
    Object? conditions = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? sizeClassId = freezed,
    Object? lengthInches = freezed,
    Object? weightPounds = freezed,
    Object? baitOrLure = freezed,
    Object? released = freezed,
    Object? notes = freezed,
    Object? photoLocalPath = freezed,
    Object? recommendationPinId = freezed,
    Object? engineScoreAtCatch = freezed,
    Object? engineReasoningAtCatch = freezed,
  }) {
    return _then(_$CatchRecordImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LatLng,
      locationSource: null == locationSource
          ? _value.locationSource
          : locationSource // ignore: cast_nullable_to_non_nullable
              as LocationSource,
      speciesId: null == speciesId
          ? _value.speciesId
          : speciesId // ignore: cast_nullable_to_non_nullable
              as String,
      conditions: null == conditions
          ? _value.conditions
          : conditions // ignore: cast_nullable_to_non_nullable
              as ConditionSnapshot,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sizeClassId: freezed == sizeClassId
          ? _value.sizeClassId
          : sizeClassId // ignore: cast_nullable_to_non_nullable
              as String?,
      lengthInches: freezed == lengthInches
          ? _value.lengthInches
          : lengthInches // ignore: cast_nullable_to_non_nullable
              as double?,
      weightPounds: freezed == weightPounds
          ? _value.weightPounds
          : weightPounds // ignore: cast_nullable_to_non_nullable
              as double?,
      baitOrLure: freezed == baitOrLure
          ? _value.baitOrLure
          : baitOrLure // ignore: cast_nullable_to_non_nullable
              as String?,
      released: freezed == released
          ? _value.released
          : released // ignore: cast_nullable_to_non_nullable
              as bool?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      photoLocalPath: freezed == photoLocalPath
          ? _value.photoLocalPath
          : photoLocalPath // ignore: cast_nullable_to_non_nullable
              as String?,
      recommendationPinId: freezed == recommendationPinId
          ? _value.recommendationPinId
          : recommendationPinId // ignore: cast_nullable_to_non_nullable
              as String?,
      engineScoreAtCatch: freezed == engineScoreAtCatch
          ? _value.engineScoreAtCatch
          : engineScoreAtCatch // ignore: cast_nullable_to_non_nullable
              as double?,
      engineReasoningAtCatch: freezed == engineReasoningAtCatch
          ? _value.engineReasoningAtCatch
          : engineReasoningAtCatch // ignore: cast_nullable_to_non_nullable
              as ReasoningBreakdown?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CatchRecordImpl implements _CatchRecord {
  const _$CatchRecordImpl(
      {required this.id,
      required this.userId,
      required this.timestamp,
      required this.location,
      required this.locationSource,
      required this.speciesId,
      required this.conditions,
      required this.createdAt,
      required this.updatedAt,
      this.sizeClassId,
      this.lengthInches,
      this.weightPounds,
      this.baitOrLure,
      this.released,
      this.notes,
      this.photoLocalPath,
      this.recommendationPinId,
      this.engineScoreAtCatch,
      this.engineReasoningAtCatch});

  factory _$CatchRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$CatchRecordImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final DateTime timestamp;
  @override
  final LatLng location;
  @override
  final LocationSource locationSource;
  @override
  final String speciesId;
  @override
  final ConditionSnapshot conditions;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final String? sizeClassId;
  @override
  final double? lengthInches;
  @override
  final double? weightPounds;
  @override
  final String? baitOrLure;
  @override
  final bool? released;
  @override
  final String? notes;
  @override
  final String? photoLocalPath;
  @override
  final String? recommendationPinId;
  @override
  final double? engineScoreAtCatch;
  @override
  final ReasoningBreakdown? engineReasoningAtCatch;

  @override
  String toString() {
    return 'CatchRecord(id: $id, userId: $userId, timestamp: $timestamp, location: $location, locationSource: $locationSource, speciesId: $speciesId, conditions: $conditions, createdAt: $createdAt, updatedAt: $updatedAt, sizeClassId: $sizeClassId, lengthInches: $lengthInches, weightPounds: $weightPounds, baitOrLure: $baitOrLure, released: $released, notes: $notes, photoLocalPath: $photoLocalPath, recommendationPinId: $recommendationPinId, engineScoreAtCatch: $engineScoreAtCatch, engineReasoningAtCatch: $engineReasoningAtCatch)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CatchRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.locationSource, locationSource) ||
                other.locationSource == locationSource) &&
            (identical(other.speciesId, speciesId) ||
                other.speciesId == speciesId) &&
            (identical(other.conditions, conditions) ||
                other.conditions == conditions) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.sizeClassId, sizeClassId) ||
                other.sizeClassId == sizeClassId) &&
            (identical(other.lengthInches, lengthInches) ||
                other.lengthInches == lengthInches) &&
            (identical(other.weightPounds, weightPounds) ||
                other.weightPounds == weightPounds) &&
            (identical(other.baitOrLure, baitOrLure) ||
                other.baitOrLure == baitOrLure) &&
            (identical(other.released, released) ||
                other.released == released) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.photoLocalPath, photoLocalPath) ||
                other.photoLocalPath == photoLocalPath) &&
            (identical(other.recommendationPinId, recommendationPinId) ||
                other.recommendationPinId == recommendationPinId) &&
            (identical(other.engineScoreAtCatch, engineScoreAtCatch) ||
                other.engineScoreAtCatch == engineScoreAtCatch) &&
            (identical(other.engineReasoningAtCatch, engineReasoningAtCatch) ||
                other.engineReasoningAtCatch == engineReasoningAtCatch));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        userId,
        timestamp,
        location,
        locationSource,
        speciesId,
        conditions,
        createdAt,
        updatedAt,
        sizeClassId,
        lengthInches,
        weightPounds,
        baitOrLure,
        released,
        notes,
        photoLocalPath,
        recommendationPinId,
        engineScoreAtCatch,
        engineReasoningAtCatch
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CatchRecordImplCopyWith<_$CatchRecordImpl> get copyWith =>
      __$$CatchRecordImplCopyWithImpl<_$CatchRecordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CatchRecordImplToJson(
      this,
    );
  }
}

abstract class _CatchRecord implements CatchRecord {
  const factory _CatchRecord(
      {required final String id,
      required final String userId,
      required final DateTime timestamp,
      required final LatLng location,
      required final LocationSource locationSource,
      required final String speciesId,
      required final ConditionSnapshot conditions,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final String? sizeClassId,
      final double? lengthInches,
      final double? weightPounds,
      final String? baitOrLure,
      final bool? released,
      final String? notes,
      final String? photoLocalPath,
      final String? recommendationPinId,
      final double? engineScoreAtCatch,
      final ReasoningBreakdown? engineReasoningAtCatch}) = _$CatchRecordImpl;

  factory _CatchRecord.fromJson(Map<String, dynamic> json) =
      _$CatchRecordImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  DateTime get timestamp;
  @override
  LatLng get location;
  @override
  LocationSource get locationSource;
  @override
  String get speciesId;
  @override
  ConditionSnapshot get conditions;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  String? get sizeClassId;
  @override
  double? get lengthInches;
  @override
  double? get weightPounds;
  @override
  String? get baitOrLure;
  @override
  bool? get released;
  @override
  String? get notes;
  @override
  String? get photoLocalPath;
  @override
  String? get recommendationPinId;
  @override
  double? get engineScoreAtCatch;
  @override
  ReasoningBreakdown? get engineReasoningAtCatch;
  @override
  @JsonKey(ignore: true)
  _$$CatchRecordImplCopyWith<_$CatchRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
