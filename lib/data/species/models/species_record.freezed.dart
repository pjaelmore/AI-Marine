// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'species_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SpeciesRecord _$SpeciesRecordFromJson(Map<String, dynamic> json) {
  return _SpeciesRecord.fromJson(json);
}

/// @nodoc
mixin _$SpeciesRecord {
  String get id => throw _privateConstructorUsedError;
  String get scientificName => throw _privateConstructorUsedError;
  List<String> get commonNames => throw _privateConstructorUsedError;
  String get schemaVersion => throw _privateConstructorUsedError;
  String get curationVersion => throw _privateConstructorUsedError;
  List<SizeClass> get sizeClasses => throw _privateConstructorUsedError;
  MigrationModel get migrationModel => throw _privateConstructorUsedError;
  ConditionProfile get conditionProfile => throw _privateConstructorUsedError;
  RegulatoryProfile get regulatoryProfile => throw _privateConstructorUsedError;
  ConfidenceLevel get confidence => throw _privateConstructorUsedError;

  /// Per-field provenance citations. Maps a calculator variable name
  /// (e.g. `optimalTemp`, `tidePreference`) to either a source URL
  /// or the literal string `unverified` when no authoritative source
  /// could be found. Captured per-species when authoring the JSON
  /// data file; surfaces in the recommendation card's "data quality"
  /// notes (Phase 6+) so users see which numbers are pinned vs
  /// best-guess.
  Map<String, String> get dataProvenance => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SpeciesRecordCopyWith<SpeciesRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpeciesRecordCopyWith<$Res> {
  factory $SpeciesRecordCopyWith(
          SpeciesRecord value, $Res Function(SpeciesRecord) then) =
      _$SpeciesRecordCopyWithImpl<$Res, SpeciesRecord>;
  @useResult
  $Res call(
      {String id,
      String scientificName,
      List<String> commonNames,
      String schemaVersion,
      String curationVersion,
      List<SizeClass> sizeClasses,
      MigrationModel migrationModel,
      ConditionProfile conditionProfile,
      RegulatoryProfile regulatoryProfile,
      ConfidenceLevel confidence,
      Map<String, String> dataProvenance});

  $MigrationModelCopyWith<$Res> get migrationModel;
  $ConditionProfileCopyWith<$Res> get conditionProfile;
  $RegulatoryProfileCopyWith<$Res> get regulatoryProfile;
}

/// @nodoc
class _$SpeciesRecordCopyWithImpl<$Res, $Val extends SpeciesRecord>
    implements $SpeciesRecordCopyWith<$Res> {
  _$SpeciesRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? scientificName = null,
    Object? commonNames = null,
    Object? schemaVersion = null,
    Object? curationVersion = null,
    Object? sizeClasses = null,
    Object? migrationModel = null,
    Object? conditionProfile = null,
    Object? regulatoryProfile = null,
    Object? confidence = null,
    Object? dataProvenance = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      scientificName: null == scientificName
          ? _value.scientificName
          : scientificName // ignore: cast_nullable_to_non_nullable
              as String,
      commonNames: null == commonNames
          ? _value.commonNames
          : commonNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      schemaVersion: null == schemaVersion
          ? _value.schemaVersion
          : schemaVersion // ignore: cast_nullable_to_non_nullable
              as String,
      curationVersion: null == curationVersion
          ? _value.curationVersion
          : curationVersion // ignore: cast_nullable_to_non_nullable
              as String,
      sizeClasses: null == sizeClasses
          ? _value.sizeClasses
          : sizeClasses // ignore: cast_nullable_to_non_nullable
              as List<SizeClass>,
      migrationModel: null == migrationModel
          ? _value.migrationModel
          : migrationModel // ignore: cast_nullable_to_non_nullable
              as MigrationModel,
      conditionProfile: null == conditionProfile
          ? _value.conditionProfile
          : conditionProfile // ignore: cast_nullable_to_non_nullable
              as ConditionProfile,
      regulatoryProfile: null == regulatoryProfile
          ? _value.regulatoryProfile
          : regulatoryProfile // ignore: cast_nullable_to_non_nullable
              as RegulatoryProfile,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as ConfidenceLevel,
      dataProvenance: null == dataProvenance
          ? _value.dataProvenance
          : dataProvenance // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MigrationModelCopyWith<$Res> get migrationModel {
    return $MigrationModelCopyWith<$Res>(_value.migrationModel, (value) {
      return _then(_value.copyWith(migrationModel: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ConditionProfileCopyWith<$Res> get conditionProfile {
    return $ConditionProfileCopyWith<$Res>(_value.conditionProfile, (value) {
      return _then(_value.copyWith(conditionProfile: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RegulatoryProfileCopyWith<$Res> get regulatoryProfile {
    return $RegulatoryProfileCopyWith<$Res>(_value.regulatoryProfile, (value) {
      return _then(_value.copyWith(regulatoryProfile: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SpeciesRecordImplCopyWith<$Res>
    implements $SpeciesRecordCopyWith<$Res> {
  factory _$$SpeciesRecordImplCopyWith(
          _$SpeciesRecordImpl value, $Res Function(_$SpeciesRecordImpl) then) =
      __$$SpeciesRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String scientificName,
      List<String> commonNames,
      String schemaVersion,
      String curationVersion,
      List<SizeClass> sizeClasses,
      MigrationModel migrationModel,
      ConditionProfile conditionProfile,
      RegulatoryProfile regulatoryProfile,
      ConfidenceLevel confidence,
      Map<String, String> dataProvenance});

  @override
  $MigrationModelCopyWith<$Res> get migrationModel;
  @override
  $ConditionProfileCopyWith<$Res> get conditionProfile;
  @override
  $RegulatoryProfileCopyWith<$Res> get regulatoryProfile;
}

/// @nodoc
class __$$SpeciesRecordImplCopyWithImpl<$Res>
    extends _$SpeciesRecordCopyWithImpl<$Res, _$SpeciesRecordImpl>
    implements _$$SpeciesRecordImplCopyWith<$Res> {
  __$$SpeciesRecordImplCopyWithImpl(
      _$SpeciesRecordImpl _value, $Res Function(_$SpeciesRecordImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? scientificName = null,
    Object? commonNames = null,
    Object? schemaVersion = null,
    Object? curationVersion = null,
    Object? sizeClasses = null,
    Object? migrationModel = null,
    Object? conditionProfile = null,
    Object? regulatoryProfile = null,
    Object? confidence = null,
    Object? dataProvenance = null,
  }) {
    return _then(_$SpeciesRecordImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      scientificName: null == scientificName
          ? _value.scientificName
          : scientificName // ignore: cast_nullable_to_non_nullable
              as String,
      commonNames: null == commonNames
          ? _value._commonNames
          : commonNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      schemaVersion: null == schemaVersion
          ? _value.schemaVersion
          : schemaVersion // ignore: cast_nullable_to_non_nullable
              as String,
      curationVersion: null == curationVersion
          ? _value.curationVersion
          : curationVersion // ignore: cast_nullable_to_non_nullable
              as String,
      sizeClasses: null == sizeClasses
          ? _value._sizeClasses
          : sizeClasses // ignore: cast_nullable_to_non_nullable
              as List<SizeClass>,
      migrationModel: null == migrationModel
          ? _value.migrationModel
          : migrationModel // ignore: cast_nullable_to_non_nullable
              as MigrationModel,
      conditionProfile: null == conditionProfile
          ? _value.conditionProfile
          : conditionProfile // ignore: cast_nullable_to_non_nullable
              as ConditionProfile,
      regulatoryProfile: null == regulatoryProfile
          ? _value.regulatoryProfile
          : regulatoryProfile // ignore: cast_nullable_to_non_nullable
              as RegulatoryProfile,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as ConfidenceLevel,
      dataProvenance: null == dataProvenance
          ? _value._dataProvenance
          : dataProvenance // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SpeciesRecordImpl implements _SpeciesRecord {
  const _$SpeciesRecordImpl(
      {required this.id,
      required this.scientificName,
      required final List<String> commonNames,
      required this.schemaVersion,
      required this.curationVersion,
      required final List<SizeClass> sizeClasses,
      required this.migrationModel,
      required this.conditionProfile,
      required this.regulatoryProfile,
      required this.confidence,
      final Map<String, String> dataProvenance = const <String, String>{}})
      : _commonNames = commonNames,
        _sizeClasses = sizeClasses,
        _dataProvenance = dataProvenance;

  factory _$SpeciesRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpeciesRecordImplFromJson(json);

  @override
  final String id;
  @override
  final String scientificName;
  final List<String> _commonNames;
  @override
  List<String> get commonNames {
    if (_commonNames is EqualUnmodifiableListView) return _commonNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_commonNames);
  }

  @override
  final String schemaVersion;
  @override
  final String curationVersion;
  final List<SizeClass> _sizeClasses;
  @override
  List<SizeClass> get sizeClasses {
    if (_sizeClasses is EqualUnmodifiableListView) return _sizeClasses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sizeClasses);
  }

  @override
  final MigrationModel migrationModel;
  @override
  final ConditionProfile conditionProfile;
  @override
  final RegulatoryProfile regulatoryProfile;
  @override
  final ConfidenceLevel confidence;

  /// Per-field provenance citations. Maps a calculator variable name
  /// (e.g. `optimalTemp`, `tidePreference`) to either a source URL
  /// or the literal string `unverified` when no authoritative source
  /// could be found. Captured per-species when authoring the JSON
  /// data file; surfaces in the recommendation card's "data quality"
  /// notes (Phase 6+) so users see which numbers are pinned vs
  /// best-guess.
  final Map<String, String> _dataProvenance;

  /// Per-field provenance citations. Maps a calculator variable name
  /// (e.g. `optimalTemp`, `tidePreference`) to either a source URL
  /// or the literal string `unverified` when no authoritative source
  /// could be found. Captured per-species when authoring the JSON
  /// data file; surfaces in the recommendation card's "data quality"
  /// notes (Phase 6+) so users see which numbers are pinned vs
  /// best-guess.
  @override
  @JsonKey()
  Map<String, String> get dataProvenance {
    if (_dataProvenance is EqualUnmodifiableMapView) return _dataProvenance;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_dataProvenance);
  }

  @override
  String toString() {
    return 'SpeciesRecord(id: $id, scientificName: $scientificName, commonNames: $commonNames, schemaVersion: $schemaVersion, curationVersion: $curationVersion, sizeClasses: $sizeClasses, migrationModel: $migrationModel, conditionProfile: $conditionProfile, regulatoryProfile: $regulatoryProfile, confidence: $confidence, dataProvenance: $dataProvenance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpeciesRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.scientificName, scientificName) ||
                other.scientificName == scientificName) &&
            const DeepCollectionEquality()
                .equals(other._commonNames, _commonNames) &&
            (identical(other.schemaVersion, schemaVersion) ||
                other.schemaVersion == schemaVersion) &&
            (identical(other.curationVersion, curationVersion) ||
                other.curationVersion == curationVersion) &&
            const DeepCollectionEquality()
                .equals(other._sizeClasses, _sizeClasses) &&
            (identical(other.migrationModel, migrationModel) ||
                other.migrationModel == migrationModel) &&
            (identical(other.conditionProfile, conditionProfile) ||
                other.conditionProfile == conditionProfile) &&
            (identical(other.regulatoryProfile, regulatoryProfile) ||
                other.regulatoryProfile == regulatoryProfile) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            const DeepCollectionEquality()
                .equals(other._dataProvenance, _dataProvenance));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      scientificName,
      const DeepCollectionEquality().hash(_commonNames),
      schemaVersion,
      curationVersion,
      const DeepCollectionEquality().hash(_sizeClasses),
      migrationModel,
      conditionProfile,
      regulatoryProfile,
      confidence,
      const DeepCollectionEquality().hash(_dataProvenance));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SpeciesRecordImplCopyWith<_$SpeciesRecordImpl> get copyWith =>
      __$$SpeciesRecordImplCopyWithImpl<_$SpeciesRecordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SpeciesRecordImplToJson(
      this,
    );
  }
}

abstract class _SpeciesRecord implements SpeciesRecord {
  const factory _SpeciesRecord(
      {required final String id,
      required final String scientificName,
      required final List<String> commonNames,
      required final String schemaVersion,
      required final String curationVersion,
      required final List<SizeClass> sizeClasses,
      required final MigrationModel migrationModel,
      required final ConditionProfile conditionProfile,
      required final RegulatoryProfile regulatoryProfile,
      required final ConfidenceLevel confidence,
      final Map<String, String> dataProvenance}) = _$SpeciesRecordImpl;

  factory _SpeciesRecord.fromJson(Map<String, dynamic> json) =
      _$SpeciesRecordImpl.fromJson;

  @override
  String get id;
  @override
  String get scientificName;
  @override
  List<String> get commonNames;
  @override
  String get schemaVersion;
  @override
  String get curationVersion;
  @override
  List<SizeClass> get sizeClasses;
  @override
  MigrationModel get migrationModel;
  @override
  ConditionProfile get conditionProfile;
  @override
  RegulatoryProfile get regulatoryProfile;
  @override
  ConfidenceLevel get confidence;
  @override

  /// Per-field provenance citations. Maps a calculator variable name
  /// (e.g. `optimalTemp`, `tidePreference`) to either a source URL
  /// or the literal string `unverified` when no authoritative source
  /// could be found. Captured per-species when authoring the JSON
  /// data file; surfaces in the recommendation card's "data quality"
  /// notes (Phase 6+) so users see which numbers are pinned vs
  /// best-guess.
  Map<String, String> get dataProvenance;
  @override
  @JsonKey(ignore: true)
  _$$SpeciesRecordImplCopyWith<_$SpeciesRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SizeClass _$SizeClassFromJson(Map<String, dynamic> json) {
  return _SizeClass.fromJson(json);
}

/// @nodoc
mixin _$SizeClass {
  String get id => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  double? get minLengthInches => throw _privateConstructorUsedError;
  double? get maxLengthInches => throw _privateConstructorUsedError;
  ConditionProfile? get overrideProfile => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SizeClassCopyWith<SizeClass> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SizeClassCopyWith<$Res> {
  factory $SizeClassCopyWith(SizeClass value, $Res Function(SizeClass) then) =
      _$SizeClassCopyWithImpl<$Res, SizeClass>;
  @useResult
  $Res call(
      {String id,
      String displayName,
      double? minLengthInches,
      double? maxLengthInches,
      ConditionProfile? overrideProfile});

  $ConditionProfileCopyWith<$Res>? get overrideProfile;
}

/// @nodoc
class _$SizeClassCopyWithImpl<$Res, $Val extends SizeClass>
    implements $SizeClassCopyWith<$Res> {
  _$SizeClassCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? minLengthInches = freezed,
    Object? maxLengthInches = freezed,
    Object? overrideProfile = freezed,
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
      minLengthInches: freezed == minLengthInches
          ? _value.minLengthInches
          : minLengthInches // ignore: cast_nullable_to_non_nullable
              as double?,
      maxLengthInches: freezed == maxLengthInches
          ? _value.maxLengthInches
          : maxLengthInches // ignore: cast_nullable_to_non_nullable
              as double?,
      overrideProfile: freezed == overrideProfile
          ? _value.overrideProfile
          : overrideProfile // ignore: cast_nullable_to_non_nullable
              as ConditionProfile?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ConditionProfileCopyWith<$Res>? get overrideProfile {
    if (_value.overrideProfile == null) {
      return null;
    }

    return $ConditionProfileCopyWith<$Res>(_value.overrideProfile!, (value) {
      return _then(_value.copyWith(overrideProfile: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SizeClassImplCopyWith<$Res>
    implements $SizeClassCopyWith<$Res> {
  factory _$$SizeClassImplCopyWith(
          _$SizeClassImpl value, $Res Function(_$SizeClassImpl) then) =
      __$$SizeClassImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String displayName,
      double? minLengthInches,
      double? maxLengthInches,
      ConditionProfile? overrideProfile});

  @override
  $ConditionProfileCopyWith<$Res>? get overrideProfile;
}

/// @nodoc
class __$$SizeClassImplCopyWithImpl<$Res>
    extends _$SizeClassCopyWithImpl<$Res, _$SizeClassImpl>
    implements _$$SizeClassImplCopyWith<$Res> {
  __$$SizeClassImplCopyWithImpl(
      _$SizeClassImpl _value, $Res Function(_$SizeClassImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? minLengthInches = freezed,
    Object? maxLengthInches = freezed,
    Object? overrideProfile = freezed,
  }) {
    return _then(_$SizeClassImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      minLengthInches: freezed == minLengthInches
          ? _value.minLengthInches
          : minLengthInches // ignore: cast_nullable_to_non_nullable
              as double?,
      maxLengthInches: freezed == maxLengthInches
          ? _value.maxLengthInches
          : maxLengthInches // ignore: cast_nullable_to_non_nullable
              as double?,
      overrideProfile: freezed == overrideProfile
          ? _value.overrideProfile
          : overrideProfile // ignore: cast_nullable_to_non_nullable
              as ConditionProfile?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SizeClassImpl implements _SizeClass {
  const _$SizeClassImpl(
      {required this.id,
      required this.displayName,
      this.minLengthInches,
      this.maxLengthInches,
      this.overrideProfile});

  factory _$SizeClassImpl.fromJson(Map<String, dynamic> json) =>
      _$$SizeClassImplFromJson(json);

  @override
  final String id;
  @override
  final String displayName;
  @override
  final double? minLengthInches;
  @override
  final double? maxLengthInches;
  @override
  final ConditionProfile? overrideProfile;

  @override
  String toString() {
    return 'SizeClass(id: $id, displayName: $displayName, minLengthInches: $minLengthInches, maxLengthInches: $maxLengthInches, overrideProfile: $overrideProfile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SizeClassImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.minLengthInches, minLengthInches) ||
                other.minLengthInches == minLengthInches) &&
            (identical(other.maxLengthInches, maxLengthInches) ||
                other.maxLengthInches == maxLengthInches) &&
            (identical(other.overrideProfile, overrideProfile) ||
                other.overrideProfile == overrideProfile));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, displayName, minLengthInches,
      maxLengthInches, overrideProfile);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SizeClassImplCopyWith<_$SizeClassImpl> get copyWith =>
      __$$SizeClassImplCopyWithImpl<_$SizeClassImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SizeClassImplToJson(
      this,
    );
  }
}

abstract class _SizeClass implements SizeClass {
  const factory _SizeClass(
      {required final String id,
      required final String displayName,
      final double? minLengthInches,
      final double? maxLengthInches,
      final ConditionProfile? overrideProfile}) = _$SizeClassImpl;

  factory _SizeClass.fromJson(Map<String, dynamic> json) =
      _$SizeClassImpl.fromJson;

  @override
  String get id;
  @override
  String get displayName;
  @override
  double? get minLengthInches;
  @override
  double? get maxLengthInches;
  @override
  ConditionProfile? get overrideProfile;
  @override
  @JsonKey(ignore: true)
  _$$SizeClassImplCopyWith<_$SizeClassImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
