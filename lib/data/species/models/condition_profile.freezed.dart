// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'condition_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ConditionProfile _$ConditionProfileFromJson(Map<String, dynamic> json) {
  return _ConditionProfile.fromJson(json);
}

/// @nodoc
mixin _$ConditionProfile {
  TemperatureRange get optimalTemp => throw _privateConstructorUsedError;
  TemperatureRange get toleratedTemp => throw _privateConstructorUsedError;
  DepthPreference get depthPreference => throw _privateConstructorUsedError;
  List<StructurePreference> get structurePreferences =>
      throw _privateConstructorUsedError;
  TidePreference get tidePreference => throw _privateConstructorUsedError;
  SolunarSensitivity get solunarSensitivity =>
      throw _privateConstructorUsedError;
  List<TimeOfDayPreference> get timeOfDayPreferences =>
      throw _privateConstructorUsedError;
  LunarSensitivity get lunarSensitivity => throw _privateConstructorUsedError;
  WeatherSensitivity get weatherSensitivity =>
      throw _privateConstructorUsedError;
  SalinityPreference? get salinityPreference =>
      throw _privateConstructorUsedError;
  CurrentPreference get currentPreference => throw _privateConstructorUsedError;
  List<BaitAssociation> get baitAssociations =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConditionProfileCopyWith<ConditionProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConditionProfileCopyWith<$Res> {
  factory $ConditionProfileCopyWith(
          ConditionProfile value, $Res Function(ConditionProfile) then) =
      _$ConditionProfileCopyWithImpl<$Res, ConditionProfile>;
  @useResult
  $Res call(
      {TemperatureRange optimalTemp,
      TemperatureRange toleratedTemp,
      DepthPreference depthPreference,
      List<StructurePreference> structurePreferences,
      TidePreference tidePreference,
      SolunarSensitivity solunarSensitivity,
      List<TimeOfDayPreference> timeOfDayPreferences,
      LunarSensitivity lunarSensitivity,
      WeatherSensitivity weatherSensitivity,
      SalinityPreference? salinityPreference,
      CurrentPreference currentPreference,
      List<BaitAssociation> baitAssociations});

  $TemperatureRangeCopyWith<$Res> get optimalTemp;
  $TemperatureRangeCopyWith<$Res> get toleratedTemp;
  $DepthPreferenceCopyWith<$Res> get depthPreference;
  $TidePreferenceCopyWith<$Res> get tidePreference;
  $WeatherSensitivityCopyWith<$Res> get weatherSensitivity;
  $SalinityPreferenceCopyWith<$Res>? get salinityPreference;
  $CurrentPreferenceCopyWith<$Res> get currentPreference;
}

/// @nodoc
class _$ConditionProfileCopyWithImpl<$Res, $Val extends ConditionProfile>
    implements $ConditionProfileCopyWith<$Res> {
  _$ConditionProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? optimalTemp = null,
    Object? toleratedTemp = null,
    Object? depthPreference = null,
    Object? structurePreferences = null,
    Object? tidePreference = null,
    Object? solunarSensitivity = null,
    Object? timeOfDayPreferences = null,
    Object? lunarSensitivity = null,
    Object? weatherSensitivity = null,
    Object? salinityPreference = freezed,
    Object? currentPreference = null,
    Object? baitAssociations = null,
  }) {
    return _then(_value.copyWith(
      optimalTemp: null == optimalTemp
          ? _value.optimalTemp
          : optimalTemp // ignore: cast_nullable_to_non_nullable
              as TemperatureRange,
      toleratedTemp: null == toleratedTemp
          ? _value.toleratedTemp
          : toleratedTemp // ignore: cast_nullable_to_non_nullable
              as TemperatureRange,
      depthPreference: null == depthPreference
          ? _value.depthPreference
          : depthPreference // ignore: cast_nullable_to_non_nullable
              as DepthPreference,
      structurePreferences: null == structurePreferences
          ? _value.structurePreferences
          : structurePreferences // ignore: cast_nullable_to_non_nullable
              as List<StructurePreference>,
      tidePreference: null == tidePreference
          ? _value.tidePreference
          : tidePreference // ignore: cast_nullable_to_non_nullable
              as TidePreference,
      solunarSensitivity: null == solunarSensitivity
          ? _value.solunarSensitivity
          : solunarSensitivity // ignore: cast_nullable_to_non_nullable
              as SolunarSensitivity,
      timeOfDayPreferences: null == timeOfDayPreferences
          ? _value.timeOfDayPreferences
          : timeOfDayPreferences // ignore: cast_nullable_to_non_nullable
              as List<TimeOfDayPreference>,
      lunarSensitivity: null == lunarSensitivity
          ? _value.lunarSensitivity
          : lunarSensitivity // ignore: cast_nullable_to_non_nullable
              as LunarSensitivity,
      weatherSensitivity: null == weatherSensitivity
          ? _value.weatherSensitivity
          : weatherSensitivity // ignore: cast_nullable_to_non_nullable
              as WeatherSensitivity,
      salinityPreference: freezed == salinityPreference
          ? _value.salinityPreference
          : salinityPreference // ignore: cast_nullable_to_non_nullable
              as SalinityPreference?,
      currentPreference: null == currentPreference
          ? _value.currentPreference
          : currentPreference // ignore: cast_nullable_to_non_nullable
              as CurrentPreference,
      baitAssociations: null == baitAssociations
          ? _value.baitAssociations
          : baitAssociations // ignore: cast_nullable_to_non_nullable
              as List<BaitAssociation>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TemperatureRangeCopyWith<$Res> get optimalTemp {
    return $TemperatureRangeCopyWith<$Res>(_value.optimalTemp, (value) {
      return _then(_value.copyWith(optimalTemp: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TemperatureRangeCopyWith<$Res> get toleratedTemp {
    return $TemperatureRangeCopyWith<$Res>(_value.toleratedTemp, (value) {
      return _then(_value.copyWith(toleratedTemp: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DepthPreferenceCopyWith<$Res> get depthPreference {
    return $DepthPreferenceCopyWith<$Res>(_value.depthPreference, (value) {
      return _then(_value.copyWith(depthPreference: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TidePreferenceCopyWith<$Res> get tidePreference {
    return $TidePreferenceCopyWith<$Res>(_value.tidePreference, (value) {
      return _then(_value.copyWith(tidePreference: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $WeatherSensitivityCopyWith<$Res> get weatherSensitivity {
    return $WeatherSensitivityCopyWith<$Res>(_value.weatherSensitivity,
        (value) {
      return _then(_value.copyWith(weatherSensitivity: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SalinityPreferenceCopyWith<$Res>? get salinityPreference {
    if (_value.salinityPreference == null) {
      return null;
    }

    return $SalinityPreferenceCopyWith<$Res>(_value.salinityPreference!,
        (value) {
      return _then(_value.copyWith(salinityPreference: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CurrentPreferenceCopyWith<$Res> get currentPreference {
    return $CurrentPreferenceCopyWith<$Res>(_value.currentPreference, (value) {
      return _then(_value.copyWith(currentPreference: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ConditionProfileImplCopyWith<$Res>
    implements $ConditionProfileCopyWith<$Res> {
  factory _$$ConditionProfileImplCopyWith(_$ConditionProfileImpl value,
          $Res Function(_$ConditionProfileImpl) then) =
      __$$ConditionProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TemperatureRange optimalTemp,
      TemperatureRange toleratedTemp,
      DepthPreference depthPreference,
      List<StructurePreference> structurePreferences,
      TidePreference tidePreference,
      SolunarSensitivity solunarSensitivity,
      List<TimeOfDayPreference> timeOfDayPreferences,
      LunarSensitivity lunarSensitivity,
      WeatherSensitivity weatherSensitivity,
      SalinityPreference? salinityPreference,
      CurrentPreference currentPreference,
      List<BaitAssociation> baitAssociations});

  @override
  $TemperatureRangeCopyWith<$Res> get optimalTemp;
  @override
  $TemperatureRangeCopyWith<$Res> get toleratedTemp;
  @override
  $DepthPreferenceCopyWith<$Res> get depthPreference;
  @override
  $TidePreferenceCopyWith<$Res> get tidePreference;
  @override
  $WeatherSensitivityCopyWith<$Res> get weatherSensitivity;
  @override
  $SalinityPreferenceCopyWith<$Res>? get salinityPreference;
  @override
  $CurrentPreferenceCopyWith<$Res> get currentPreference;
}

/// @nodoc
class __$$ConditionProfileImplCopyWithImpl<$Res>
    extends _$ConditionProfileCopyWithImpl<$Res, _$ConditionProfileImpl>
    implements _$$ConditionProfileImplCopyWith<$Res> {
  __$$ConditionProfileImplCopyWithImpl(_$ConditionProfileImpl _value,
      $Res Function(_$ConditionProfileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? optimalTemp = null,
    Object? toleratedTemp = null,
    Object? depthPreference = null,
    Object? structurePreferences = null,
    Object? tidePreference = null,
    Object? solunarSensitivity = null,
    Object? timeOfDayPreferences = null,
    Object? lunarSensitivity = null,
    Object? weatherSensitivity = null,
    Object? salinityPreference = freezed,
    Object? currentPreference = null,
    Object? baitAssociations = null,
  }) {
    return _then(_$ConditionProfileImpl(
      optimalTemp: null == optimalTemp
          ? _value.optimalTemp
          : optimalTemp // ignore: cast_nullable_to_non_nullable
              as TemperatureRange,
      toleratedTemp: null == toleratedTemp
          ? _value.toleratedTemp
          : toleratedTemp // ignore: cast_nullable_to_non_nullable
              as TemperatureRange,
      depthPreference: null == depthPreference
          ? _value.depthPreference
          : depthPreference // ignore: cast_nullable_to_non_nullable
              as DepthPreference,
      structurePreferences: null == structurePreferences
          ? _value._structurePreferences
          : structurePreferences // ignore: cast_nullable_to_non_nullable
              as List<StructurePreference>,
      tidePreference: null == tidePreference
          ? _value.tidePreference
          : tidePreference // ignore: cast_nullable_to_non_nullable
              as TidePreference,
      solunarSensitivity: null == solunarSensitivity
          ? _value.solunarSensitivity
          : solunarSensitivity // ignore: cast_nullable_to_non_nullable
              as SolunarSensitivity,
      timeOfDayPreferences: null == timeOfDayPreferences
          ? _value._timeOfDayPreferences
          : timeOfDayPreferences // ignore: cast_nullable_to_non_nullable
              as List<TimeOfDayPreference>,
      lunarSensitivity: null == lunarSensitivity
          ? _value.lunarSensitivity
          : lunarSensitivity // ignore: cast_nullable_to_non_nullable
              as LunarSensitivity,
      weatherSensitivity: null == weatherSensitivity
          ? _value.weatherSensitivity
          : weatherSensitivity // ignore: cast_nullable_to_non_nullable
              as WeatherSensitivity,
      salinityPreference: freezed == salinityPreference
          ? _value.salinityPreference
          : salinityPreference // ignore: cast_nullable_to_non_nullable
              as SalinityPreference?,
      currentPreference: null == currentPreference
          ? _value.currentPreference
          : currentPreference // ignore: cast_nullable_to_non_nullable
              as CurrentPreference,
      baitAssociations: null == baitAssociations
          ? _value._baitAssociations
          : baitAssociations // ignore: cast_nullable_to_non_nullable
              as List<BaitAssociation>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConditionProfileImpl implements _ConditionProfile {
  const _$ConditionProfileImpl(
      {required this.optimalTemp,
      required this.toleratedTemp,
      required this.depthPreference,
      final List<StructurePreference> structurePreferences =
          const <StructurePreference>[],
      required this.tidePreference,
      required this.solunarSensitivity,
      final List<TimeOfDayPreference> timeOfDayPreferences =
          const <TimeOfDayPreference>[],
      required this.lunarSensitivity,
      required this.weatherSensitivity,
      this.salinityPreference,
      required this.currentPreference,
      final List<BaitAssociation> baitAssociations = const <BaitAssociation>[]})
      : _structurePreferences = structurePreferences,
        _timeOfDayPreferences = timeOfDayPreferences,
        _baitAssociations = baitAssociations;

  factory _$ConditionProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConditionProfileImplFromJson(json);

  @override
  final TemperatureRange optimalTemp;
  @override
  final TemperatureRange toleratedTemp;
  @override
  final DepthPreference depthPreference;
  final List<StructurePreference> _structurePreferences;
  @override
  @JsonKey()
  List<StructurePreference> get structurePreferences {
    if (_structurePreferences is EqualUnmodifiableListView)
      return _structurePreferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_structurePreferences);
  }

  @override
  final TidePreference tidePreference;
  @override
  final SolunarSensitivity solunarSensitivity;
  final List<TimeOfDayPreference> _timeOfDayPreferences;
  @override
  @JsonKey()
  List<TimeOfDayPreference> get timeOfDayPreferences {
    if (_timeOfDayPreferences is EqualUnmodifiableListView)
      return _timeOfDayPreferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timeOfDayPreferences);
  }

  @override
  final LunarSensitivity lunarSensitivity;
  @override
  final WeatherSensitivity weatherSensitivity;
  @override
  final SalinityPreference? salinityPreference;
  @override
  final CurrentPreference currentPreference;
  final List<BaitAssociation> _baitAssociations;
  @override
  @JsonKey()
  List<BaitAssociation> get baitAssociations {
    if (_baitAssociations is EqualUnmodifiableListView)
      return _baitAssociations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_baitAssociations);
  }

  @override
  String toString() {
    return 'ConditionProfile(optimalTemp: $optimalTemp, toleratedTemp: $toleratedTemp, depthPreference: $depthPreference, structurePreferences: $structurePreferences, tidePreference: $tidePreference, solunarSensitivity: $solunarSensitivity, timeOfDayPreferences: $timeOfDayPreferences, lunarSensitivity: $lunarSensitivity, weatherSensitivity: $weatherSensitivity, salinityPreference: $salinityPreference, currentPreference: $currentPreference, baitAssociations: $baitAssociations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConditionProfileImpl &&
            (identical(other.optimalTemp, optimalTemp) ||
                other.optimalTemp == optimalTemp) &&
            (identical(other.toleratedTemp, toleratedTemp) ||
                other.toleratedTemp == toleratedTemp) &&
            (identical(other.depthPreference, depthPreference) ||
                other.depthPreference == depthPreference) &&
            const DeepCollectionEquality()
                .equals(other._structurePreferences, _structurePreferences) &&
            (identical(other.tidePreference, tidePreference) ||
                other.tidePreference == tidePreference) &&
            (identical(other.solunarSensitivity, solunarSensitivity) ||
                other.solunarSensitivity == solunarSensitivity) &&
            const DeepCollectionEquality()
                .equals(other._timeOfDayPreferences, _timeOfDayPreferences) &&
            (identical(other.lunarSensitivity, lunarSensitivity) ||
                other.lunarSensitivity == lunarSensitivity) &&
            (identical(other.weatherSensitivity, weatherSensitivity) ||
                other.weatherSensitivity == weatherSensitivity) &&
            (identical(other.salinityPreference, salinityPreference) ||
                other.salinityPreference == salinityPreference) &&
            (identical(other.currentPreference, currentPreference) ||
                other.currentPreference == currentPreference) &&
            const DeepCollectionEquality()
                .equals(other._baitAssociations, _baitAssociations));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      optimalTemp,
      toleratedTemp,
      depthPreference,
      const DeepCollectionEquality().hash(_structurePreferences),
      tidePreference,
      solunarSensitivity,
      const DeepCollectionEquality().hash(_timeOfDayPreferences),
      lunarSensitivity,
      weatherSensitivity,
      salinityPreference,
      currentPreference,
      const DeepCollectionEquality().hash(_baitAssociations));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConditionProfileImplCopyWith<_$ConditionProfileImpl> get copyWith =>
      __$$ConditionProfileImplCopyWithImpl<_$ConditionProfileImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConditionProfileImplToJson(
      this,
    );
  }
}

abstract class _ConditionProfile implements ConditionProfile {
  const factory _ConditionProfile(
      {required final TemperatureRange optimalTemp,
      required final TemperatureRange toleratedTemp,
      required final DepthPreference depthPreference,
      final List<StructurePreference> structurePreferences,
      required final TidePreference tidePreference,
      required final SolunarSensitivity solunarSensitivity,
      final List<TimeOfDayPreference> timeOfDayPreferences,
      required final LunarSensitivity lunarSensitivity,
      required final WeatherSensitivity weatherSensitivity,
      final SalinityPreference? salinityPreference,
      required final CurrentPreference currentPreference,
      final List<BaitAssociation> baitAssociations}) = _$ConditionProfileImpl;

  factory _ConditionProfile.fromJson(Map<String, dynamic> json) =
      _$ConditionProfileImpl.fromJson;

  @override
  TemperatureRange get optimalTemp;
  @override
  TemperatureRange get toleratedTemp;
  @override
  DepthPreference get depthPreference;
  @override
  List<StructurePreference> get structurePreferences;
  @override
  TidePreference get tidePreference;
  @override
  SolunarSensitivity get solunarSensitivity;
  @override
  List<TimeOfDayPreference> get timeOfDayPreferences;
  @override
  LunarSensitivity get lunarSensitivity;
  @override
  WeatherSensitivity get weatherSensitivity;
  @override
  SalinityPreference? get salinityPreference;
  @override
  CurrentPreference get currentPreference;
  @override
  List<BaitAssociation> get baitAssociations;
  @override
  @JsonKey(ignore: true)
  _$$ConditionProfileImplCopyWith<_$ConditionProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TemperatureRange _$TemperatureRangeFromJson(Map<String, dynamic> json) {
  return _TemperatureRange.fromJson(json);
}

/// @nodoc
mixin _$TemperatureRange {
  double get minF => throw _privateConstructorUsedError;
  double get maxF => throw _privateConstructorUsedError;
  double get idealF => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TemperatureRangeCopyWith<TemperatureRange> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TemperatureRangeCopyWith<$Res> {
  factory $TemperatureRangeCopyWith(
          TemperatureRange value, $Res Function(TemperatureRange) then) =
      _$TemperatureRangeCopyWithImpl<$Res, TemperatureRange>;
  @useResult
  $Res call({double minF, double maxF, double idealF});
}

/// @nodoc
class _$TemperatureRangeCopyWithImpl<$Res, $Val extends TemperatureRange>
    implements $TemperatureRangeCopyWith<$Res> {
  _$TemperatureRangeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minF = null,
    Object? maxF = null,
    Object? idealF = null,
  }) {
    return _then(_value.copyWith(
      minF: null == minF
          ? _value.minF
          : minF // ignore: cast_nullable_to_non_nullable
              as double,
      maxF: null == maxF
          ? _value.maxF
          : maxF // ignore: cast_nullable_to_non_nullable
              as double,
      idealF: null == idealF
          ? _value.idealF
          : idealF // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TemperatureRangeImplCopyWith<$Res>
    implements $TemperatureRangeCopyWith<$Res> {
  factory _$$TemperatureRangeImplCopyWith(_$TemperatureRangeImpl value,
          $Res Function(_$TemperatureRangeImpl) then) =
      __$$TemperatureRangeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double minF, double maxF, double idealF});
}

/// @nodoc
class __$$TemperatureRangeImplCopyWithImpl<$Res>
    extends _$TemperatureRangeCopyWithImpl<$Res, _$TemperatureRangeImpl>
    implements _$$TemperatureRangeImplCopyWith<$Res> {
  __$$TemperatureRangeImplCopyWithImpl(_$TemperatureRangeImpl _value,
      $Res Function(_$TemperatureRangeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minF = null,
    Object? maxF = null,
    Object? idealF = null,
  }) {
    return _then(_$TemperatureRangeImpl(
      minF: null == minF
          ? _value.minF
          : minF // ignore: cast_nullable_to_non_nullable
              as double,
      maxF: null == maxF
          ? _value.maxF
          : maxF // ignore: cast_nullable_to_non_nullable
              as double,
      idealF: null == idealF
          ? _value.idealF
          : idealF // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TemperatureRangeImpl implements _TemperatureRange {
  const _$TemperatureRangeImpl(
      {required this.minF, required this.maxF, required this.idealF});

  factory _$TemperatureRangeImpl.fromJson(Map<String, dynamic> json) =>
      _$$TemperatureRangeImplFromJson(json);

  @override
  final double minF;
  @override
  final double maxF;
  @override
  final double idealF;

  @override
  String toString() {
    return 'TemperatureRange(minF: $minF, maxF: $maxF, idealF: $idealF)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TemperatureRangeImpl &&
            (identical(other.minF, minF) || other.minF == minF) &&
            (identical(other.maxF, maxF) || other.maxF == maxF) &&
            (identical(other.idealF, idealF) || other.idealF == idealF));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, minF, maxF, idealF);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TemperatureRangeImplCopyWith<_$TemperatureRangeImpl> get copyWith =>
      __$$TemperatureRangeImplCopyWithImpl<_$TemperatureRangeImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TemperatureRangeImplToJson(
      this,
    );
  }
}

abstract class _TemperatureRange implements TemperatureRange {
  const factory _TemperatureRange(
      {required final double minF,
      required final double maxF,
      required final double idealF}) = _$TemperatureRangeImpl;

  factory _TemperatureRange.fromJson(Map<String, dynamic> json) =
      _$TemperatureRangeImpl.fromJson;

  @override
  double get minF;
  @override
  double get maxF;
  @override
  double get idealF;
  @override
  @JsonKey(ignore: true)
  _$$TemperatureRangeImplCopyWith<_$TemperatureRangeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DepthPreference _$DepthPreferenceFromJson(Map<String, dynamic> json) {
  return _DepthPreference.fromJson(json);
}

/// @nodoc
mixin _$DepthPreference {
  double get minFt => throw _privateConstructorUsedError;
  double get maxFt => throw _privateConstructorUsedError;
  double get idealFt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DepthPreferenceCopyWith<DepthPreference> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DepthPreferenceCopyWith<$Res> {
  factory $DepthPreferenceCopyWith(
          DepthPreference value, $Res Function(DepthPreference) then) =
      _$DepthPreferenceCopyWithImpl<$Res, DepthPreference>;
  @useResult
  $Res call({double minFt, double maxFt, double idealFt});
}

/// @nodoc
class _$DepthPreferenceCopyWithImpl<$Res, $Val extends DepthPreference>
    implements $DepthPreferenceCopyWith<$Res> {
  _$DepthPreferenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minFt = null,
    Object? maxFt = null,
    Object? idealFt = null,
  }) {
    return _then(_value.copyWith(
      minFt: null == minFt
          ? _value.minFt
          : minFt // ignore: cast_nullable_to_non_nullable
              as double,
      maxFt: null == maxFt
          ? _value.maxFt
          : maxFt // ignore: cast_nullable_to_non_nullable
              as double,
      idealFt: null == idealFt
          ? _value.idealFt
          : idealFt // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DepthPreferenceImplCopyWith<$Res>
    implements $DepthPreferenceCopyWith<$Res> {
  factory _$$DepthPreferenceImplCopyWith(_$DepthPreferenceImpl value,
          $Res Function(_$DepthPreferenceImpl) then) =
      __$$DepthPreferenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double minFt, double maxFt, double idealFt});
}

/// @nodoc
class __$$DepthPreferenceImplCopyWithImpl<$Res>
    extends _$DepthPreferenceCopyWithImpl<$Res, _$DepthPreferenceImpl>
    implements _$$DepthPreferenceImplCopyWith<$Res> {
  __$$DepthPreferenceImplCopyWithImpl(
      _$DepthPreferenceImpl _value, $Res Function(_$DepthPreferenceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minFt = null,
    Object? maxFt = null,
    Object? idealFt = null,
  }) {
    return _then(_$DepthPreferenceImpl(
      minFt: null == minFt
          ? _value.minFt
          : minFt // ignore: cast_nullable_to_non_nullable
              as double,
      maxFt: null == maxFt
          ? _value.maxFt
          : maxFt // ignore: cast_nullable_to_non_nullable
              as double,
      idealFt: null == idealFt
          ? _value.idealFt
          : idealFt // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DepthPreferenceImpl implements _DepthPreference {
  const _$DepthPreferenceImpl(
      {required this.minFt, required this.maxFt, required this.idealFt});

  factory _$DepthPreferenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$DepthPreferenceImplFromJson(json);

  @override
  final double minFt;
  @override
  final double maxFt;
  @override
  final double idealFt;

  @override
  String toString() {
    return 'DepthPreference(minFt: $minFt, maxFt: $maxFt, idealFt: $idealFt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DepthPreferenceImpl &&
            (identical(other.minFt, minFt) || other.minFt == minFt) &&
            (identical(other.maxFt, maxFt) || other.maxFt == maxFt) &&
            (identical(other.idealFt, idealFt) || other.idealFt == idealFt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, minFt, maxFt, idealFt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DepthPreferenceImplCopyWith<_$DepthPreferenceImpl> get copyWith =>
      __$$DepthPreferenceImplCopyWithImpl<_$DepthPreferenceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DepthPreferenceImplToJson(
      this,
    );
  }
}

abstract class _DepthPreference implements DepthPreference {
  const factory _DepthPreference(
      {required final double minFt,
      required final double maxFt,
      required final double idealFt}) = _$DepthPreferenceImpl;

  factory _DepthPreference.fromJson(Map<String, dynamic> json) =
      _$DepthPreferenceImpl.fromJson;

  @override
  double get minFt;
  @override
  double get maxFt;
  @override
  double get idealFt;
  @override
  @JsonKey(ignore: true)
  _$$DepthPreferenceImplCopyWith<_$DepthPreferenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StructurePreference _$StructurePreferenceFromJson(Map<String, dynamic> json) {
  return _StructurePreference.fromJson(json);
}

/// @nodoc
mixin _$StructurePreference {
  StructureType get type => throw _privateConstructorUsedError;
  double get weight => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StructurePreferenceCopyWith<StructurePreference> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StructurePreferenceCopyWith<$Res> {
  factory $StructurePreferenceCopyWith(
          StructurePreference value, $Res Function(StructurePreference) then) =
      _$StructurePreferenceCopyWithImpl<$Res, StructurePreference>;
  @useResult
  $Res call({StructureType type, double weight});
}

/// @nodoc
class _$StructurePreferenceCopyWithImpl<$Res, $Val extends StructurePreference>
    implements $StructurePreferenceCopyWith<$Res> {
  _$StructurePreferenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? weight = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as StructureType,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StructurePreferenceImplCopyWith<$Res>
    implements $StructurePreferenceCopyWith<$Res> {
  factory _$$StructurePreferenceImplCopyWith(_$StructurePreferenceImpl value,
          $Res Function(_$StructurePreferenceImpl) then) =
      __$$StructurePreferenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StructureType type, double weight});
}

/// @nodoc
class __$$StructurePreferenceImplCopyWithImpl<$Res>
    extends _$StructurePreferenceCopyWithImpl<$Res, _$StructurePreferenceImpl>
    implements _$$StructurePreferenceImplCopyWith<$Res> {
  __$$StructurePreferenceImplCopyWithImpl(_$StructurePreferenceImpl _value,
      $Res Function(_$StructurePreferenceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? weight = null,
  }) {
    return _then(_$StructurePreferenceImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as StructureType,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StructurePreferenceImpl implements _StructurePreference {
  const _$StructurePreferenceImpl({required this.type, required this.weight});

  factory _$StructurePreferenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$StructurePreferenceImplFromJson(json);

  @override
  final StructureType type;
  @override
  final double weight;

  @override
  String toString() {
    return 'StructurePreference(type: $type, weight: $weight)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StructurePreferenceImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.weight, weight) || other.weight == weight));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, weight);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StructurePreferenceImplCopyWith<_$StructurePreferenceImpl> get copyWith =>
      __$$StructurePreferenceImplCopyWithImpl<_$StructurePreferenceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StructurePreferenceImplToJson(
      this,
    );
  }
}

abstract class _StructurePreference implements StructurePreference {
  const factory _StructurePreference(
      {required final StructureType type,
      required final double weight}) = _$StructurePreferenceImpl;

  factory _StructurePreference.fromJson(Map<String, dynamic> json) =
      _$StructurePreferenceImpl.fromJson;

  @override
  StructureType get type;
  @override
  double get weight;
  @override
  @JsonKey(ignore: true)
  _$$StructurePreferenceImplCopyWith<_$StructurePreferenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TidePreference _$TidePreferenceFromJson(Map<String, dynamic> json) {
  return _TidePreference.fromJson(json);
}

/// @nodoc
mixin _$TidePreference {
  Map<TidePhase, double> get phaseWeights => throw _privateConstructorUsedError;
  bool get prefersSpringTides => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TidePreferenceCopyWith<TidePreference> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TidePreferenceCopyWith<$Res> {
  factory $TidePreferenceCopyWith(
          TidePreference value, $Res Function(TidePreference) then) =
      _$TidePreferenceCopyWithImpl<$Res, TidePreference>;
  @useResult
  $Res call({Map<TidePhase, double> phaseWeights, bool prefersSpringTides});
}

/// @nodoc
class _$TidePreferenceCopyWithImpl<$Res, $Val extends TidePreference>
    implements $TidePreferenceCopyWith<$Res> {
  _$TidePreferenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phaseWeights = null,
    Object? prefersSpringTides = null,
  }) {
    return _then(_value.copyWith(
      phaseWeights: null == phaseWeights
          ? _value.phaseWeights
          : phaseWeights // ignore: cast_nullable_to_non_nullable
              as Map<TidePhase, double>,
      prefersSpringTides: null == prefersSpringTides
          ? _value.prefersSpringTides
          : prefersSpringTides // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TidePreferenceImplCopyWith<$Res>
    implements $TidePreferenceCopyWith<$Res> {
  factory _$$TidePreferenceImplCopyWith(_$TidePreferenceImpl value,
          $Res Function(_$TidePreferenceImpl) then) =
      __$$TidePreferenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<TidePhase, double> phaseWeights, bool prefersSpringTides});
}

/// @nodoc
class __$$TidePreferenceImplCopyWithImpl<$Res>
    extends _$TidePreferenceCopyWithImpl<$Res, _$TidePreferenceImpl>
    implements _$$TidePreferenceImplCopyWith<$Res> {
  __$$TidePreferenceImplCopyWithImpl(
      _$TidePreferenceImpl _value, $Res Function(_$TidePreferenceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phaseWeights = null,
    Object? prefersSpringTides = null,
  }) {
    return _then(_$TidePreferenceImpl(
      phaseWeights: null == phaseWeights
          ? _value._phaseWeights
          : phaseWeights // ignore: cast_nullable_to_non_nullable
              as Map<TidePhase, double>,
      prefersSpringTides: null == prefersSpringTides
          ? _value.prefersSpringTides
          : prefersSpringTides // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TidePreferenceImpl implements _TidePreference {
  const _$TidePreferenceImpl(
      {required final Map<TidePhase, double> phaseWeights,
      this.prefersSpringTides = false})
      : _phaseWeights = phaseWeights;

  factory _$TidePreferenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$TidePreferenceImplFromJson(json);

  final Map<TidePhase, double> _phaseWeights;
  @override
  Map<TidePhase, double> get phaseWeights {
    if (_phaseWeights is EqualUnmodifiableMapView) return _phaseWeights;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_phaseWeights);
  }

  @override
  @JsonKey()
  final bool prefersSpringTides;

  @override
  String toString() {
    return 'TidePreference(phaseWeights: $phaseWeights, prefersSpringTides: $prefersSpringTides)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TidePreferenceImpl &&
            const DeepCollectionEquality()
                .equals(other._phaseWeights, _phaseWeights) &&
            (identical(other.prefersSpringTides, prefersSpringTides) ||
                other.prefersSpringTides == prefersSpringTides));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_phaseWeights), prefersSpringTides);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TidePreferenceImplCopyWith<_$TidePreferenceImpl> get copyWith =>
      __$$TidePreferenceImplCopyWithImpl<_$TidePreferenceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TidePreferenceImplToJson(
      this,
    );
  }
}

abstract class _TidePreference implements TidePreference {
  const factory _TidePreference(
      {required final Map<TidePhase, double> phaseWeights,
      final bool prefersSpringTides}) = _$TidePreferenceImpl;

  factory _TidePreference.fromJson(Map<String, dynamic> json) =
      _$TidePreferenceImpl.fromJson;

  @override
  Map<TidePhase, double> get phaseWeights;
  @override
  bool get prefersSpringTides;
  @override
  @JsonKey(ignore: true)
  _$$TidePreferenceImplCopyWith<_$TidePreferenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TimeOfDayPreference _$TimeOfDayPreferenceFromJson(Map<String, dynamic> json) {
  return _TimeOfDayPreference.fromJson(json);
}

/// @nodoc
mixin _$TimeOfDayPreference {
  int get startHour => throw _privateConstructorUsedError;
  int get endHour => throw _privateConstructorUsedError;
  double get weight => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimeOfDayPreferenceCopyWith<TimeOfDayPreference> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeOfDayPreferenceCopyWith<$Res> {
  factory $TimeOfDayPreferenceCopyWith(
          TimeOfDayPreference value, $Res Function(TimeOfDayPreference) then) =
      _$TimeOfDayPreferenceCopyWithImpl<$Res, TimeOfDayPreference>;
  @useResult
  $Res call({int startHour, int endHour, double weight});
}

/// @nodoc
class _$TimeOfDayPreferenceCopyWithImpl<$Res, $Val extends TimeOfDayPreference>
    implements $TimeOfDayPreferenceCopyWith<$Res> {
  _$TimeOfDayPreferenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startHour = null,
    Object? endHour = null,
    Object? weight = null,
  }) {
    return _then(_value.copyWith(
      startHour: null == startHour
          ? _value.startHour
          : startHour // ignore: cast_nullable_to_non_nullable
              as int,
      endHour: null == endHour
          ? _value.endHour
          : endHour // ignore: cast_nullable_to_non_nullable
              as int,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimeOfDayPreferenceImplCopyWith<$Res>
    implements $TimeOfDayPreferenceCopyWith<$Res> {
  factory _$$TimeOfDayPreferenceImplCopyWith(_$TimeOfDayPreferenceImpl value,
          $Res Function(_$TimeOfDayPreferenceImpl) then) =
      __$$TimeOfDayPreferenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int startHour, int endHour, double weight});
}

/// @nodoc
class __$$TimeOfDayPreferenceImplCopyWithImpl<$Res>
    extends _$TimeOfDayPreferenceCopyWithImpl<$Res, _$TimeOfDayPreferenceImpl>
    implements _$$TimeOfDayPreferenceImplCopyWith<$Res> {
  __$$TimeOfDayPreferenceImplCopyWithImpl(_$TimeOfDayPreferenceImpl _value,
      $Res Function(_$TimeOfDayPreferenceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startHour = null,
    Object? endHour = null,
    Object? weight = null,
  }) {
    return _then(_$TimeOfDayPreferenceImpl(
      startHour: null == startHour
          ? _value.startHour
          : startHour // ignore: cast_nullable_to_non_nullable
              as int,
      endHour: null == endHour
          ? _value.endHour
          : endHour // ignore: cast_nullable_to_non_nullable
              as int,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimeOfDayPreferenceImpl implements _TimeOfDayPreference {
  const _$TimeOfDayPreferenceImpl(
      {required this.startHour, required this.endHour, required this.weight});

  factory _$TimeOfDayPreferenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeOfDayPreferenceImplFromJson(json);

  @override
  final int startHour;
  @override
  final int endHour;
  @override
  final double weight;

  @override
  String toString() {
    return 'TimeOfDayPreference(startHour: $startHour, endHour: $endHour, weight: $weight)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeOfDayPreferenceImpl &&
            (identical(other.startHour, startHour) ||
                other.startHour == startHour) &&
            (identical(other.endHour, endHour) || other.endHour == endHour) &&
            (identical(other.weight, weight) || other.weight == weight));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, startHour, endHour, weight);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeOfDayPreferenceImplCopyWith<_$TimeOfDayPreferenceImpl> get copyWith =>
      __$$TimeOfDayPreferenceImplCopyWithImpl<_$TimeOfDayPreferenceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeOfDayPreferenceImplToJson(
      this,
    );
  }
}

abstract class _TimeOfDayPreference implements TimeOfDayPreference {
  const factory _TimeOfDayPreference(
      {required final int startHour,
      required final int endHour,
      required final double weight}) = _$TimeOfDayPreferenceImpl;

  factory _TimeOfDayPreference.fromJson(Map<String, dynamic> json) =
      _$TimeOfDayPreferenceImpl.fromJson;

  @override
  int get startHour;
  @override
  int get endHour;
  @override
  double get weight;
  @override
  @JsonKey(ignore: true)
  _$$TimeOfDayPreferenceImplCopyWith<_$TimeOfDayPreferenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WeatherSensitivity _$WeatherSensitivityFromJson(Map<String, dynamic> json) {
  return _WeatherSensitivity.fromJson(json);
}

/// @nodoc
mixin _$WeatherSensitivity {
  double get risingPressureFactor => throw _privateConstructorUsedError;
  double get fallingPressureFactor => throw _privateConstructorUsedError;
  double get frontalPassageFactor => throw _privateConstructorUsedError;
  double get cloudCoverPreference => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeatherSensitivityCopyWith<WeatherSensitivity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherSensitivityCopyWith<$Res> {
  factory $WeatherSensitivityCopyWith(
          WeatherSensitivity value, $Res Function(WeatherSensitivity) then) =
      _$WeatherSensitivityCopyWithImpl<$Res, WeatherSensitivity>;
  @useResult
  $Res call(
      {double risingPressureFactor,
      double fallingPressureFactor,
      double frontalPassageFactor,
      double cloudCoverPreference});
}

/// @nodoc
class _$WeatherSensitivityCopyWithImpl<$Res, $Val extends WeatherSensitivity>
    implements $WeatherSensitivityCopyWith<$Res> {
  _$WeatherSensitivityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? risingPressureFactor = null,
    Object? fallingPressureFactor = null,
    Object? frontalPassageFactor = null,
    Object? cloudCoverPreference = null,
  }) {
    return _then(_value.copyWith(
      risingPressureFactor: null == risingPressureFactor
          ? _value.risingPressureFactor
          : risingPressureFactor // ignore: cast_nullable_to_non_nullable
              as double,
      fallingPressureFactor: null == fallingPressureFactor
          ? _value.fallingPressureFactor
          : fallingPressureFactor // ignore: cast_nullable_to_non_nullable
              as double,
      frontalPassageFactor: null == frontalPassageFactor
          ? _value.frontalPassageFactor
          : frontalPassageFactor // ignore: cast_nullable_to_non_nullable
              as double,
      cloudCoverPreference: null == cloudCoverPreference
          ? _value.cloudCoverPreference
          : cloudCoverPreference // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeatherSensitivityImplCopyWith<$Res>
    implements $WeatherSensitivityCopyWith<$Res> {
  factory _$$WeatherSensitivityImplCopyWith(_$WeatherSensitivityImpl value,
          $Res Function(_$WeatherSensitivityImpl) then) =
      __$$WeatherSensitivityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double risingPressureFactor,
      double fallingPressureFactor,
      double frontalPassageFactor,
      double cloudCoverPreference});
}

/// @nodoc
class __$$WeatherSensitivityImplCopyWithImpl<$Res>
    extends _$WeatherSensitivityCopyWithImpl<$Res, _$WeatherSensitivityImpl>
    implements _$$WeatherSensitivityImplCopyWith<$Res> {
  __$$WeatherSensitivityImplCopyWithImpl(_$WeatherSensitivityImpl _value,
      $Res Function(_$WeatherSensitivityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? risingPressureFactor = null,
    Object? fallingPressureFactor = null,
    Object? frontalPassageFactor = null,
    Object? cloudCoverPreference = null,
  }) {
    return _then(_$WeatherSensitivityImpl(
      risingPressureFactor: null == risingPressureFactor
          ? _value.risingPressureFactor
          : risingPressureFactor // ignore: cast_nullable_to_non_nullable
              as double,
      fallingPressureFactor: null == fallingPressureFactor
          ? _value.fallingPressureFactor
          : fallingPressureFactor // ignore: cast_nullable_to_non_nullable
              as double,
      frontalPassageFactor: null == frontalPassageFactor
          ? _value.frontalPassageFactor
          : frontalPassageFactor // ignore: cast_nullable_to_non_nullable
              as double,
      cloudCoverPreference: null == cloudCoverPreference
          ? _value.cloudCoverPreference
          : cloudCoverPreference // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeatherSensitivityImpl implements _WeatherSensitivity {
  const _$WeatherSensitivityImpl(
      {required this.risingPressureFactor,
      required this.fallingPressureFactor,
      required this.frontalPassageFactor,
      required this.cloudCoverPreference});

  factory _$WeatherSensitivityImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeatherSensitivityImplFromJson(json);

  @override
  final double risingPressureFactor;
  @override
  final double fallingPressureFactor;
  @override
  final double frontalPassageFactor;
  @override
  final double cloudCoverPreference;

  @override
  String toString() {
    return 'WeatherSensitivity(risingPressureFactor: $risingPressureFactor, fallingPressureFactor: $fallingPressureFactor, frontalPassageFactor: $frontalPassageFactor, cloudCoverPreference: $cloudCoverPreference)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeatherSensitivityImpl &&
            (identical(other.risingPressureFactor, risingPressureFactor) ||
                other.risingPressureFactor == risingPressureFactor) &&
            (identical(other.fallingPressureFactor, fallingPressureFactor) ||
                other.fallingPressureFactor == fallingPressureFactor) &&
            (identical(other.frontalPassageFactor, frontalPassageFactor) ||
                other.frontalPassageFactor == frontalPassageFactor) &&
            (identical(other.cloudCoverPreference, cloudCoverPreference) ||
                other.cloudCoverPreference == cloudCoverPreference));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, risingPressureFactor,
      fallingPressureFactor, frontalPassageFactor, cloudCoverPreference);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeatherSensitivityImplCopyWith<_$WeatherSensitivityImpl> get copyWith =>
      __$$WeatherSensitivityImplCopyWithImpl<_$WeatherSensitivityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeatherSensitivityImplToJson(
      this,
    );
  }
}

abstract class _WeatherSensitivity implements WeatherSensitivity {
  const factory _WeatherSensitivity(
      {required final double risingPressureFactor,
      required final double fallingPressureFactor,
      required final double frontalPassageFactor,
      required final double cloudCoverPreference}) = _$WeatherSensitivityImpl;

  factory _WeatherSensitivity.fromJson(Map<String, dynamic> json) =
      _$WeatherSensitivityImpl.fromJson;

  @override
  double get risingPressureFactor;
  @override
  double get fallingPressureFactor;
  @override
  double get frontalPassageFactor;
  @override
  double get cloudCoverPreference;
  @override
  @JsonKey(ignore: true)
  _$$WeatherSensitivityImplCopyWith<_$WeatherSensitivityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SalinityPreference _$SalinityPreferenceFromJson(Map<String, dynamic> json) {
  return _SalinityPreference.fromJson(json);
}

/// @nodoc
mixin _$SalinityPreference {
  double get minPpt => throw _privateConstructorUsedError;
  double get maxPpt => throw _privateConstructorUsedError;
  double get idealPpt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SalinityPreferenceCopyWith<SalinityPreference> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalinityPreferenceCopyWith<$Res> {
  factory $SalinityPreferenceCopyWith(
          SalinityPreference value, $Res Function(SalinityPreference) then) =
      _$SalinityPreferenceCopyWithImpl<$Res, SalinityPreference>;
  @useResult
  $Res call({double minPpt, double maxPpt, double idealPpt});
}

/// @nodoc
class _$SalinityPreferenceCopyWithImpl<$Res, $Val extends SalinityPreference>
    implements $SalinityPreferenceCopyWith<$Res> {
  _$SalinityPreferenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minPpt = null,
    Object? maxPpt = null,
    Object? idealPpt = null,
  }) {
    return _then(_value.copyWith(
      minPpt: null == minPpt
          ? _value.minPpt
          : minPpt // ignore: cast_nullable_to_non_nullable
              as double,
      maxPpt: null == maxPpt
          ? _value.maxPpt
          : maxPpt // ignore: cast_nullable_to_non_nullable
              as double,
      idealPpt: null == idealPpt
          ? _value.idealPpt
          : idealPpt // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SalinityPreferenceImplCopyWith<$Res>
    implements $SalinityPreferenceCopyWith<$Res> {
  factory _$$SalinityPreferenceImplCopyWith(_$SalinityPreferenceImpl value,
          $Res Function(_$SalinityPreferenceImpl) then) =
      __$$SalinityPreferenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double minPpt, double maxPpt, double idealPpt});
}

/// @nodoc
class __$$SalinityPreferenceImplCopyWithImpl<$Res>
    extends _$SalinityPreferenceCopyWithImpl<$Res, _$SalinityPreferenceImpl>
    implements _$$SalinityPreferenceImplCopyWith<$Res> {
  __$$SalinityPreferenceImplCopyWithImpl(_$SalinityPreferenceImpl _value,
      $Res Function(_$SalinityPreferenceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minPpt = null,
    Object? maxPpt = null,
    Object? idealPpt = null,
  }) {
    return _then(_$SalinityPreferenceImpl(
      minPpt: null == minPpt
          ? _value.minPpt
          : minPpt // ignore: cast_nullable_to_non_nullable
              as double,
      maxPpt: null == maxPpt
          ? _value.maxPpt
          : maxPpt // ignore: cast_nullable_to_non_nullable
              as double,
      idealPpt: null == idealPpt
          ? _value.idealPpt
          : idealPpt // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SalinityPreferenceImpl implements _SalinityPreference {
  const _$SalinityPreferenceImpl(
      {required this.minPpt, required this.maxPpt, required this.idealPpt});

  factory _$SalinityPreferenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$SalinityPreferenceImplFromJson(json);

  @override
  final double minPpt;
  @override
  final double maxPpt;
  @override
  final double idealPpt;

  @override
  String toString() {
    return 'SalinityPreference(minPpt: $minPpt, maxPpt: $maxPpt, idealPpt: $idealPpt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalinityPreferenceImpl &&
            (identical(other.minPpt, minPpt) || other.minPpt == minPpt) &&
            (identical(other.maxPpt, maxPpt) || other.maxPpt == maxPpt) &&
            (identical(other.idealPpt, idealPpt) ||
                other.idealPpt == idealPpt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, minPpt, maxPpt, idealPpt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SalinityPreferenceImplCopyWith<_$SalinityPreferenceImpl> get copyWith =>
      __$$SalinityPreferenceImplCopyWithImpl<_$SalinityPreferenceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SalinityPreferenceImplToJson(
      this,
    );
  }
}

abstract class _SalinityPreference implements SalinityPreference {
  const factory _SalinityPreference(
      {required final double minPpt,
      required final double maxPpt,
      required final double idealPpt}) = _$SalinityPreferenceImpl;

  factory _SalinityPreference.fromJson(Map<String, dynamic> json) =
      _$SalinityPreferenceImpl.fromJson;

  @override
  double get minPpt;
  @override
  double get maxPpt;
  @override
  double get idealPpt;
  @override
  @JsonKey(ignore: true)
  _$$SalinityPreferenceImplCopyWith<_$SalinityPreferenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CurrentPreference _$CurrentPreferenceFromJson(Map<String, dynamic> json) {
  return _CurrentPreference.fromJson(json);
}

/// @nodoc
mixin _$CurrentPreference {
  double get minKnots => throw _privateConstructorUsedError;
  double get maxKnots => throw _privateConstructorUsedError;
  double get idealKnots => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CurrentPreferenceCopyWith<CurrentPreference> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrentPreferenceCopyWith<$Res> {
  factory $CurrentPreferenceCopyWith(
          CurrentPreference value, $Res Function(CurrentPreference) then) =
      _$CurrentPreferenceCopyWithImpl<$Res, CurrentPreference>;
  @useResult
  $Res call({double minKnots, double maxKnots, double idealKnots});
}

/// @nodoc
class _$CurrentPreferenceCopyWithImpl<$Res, $Val extends CurrentPreference>
    implements $CurrentPreferenceCopyWith<$Res> {
  _$CurrentPreferenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minKnots = null,
    Object? maxKnots = null,
    Object? idealKnots = null,
  }) {
    return _then(_value.copyWith(
      minKnots: null == minKnots
          ? _value.minKnots
          : minKnots // ignore: cast_nullable_to_non_nullable
              as double,
      maxKnots: null == maxKnots
          ? _value.maxKnots
          : maxKnots // ignore: cast_nullable_to_non_nullable
              as double,
      idealKnots: null == idealKnots
          ? _value.idealKnots
          : idealKnots // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CurrentPreferenceImplCopyWith<$Res>
    implements $CurrentPreferenceCopyWith<$Res> {
  factory _$$CurrentPreferenceImplCopyWith(_$CurrentPreferenceImpl value,
          $Res Function(_$CurrentPreferenceImpl) then) =
      __$$CurrentPreferenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double minKnots, double maxKnots, double idealKnots});
}

/// @nodoc
class __$$CurrentPreferenceImplCopyWithImpl<$Res>
    extends _$CurrentPreferenceCopyWithImpl<$Res, _$CurrentPreferenceImpl>
    implements _$$CurrentPreferenceImplCopyWith<$Res> {
  __$$CurrentPreferenceImplCopyWithImpl(_$CurrentPreferenceImpl _value,
      $Res Function(_$CurrentPreferenceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minKnots = null,
    Object? maxKnots = null,
    Object? idealKnots = null,
  }) {
    return _then(_$CurrentPreferenceImpl(
      minKnots: null == minKnots
          ? _value.minKnots
          : minKnots // ignore: cast_nullable_to_non_nullable
              as double,
      maxKnots: null == maxKnots
          ? _value.maxKnots
          : maxKnots // ignore: cast_nullable_to_non_nullable
              as double,
      idealKnots: null == idealKnots
          ? _value.idealKnots
          : idealKnots // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CurrentPreferenceImpl implements _CurrentPreference {
  const _$CurrentPreferenceImpl(
      {required this.minKnots,
      required this.maxKnots,
      required this.idealKnots});

  factory _$CurrentPreferenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$CurrentPreferenceImplFromJson(json);

  @override
  final double minKnots;
  @override
  final double maxKnots;
  @override
  final double idealKnots;

  @override
  String toString() {
    return 'CurrentPreference(minKnots: $minKnots, maxKnots: $maxKnots, idealKnots: $idealKnots)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CurrentPreferenceImpl &&
            (identical(other.minKnots, minKnots) ||
                other.minKnots == minKnots) &&
            (identical(other.maxKnots, maxKnots) ||
                other.maxKnots == maxKnots) &&
            (identical(other.idealKnots, idealKnots) ||
                other.idealKnots == idealKnots));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, minKnots, maxKnots, idealKnots);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CurrentPreferenceImplCopyWith<_$CurrentPreferenceImpl> get copyWith =>
      __$$CurrentPreferenceImplCopyWithImpl<_$CurrentPreferenceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CurrentPreferenceImplToJson(
      this,
    );
  }
}

abstract class _CurrentPreference implements CurrentPreference {
  const factory _CurrentPreference(
      {required final double minKnots,
      required final double maxKnots,
      required final double idealKnots}) = _$CurrentPreferenceImpl;

  factory _CurrentPreference.fromJson(Map<String, dynamic> json) =
      _$CurrentPreferenceImpl.fromJson;

  @override
  double get minKnots;
  @override
  double get maxKnots;
  @override
  double get idealKnots;
  @override
  @JsonKey(ignore: true)
  _$$CurrentPreferenceImplCopyWith<_$CurrentPreferenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BaitAssociation _$BaitAssociationFromJson(Map<String, dynamic> json) {
  return _BaitAssociation.fromJson(json);
}

/// @nodoc
mixin _$BaitAssociation {
  String get baitfish => throw _privateConstructorUsedError;
  double get weight => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BaitAssociationCopyWith<BaitAssociation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BaitAssociationCopyWith<$Res> {
  factory $BaitAssociationCopyWith(
          BaitAssociation value, $Res Function(BaitAssociation) then) =
      _$BaitAssociationCopyWithImpl<$Res, BaitAssociation>;
  @useResult
  $Res call({String baitfish, double weight});
}

/// @nodoc
class _$BaitAssociationCopyWithImpl<$Res, $Val extends BaitAssociation>
    implements $BaitAssociationCopyWith<$Res> {
  _$BaitAssociationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? baitfish = null,
    Object? weight = null,
  }) {
    return _then(_value.copyWith(
      baitfish: null == baitfish
          ? _value.baitfish
          : baitfish // ignore: cast_nullable_to_non_nullable
              as String,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BaitAssociationImplCopyWith<$Res>
    implements $BaitAssociationCopyWith<$Res> {
  factory _$$BaitAssociationImplCopyWith(_$BaitAssociationImpl value,
          $Res Function(_$BaitAssociationImpl) then) =
      __$$BaitAssociationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String baitfish, double weight});
}

/// @nodoc
class __$$BaitAssociationImplCopyWithImpl<$Res>
    extends _$BaitAssociationCopyWithImpl<$Res, _$BaitAssociationImpl>
    implements _$$BaitAssociationImplCopyWith<$Res> {
  __$$BaitAssociationImplCopyWithImpl(
      _$BaitAssociationImpl _value, $Res Function(_$BaitAssociationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? baitfish = null,
    Object? weight = null,
  }) {
    return _then(_$BaitAssociationImpl(
      baitfish: null == baitfish
          ? _value.baitfish
          : baitfish // ignore: cast_nullable_to_non_nullable
              as String,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BaitAssociationImpl implements _BaitAssociation {
  const _$BaitAssociationImpl({required this.baitfish, required this.weight});

  factory _$BaitAssociationImpl.fromJson(Map<String, dynamic> json) =>
      _$$BaitAssociationImplFromJson(json);

  @override
  final String baitfish;
  @override
  final double weight;

  @override
  String toString() {
    return 'BaitAssociation(baitfish: $baitfish, weight: $weight)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BaitAssociationImpl &&
            (identical(other.baitfish, baitfish) ||
                other.baitfish == baitfish) &&
            (identical(other.weight, weight) || other.weight == weight));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, baitfish, weight);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BaitAssociationImplCopyWith<_$BaitAssociationImpl> get copyWith =>
      __$$BaitAssociationImplCopyWithImpl<_$BaitAssociationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BaitAssociationImplToJson(
      this,
    );
  }
}

abstract class _BaitAssociation implements BaitAssociation {
  const factory _BaitAssociation(
      {required final String baitfish,
      required final double weight}) = _$BaitAssociationImpl;

  factory _BaitAssociation.fromJson(Map<String, dynamic> json) =
      _$BaitAssociationImpl.fromJson;

  @override
  String get baitfish;
  @override
  double get weight;
  @override
  @JsonKey(ignore: true)
  _$$BaitAssociationImplCopyWith<_$BaitAssociationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
