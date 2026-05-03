// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'migration_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MigrationModel _$MigrationModelFromJson(Map<String, dynamic> json) {
  return _MigrationModel.fromJson(json);
}

/// @nodoc
mixin _$MigrationModel {
  GeoPolygon get spatialRange => throw _privateConstructorUsedError;
  List<Population> get populations => throw _privateConstructorUsedError;
  List<RegionalPresenceCurve> get regionalCurves =>
      throw _privateConstructorUsedError;
  List<MigrationCorridor> get corridors => throw _privateConstructorUsedError;
  List<TriggerRule> get triggers => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MigrationModelCopyWith<MigrationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MigrationModelCopyWith<$Res> {
  factory $MigrationModelCopyWith(
          MigrationModel value, $Res Function(MigrationModel) then) =
      _$MigrationModelCopyWithImpl<$Res, MigrationModel>;
  @useResult
  $Res call(
      {GeoPolygon spatialRange,
      List<Population> populations,
      List<RegionalPresenceCurve> regionalCurves,
      List<MigrationCorridor> corridors,
      List<TriggerRule> triggers});

  $GeoPolygonCopyWith<$Res> get spatialRange;
}

/// @nodoc
class _$MigrationModelCopyWithImpl<$Res, $Val extends MigrationModel>
    implements $MigrationModelCopyWith<$Res> {
  _$MigrationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? spatialRange = null,
    Object? populations = null,
    Object? regionalCurves = null,
    Object? corridors = null,
    Object? triggers = null,
  }) {
    return _then(_value.copyWith(
      spatialRange: null == spatialRange
          ? _value.spatialRange
          : spatialRange // ignore: cast_nullable_to_non_nullable
              as GeoPolygon,
      populations: null == populations
          ? _value.populations
          : populations // ignore: cast_nullable_to_non_nullable
              as List<Population>,
      regionalCurves: null == regionalCurves
          ? _value.regionalCurves
          : regionalCurves // ignore: cast_nullable_to_non_nullable
              as List<RegionalPresenceCurve>,
      corridors: null == corridors
          ? _value.corridors
          : corridors // ignore: cast_nullable_to_non_nullable
              as List<MigrationCorridor>,
      triggers: null == triggers
          ? _value.triggers
          : triggers // ignore: cast_nullable_to_non_nullable
              as List<TriggerRule>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GeoPolygonCopyWith<$Res> get spatialRange {
    return $GeoPolygonCopyWith<$Res>(_value.spatialRange, (value) {
      return _then(_value.copyWith(spatialRange: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MigrationModelImplCopyWith<$Res>
    implements $MigrationModelCopyWith<$Res> {
  factory _$$MigrationModelImplCopyWith(_$MigrationModelImpl value,
          $Res Function(_$MigrationModelImpl) then) =
      __$$MigrationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {GeoPolygon spatialRange,
      List<Population> populations,
      List<RegionalPresenceCurve> regionalCurves,
      List<MigrationCorridor> corridors,
      List<TriggerRule> triggers});

  @override
  $GeoPolygonCopyWith<$Res> get spatialRange;
}

/// @nodoc
class __$$MigrationModelImplCopyWithImpl<$Res>
    extends _$MigrationModelCopyWithImpl<$Res, _$MigrationModelImpl>
    implements _$$MigrationModelImplCopyWith<$Res> {
  __$$MigrationModelImplCopyWithImpl(
      _$MigrationModelImpl _value, $Res Function(_$MigrationModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? spatialRange = null,
    Object? populations = null,
    Object? regionalCurves = null,
    Object? corridors = null,
    Object? triggers = null,
  }) {
    return _then(_$MigrationModelImpl(
      spatialRange: null == spatialRange
          ? _value.spatialRange
          : spatialRange // ignore: cast_nullable_to_non_nullable
              as GeoPolygon,
      populations: null == populations
          ? _value._populations
          : populations // ignore: cast_nullable_to_non_nullable
              as List<Population>,
      regionalCurves: null == regionalCurves
          ? _value._regionalCurves
          : regionalCurves // ignore: cast_nullable_to_non_nullable
              as List<RegionalPresenceCurve>,
      corridors: null == corridors
          ? _value._corridors
          : corridors // ignore: cast_nullable_to_non_nullable
              as List<MigrationCorridor>,
      triggers: null == triggers
          ? _value._triggers
          : triggers // ignore: cast_nullable_to_non_nullable
              as List<TriggerRule>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MigrationModelImpl implements _MigrationModel {
  const _$MigrationModelImpl(
      {required this.spatialRange,
      final List<Population> populations = const <Population>[],
      final List<RegionalPresenceCurve> regionalCurves =
          const <RegionalPresenceCurve>[],
      final List<MigrationCorridor> corridors = const <MigrationCorridor>[],
      final List<TriggerRule> triggers = const <TriggerRule>[]})
      : _populations = populations,
        _regionalCurves = regionalCurves,
        _corridors = corridors,
        _triggers = triggers;

  factory _$MigrationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MigrationModelImplFromJson(json);

  @override
  final GeoPolygon spatialRange;
  final List<Population> _populations;
  @override
  @JsonKey()
  List<Population> get populations {
    if (_populations is EqualUnmodifiableListView) return _populations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_populations);
  }

  final List<RegionalPresenceCurve> _regionalCurves;
  @override
  @JsonKey()
  List<RegionalPresenceCurve> get regionalCurves {
    if (_regionalCurves is EqualUnmodifiableListView) return _regionalCurves;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_regionalCurves);
  }

  final List<MigrationCorridor> _corridors;
  @override
  @JsonKey()
  List<MigrationCorridor> get corridors {
    if (_corridors is EqualUnmodifiableListView) return _corridors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_corridors);
  }

  final List<TriggerRule> _triggers;
  @override
  @JsonKey()
  List<TriggerRule> get triggers {
    if (_triggers is EqualUnmodifiableListView) return _triggers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_triggers);
  }

  @override
  String toString() {
    return 'MigrationModel(spatialRange: $spatialRange, populations: $populations, regionalCurves: $regionalCurves, corridors: $corridors, triggers: $triggers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MigrationModelImpl &&
            (identical(other.spatialRange, spatialRange) ||
                other.spatialRange == spatialRange) &&
            const DeepCollectionEquality()
                .equals(other._populations, _populations) &&
            const DeepCollectionEquality()
                .equals(other._regionalCurves, _regionalCurves) &&
            const DeepCollectionEquality()
                .equals(other._corridors, _corridors) &&
            const DeepCollectionEquality().equals(other._triggers, _triggers));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      spatialRange,
      const DeepCollectionEquality().hash(_populations),
      const DeepCollectionEquality().hash(_regionalCurves),
      const DeepCollectionEquality().hash(_corridors),
      const DeepCollectionEquality().hash(_triggers));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MigrationModelImplCopyWith<_$MigrationModelImpl> get copyWith =>
      __$$MigrationModelImplCopyWithImpl<_$MigrationModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MigrationModelImplToJson(
      this,
    );
  }
}

abstract class _MigrationModel implements MigrationModel {
  const factory _MigrationModel(
      {required final GeoPolygon spatialRange,
      final List<Population> populations,
      final List<RegionalPresenceCurve> regionalCurves,
      final List<MigrationCorridor> corridors,
      final List<TriggerRule> triggers}) = _$MigrationModelImpl;

  factory _MigrationModel.fromJson(Map<String, dynamic> json) =
      _$MigrationModelImpl.fromJson;

  @override
  GeoPolygon get spatialRange;
  @override
  List<Population> get populations;
  @override
  List<RegionalPresenceCurve> get regionalCurves;
  @override
  List<MigrationCorridor> get corridors;
  @override
  List<TriggerRule> get triggers;
  @override
  @JsonKey(ignore: true)
  _$$MigrationModelImplCopyWith<_$MigrationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Population _$PopulationFromJson(Map<String, dynamic> json) {
  return _Population.fromJson(json);
}

/// @nodoc
mixin _$Population {
  String get id => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get regionIds => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PopulationCopyWith<Population> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PopulationCopyWith<$Res> {
  factory $PopulationCopyWith(
          Population value, $Res Function(Population) then) =
      _$PopulationCopyWithImpl<$Res, Population>;
  @useResult
  $Res call(
      {String id,
      String displayName,
      String description,
      List<String> regionIds});
}

/// @nodoc
class _$PopulationCopyWithImpl<$Res, $Val extends Population>
    implements $PopulationCopyWith<$Res> {
  _$PopulationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? description = null,
    Object? regionIds = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      regionIds: null == regionIds
          ? _value.regionIds
          : regionIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PopulationImplCopyWith<$Res>
    implements $PopulationCopyWith<$Res> {
  factory _$$PopulationImplCopyWith(
          _$PopulationImpl value, $Res Function(_$PopulationImpl) then) =
      __$$PopulationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String displayName,
      String description,
      List<String> regionIds});
}

/// @nodoc
class __$$PopulationImplCopyWithImpl<$Res>
    extends _$PopulationCopyWithImpl<$Res, _$PopulationImpl>
    implements _$$PopulationImplCopyWith<$Res> {
  __$$PopulationImplCopyWithImpl(
      _$PopulationImpl _value, $Res Function(_$PopulationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? description = null,
    Object? regionIds = null,
  }) {
    return _then(_$PopulationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      regionIds: null == regionIds
          ? _value._regionIds
          : regionIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PopulationImpl implements _Population {
  const _$PopulationImpl(
      {required this.id,
      required this.displayName,
      required this.description,
      final List<String> regionIds = const <String>[]})
      : _regionIds = regionIds;

  factory _$PopulationImpl.fromJson(Map<String, dynamic> json) =>
      _$$PopulationImplFromJson(json);

  @override
  final String id;
  @override
  final String displayName;
  @override
  final String description;
  final List<String> _regionIds;
  @override
  @JsonKey()
  List<String> get regionIds {
    if (_regionIds is EqualUnmodifiableListView) return _regionIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_regionIds);
  }

  @override
  String toString() {
    return 'Population(id: $id, displayName: $displayName, description: $description, regionIds: $regionIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PopulationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._regionIds, _regionIds));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, displayName, description,
      const DeepCollectionEquality().hash(_regionIds));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PopulationImplCopyWith<_$PopulationImpl> get copyWith =>
      __$$PopulationImplCopyWithImpl<_$PopulationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PopulationImplToJson(
      this,
    );
  }
}

abstract class _Population implements Population {
  const factory _Population(
      {required final String id,
      required final String displayName,
      required final String description,
      final List<String> regionIds}) = _$PopulationImpl;

  factory _Population.fromJson(Map<String, dynamic> json) =
      _$PopulationImpl.fromJson;

  @override
  String get id;
  @override
  String get displayName;
  @override
  String get description;
  @override
  List<String> get regionIds;
  @override
  @JsonKey(ignore: true)
  _$$PopulationImplCopyWith<_$PopulationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RegionalPresenceCurve _$RegionalPresenceCurveFromJson(
    Map<String, dynamic> json) {
  return _RegionalPresenceCurve.fromJson(json);
}

/// @nodoc
mixin _$RegionalPresenceCurve {
  String get regionId => throw _privateConstructorUsedError;
  GeoPolygon get regionPolygon => throw _privateConstructorUsedError;
  List<double> get weeklyValues => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RegionalPresenceCurveCopyWith<RegionalPresenceCurve> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegionalPresenceCurveCopyWith<$Res> {
  factory $RegionalPresenceCurveCopyWith(RegionalPresenceCurve value,
          $Res Function(RegionalPresenceCurve) then) =
      _$RegionalPresenceCurveCopyWithImpl<$Res, RegionalPresenceCurve>;
  @useResult
  $Res call(
      {String regionId, GeoPolygon regionPolygon, List<double> weeklyValues});

  $GeoPolygonCopyWith<$Res> get regionPolygon;
}

/// @nodoc
class _$RegionalPresenceCurveCopyWithImpl<$Res,
        $Val extends RegionalPresenceCurve>
    implements $RegionalPresenceCurveCopyWith<$Res> {
  _$RegionalPresenceCurveCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? regionId = null,
    Object? regionPolygon = null,
    Object? weeklyValues = null,
  }) {
    return _then(_value.copyWith(
      regionId: null == regionId
          ? _value.regionId
          : regionId // ignore: cast_nullable_to_non_nullable
              as String,
      regionPolygon: null == regionPolygon
          ? _value.regionPolygon
          : regionPolygon // ignore: cast_nullable_to_non_nullable
              as GeoPolygon,
      weeklyValues: null == weeklyValues
          ? _value.weeklyValues
          : weeklyValues // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GeoPolygonCopyWith<$Res> get regionPolygon {
    return $GeoPolygonCopyWith<$Res>(_value.regionPolygon, (value) {
      return _then(_value.copyWith(regionPolygon: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RegionalPresenceCurveImplCopyWith<$Res>
    implements $RegionalPresenceCurveCopyWith<$Res> {
  factory _$$RegionalPresenceCurveImplCopyWith(
          _$RegionalPresenceCurveImpl value,
          $Res Function(_$RegionalPresenceCurveImpl) then) =
      __$$RegionalPresenceCurveImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String regionId, GeoPolygon regionPolygon, List<double> weeklyValues});

  @override
  $GeoPolygonCopyWith<$Res> get regionPolygon;
}

/// @nodoc
class __$$RegionalPresenceCurveImplCopyWithImpl<$Res>
    extends _$RegionalPresenceCurveCopyWithImpl<$Res,
        _$RegionalPresenceCurveImpl>
    implements _$$RegionalPresenceCurveImplCopyWith<$Res> {
  __$$RegionalPresenceCurveImplCopyWithImpl(_$RegionalPresenceCurveImpl _value,
      $Res Function(_$RegionalPresenceCurveImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? regionId = null,
    Object? regionPolygon = null,
    Object? weeklyValues = null,
  }) {
    return _then(_$RegionalPresenceCurveImpl(
      regionId: null == regionId
          ? _value.regionId
          : regionId // ignore: cast_nullable_to_non_nullable
              as String,
      regionPolygon: null == regionPolygon
          ? _value.regionPolygon
          : regionPolygon // ignore: cast_nullable_to_non_nullable
              as GeoPolygon,
      weeklyValues: null == weeklyValues
          ? _value._weeklyValues
          : weeklyValues // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RegionalPresenceCurveImpl extends _RegionalPresenceCurve {
  const _$RegionalPresenceCurveImpl(
      {required this.regionId,
      required this.regionPolygon,
      required final List<double> weeklyValues})
      : _weeklyValues = weeklyValues,
        super._();

  factory _$RegionalPresenceCurveImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegionalPresenceCurveImplFromJson(json);

  @override
  final String regionId;
  @override
  final GeoPolygon regionPolygon;
  final List<double> _weeklyValues;
  @override
  List<double> get weeklyValues {
    if (_weeklyValues is EqualUnmodifiableListView) return _weeklyValues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weeklyValues);
  }

  @override
  String toString() {
    return 'RegionalPresenceCurve(regionId: $regionId, regionPolygon: $regionPolygon, weeklyValues: $weeklyValues)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegionalPresenceCurveImpl &&
            (identical(other.regionId, regionId) ||
                other.regionId == regionId) &&
            (identical(other.regionPolygon, regionPolygon) ||
                other.regionPolygon == regionPolygon) &&
            const DeepCollectionEquality()
                .equals(other._weeklyValues, _weeklyValues));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, regionId, regionPolygon,
      const DeepCollectionEquality().hash(_weeklyValues));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RegionalPresenceCurveImplCopyWith<_$RegionalPresenceCurveImpl>
      get copyWith => __$$RegionalPresenceCurveImplCopyWithImpl<
          _$RegionalPresenceCurveImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegionalPresenceCurveImplToJson(
      this,
    );
  }
}

abstract class _RegionalPresenceCurve extends RegionalPresenceCurve {
  const factory _RegionalPresenceCurve(
      {required final String regionId,
      required final GeoPolygon regionPolygon,
      required final List<double> weeklyValues}) = _$RegionalPresenceCurveImpl;
  const _RegionalPresenceCurve._() : super._();

  factory _RegionalPresenceCurve.fromJson(Map<String, dynamic> json) =
      _$RegionalPresenceCurveImpl.fromJson;

  @override
  String get regionId;
  @override
  GeoPolygon get regionPolygon;
  @override
  List<double> get weeklyValues;
  @override
  @JsonKey(ignore: true)
  _$$RegionalPresenceCurveImplCopyWith<_$RegionalPresenceCurveImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MigrationCorridor _$MigrationCorridorFromJson(Map<String, dynamic> json) {
  return _MigrationCorridor.fromJson(json);
}

/// @nodoc
mixin _$MigrationCorridor {
  String get id => throw _privateConstructorUsedError;
  List<LatLng> get path => throw _privateConstructorUsedError;
  double get widthNm => throw _privateConstructorUsedError;
  int get activeWeekStart => throw _privateConstructorUsedError;
  int get activeWeekEnd => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MigrationCorridorCopyWith<MigrationCorridor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MigrationCorridorCopyWith<$Res> {
  factory $MigrationCorridorCopyWith(
          MigrationCorridor value, $Res Function(MigrationCorridor) then) =
      _$MigrationCorridorCopyWithImpl<$Res, MigrationCorridor>;
  @useResult
  $Res call(
      {String id,
      List<LatLng> path,
      double widthNm,
      int activeWeekStart,
      int activeWeekEnd});
}

/// @nodoc
class _$MigrationCorridorCopyWithImpl<$Res, $Val extends MigrationCorridor>
    implements $MigrationCorridorCopyWith<$Res> {
  _$MigrationCorridorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? path = null,
    Object? widthNm = null,
    Object? activeWeekStart = null,
    Object? activeWeekEnd = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as List<LatLng>,
      widthNm: null == widthNm
          ? _value.widthNm
          : widthNm // ignore: cast_nullable_to_non_nullable
              as double,
      activeWeekStart: null == activeWeekStart
          ? _value.activeWeekStart
          : activeWeekStart // ignore: cast_nullable_to_non_nullable
              as int,
      activeWeekEnd: null == activeWeekEnd
          ? _value.activeWeekEnd
          : activeWeekEnd // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MigrationCorridorImplCopyWith<$Res>
    implements $MigrationCorridorCopyWith<$Res> {
  factory _$$MigrationCorridorImplCopyWith(_$MigrationCorridorImpl value,
          $Res Function(_$MigrationCorridorImpl) then) =
      __$$MigrationCorridorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      List<LatLng> path,
      double widthNm,
      int activeWeekStart,
      int activeWeekEnd});
}

/// @nodoc
class __$$MigrationCorridorImplCopyWithImpl<$Res>
    extends _$MigrationCorridorCopyWithImpl<$Res, _$MigrationCorridorImpl>
    implements _$$MigrationCorridorImplCopyWith<$Res> {
  __$$MigrationCorridorImplCopyWithImpl(_$MigrationCorridorImpl _value,
      $Res Function(_$MigrationCorridorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? path = null,
    Object? widthNm = null,
    Object? activeWeekStart = null,
    Object? activeWeekEnd = null,
  }) {
    return _then(_$MigrationCorridorImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value._path
          : path // ignore: cast_nullable_to_non_nullable
              as List<LatLng>,
      widthNm: null == widthNm
          ? _value.widthNm
          : widthNm // ignore: cast_nullable_to_non_nullable
              as double,
      activeWeekStart: null == activeWeekStart
          ? _value.activeWeekStart
          : activeWeekStart // ignore: cast_nullable_to_non_nullable
              as int,
      activeWeekEnd: null == activeWeekEnd
          ? _value.activeWeekEnd
          : activeWeekEnd // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MigrationCorridorImpl implements _MigrationCorridor {
  const _$MigrationCorridorImpl(
      {required this.id,
      required final List<LatLng> path,
      required this.widthNm,
      required this.activeWeekStart,
      required this.activeWeekEnd})
      : _path = path;

  factory _$MigrationCorridorImpl.fromJson(Map<String, dynamic> json) =>
      _$$MigrationCorridorImplFromJson(json);

  @override
  final String id;
  final List<LatLng> _path;
  @override
  List<LatLng> get path {
    if (_path is EqualUnmodifiableListView) return _path;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_path);
  }

  @override
  final double widthNm;
  @override
  final int activeWeekStart;
  @override
  final int activeWeekEnd;

  @override
  String toString() {
    return 'MigrationCorridor(id: $id, path: $path, widthNm: $widthNm, activeWeekStart: $activeWeekStart, activeWeekEnd: $activeWeekEnd)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MigrationCorridorImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._path, _path) &&
            (identical(other.widthNm, widthNm) || other.widthNm == widthNm) &&
            (identical(other.activeWeekStart, activeWeekStart) ||
                other.activeWeekStart == activeWeekStart) &&
            (identical(other.activeWeekEnd, activeWeekEnd) ||
                other.activeWeekEnd == activeWeekEnd));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(_path),
      widthNm,
      activeWeekStart,
      activeWeekEnd);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MigrationCorridorImplCopyWith<_$MigrationCorridorImpl> get copyWith =>
      __$$MigrationCorridorImplCopyWithImpl<_$MigrationCorridorImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MigrationCorridorImplToJson(
      this,
    );
  }
}

abstract class _MigrationCorridor implements MigrationCorridor {
  const factory _MigrationCorridor(
      {required final String id,
      required final List<LatLng> path,
      required final double widthNm,
      required final int activeWeekStart,
      required final int activeWeekEnd}) = _$MigrationCorridorImpl;

  factory _MigrationCorridor.fromJson(Map<String, dynamic> json) =
      _$MigrationCorridorImpl.fromJson;

  @override
  String get id;
  @override
  List<LatLng> get path;
  @override
  double get widthNm;
  @override
  int get activeWeekStart;
  @override
  int get activeWeekEnd;
  @override
  @JsonKey(ignore: true)
  _$$MigrationCorridorImplCopyWith<_$MigrationCorridorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TriggerRule _$TriggerRuleFromJson(Map<String, dynamic> json) {
  return _TriggerRule.fromJson(json);
}

/// @nodoc
mixin _$TriggerRule {
  String get id => throw _privateConstructorUsedError;
  TriggerKind get kind => throw _privateConstructorUsedError;
  Map<String, dynamic> get parameters => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TriggerRuleCopyWith<TriggerRule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TriggerRuleCopyWith<$Res> {
  factory $TriggerRuleCopyWith(
          TriggerRule value, $Res Function(TriggerRule) then) =
      _$TriggerRuleCopyWithImpl<$Res, TriggerRule>;
  @useResult
  $Res call({String id, TriggerKind kind, Map<String, dynamic> parameters});
}

/// @nodoc
class _$TriggerRuleCopyWithImpl<$Res, $Val extends TriggerRule>
    implements $TriggerRuleCopyWith<$Res> {
  _$TriggerRuleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? kind = null,
    Object? parameters = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      kind: null == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as TriggerKind,
      parameters: null == parameters
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TriggerRuleImplCopyWith<$Res>
    implements $TriggerRuleCopyWith<$Res> {
  factory _$$TriggerRuleImplCopyWith(
          _$TriggerRuleImpl value, $Res Function(_$TriggerRuleImpl) then) =
      __$$TriggerRuleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, TriggerKind kind, Map<String, dynamic> parameters});
}

/// @nodoc
class __$$TriggerRuleImplCopyWithImpl<$Res>
    extends _$TriggerRuleCopyWithImpl<$Res, _$TriggerRuleImpl>
    implements _$$TriggerRuleImplCopyWith<$Res> {
  __$$TriggerRuleImplCopyWithImpl(
      _$TriggerRuleImpl _value, $Res Function(_$TriggerRuleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? kind = null,
    Object? parameters = null,
  }) {
    return _then(_$TriggerRuleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      kind: null == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as TriggerKind,
      parameters: null == parameters
          ? _value._parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TriggerRuleImpl implements _TriggerRule {
  const _$TriggerRuleImpl(
      {required this.id,
      required this.kind,
      final Map<String, dynamic> parameters = const <String, dynamic>{}})
      : _parameters = parameters;

  factory _$TriggerRuleImpl.fromJson(Map<String, dynamic> json) =>
      _$$TriggerRuleImplFromJson(json);

  @override
  final String id;
  @override
  final TriggerKind kind;
  final Map<String, dynamic> _parameters;
  @override
  @JsonKey()
  Map<String, dynamic> get parameters {
    if (_parameters is EqualUnmodifiableMapView) return _parameters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_parameters);
  }

  @override
  String toString() {
    return 'TriggerRule(id: $id, kind: $kind, parameters: $parameters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TriggerRuleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.kind, kind) || other.kind == kind) &&
            const DeepCollectionEquality()
                .equals(other._parameters, _parameters));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, kind, const DeepCollectionEquality().hash(_parameters));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TriggerRuleImplCopyWith<_$TriggerRuleImpl> get copyWith =>
      __$$TriggerRuleImplCopyWithImpl<_$TriggerRuleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TriggerRuleImplToJson(
      this,
    );
  }
}

abstract class _TriggerRule implements TriggerRule {
  const factory _TriggerRule(
      {required final String id,
      required final TriggerKind kind,
      final Map<String, dynamic> parameters}) = _$TriggerRuleImpl;

  factory _TriggerRule.fromJson(Map<String, dynamic> json) =
      _$TriggerRuleImpl.fromJson;

  @override
  String get id;
  @override
  TriggerKind get kind;
  @override
  Map<String, dynamic> get parameters;
  @override
  @JsonKey(ignore: true)
  _$$TriggerRuleImplCopyWith<_$TriggerRuleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
