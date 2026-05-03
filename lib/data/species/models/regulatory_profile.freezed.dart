// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'regulatory_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RegulatoryProfile _$RegulatoryProfileFromJson(Map<String, dynamic> json) {
  return _RegulatoryProfile.fromJson(json);
}

/// @nodoc
mixin _$RegulatoryProfile {
  List<RegulatoryRule> get rules => throw _privateConstructorUsedError;
  List<RestrictedZone> get restrictedZones =>
      throw _privateConstructorUsedError;
  List<PermitRequirement> get permitRequirements =>
      throw _privateConstructorUsedError;
  List<GearRestriction> get gearRestrictions =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RegulatoryProfileCopyWith<RegulatoryProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegulatoryProfileCopyWith<$Res> {
  factory $RegulatoryProfileCopyWith(
          RegulatoryProfile value, $Res Function(RegulatoryProfile) then) =
      _$RegulatoryProfileCopyWithImpl<$Res, RegulatoryProfile>;
  @useResult
  $Res call(
      {List<RegulatoryRule> rules,
      List<RestrictedZone> restrictedZones,
      List<PermitRequirement> permitRequirements,
      List<GearRestriction> gearRestrictions});
}

/// @nodoc
class _$RegulatoryProfileCopyWithImpl<$Res, $Val extends RegulatoryProfile>
    implements $RegulatoryProfileCopyWith<$Res> {
  _$RegulatoryProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rules = null,
    Object? restrictedZones = null,
    Object? permitRequirements = null,
    Object? gearRestrictions = null,
  }) {
    return _then(_value.copyWith(
      rules: null == rules
          ? _value.rules
          : rules // ignore: cast_nullable_to_non_nullable
              as List<RegulatoryRule>,
      restrictedZones: null == restrictedZones
          ? _value.restrictedZones
          : restrictedZones // ignore: cast_nullable_to_non_nullable
              as List<RestrictedZone>,
      permitRequirements: null == permitRequirements
          ? _value.permitRequirements
          : permitRequirements // ignore: cast_nullable_to_non_nullable
              as List<PermitRequirement>,
      gearRestrictions: null == gearRestrictions
          ? _value.gearRestrictions
          : gearRestrictions // ignore: cast_nullable_to_non_nullable
              as List<GearRestriction>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegulatoryProfileImplCopyWith<$Res>
    implements $RegulatoryProfileCopyWith<$Res> {
  factory _$$RegulatoryProfileImplCopyWith(_$RegulatoryProfileImpl value,
          $Res Function(_$RegulatoryProfileImpl) then) =
      __$$RegulatoryProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<RegulatoryRule> rules,
      List<RestrictedZone> restrictedZones,
      List<PermitRequirement> permitRequirements,
      List<GearRestriction> gearRestrictions});
}

/// @nodoc
class __$$RegulatoryProfileImplCopyWithImpl<$Res>
    extends _$RegulatoryProfileCopyWithImpl<$Res, _$RegulatoryProfileImpl>
    implements _$$RegulatoryProfileImplCopyWith<$Res> {
  __$$RegulatoryProfileImplCopyWithImpl(_$RegulatoryProfileImpl _value,
      $Res Function(_$RegulatoryProfileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rules = null,
    Object? restrictedZones = null,
    Object? permitRequirements = null,
    Object? gearRestrictions = null,
  }) {
    return _then(_$RegulatoryProfileImpl(
      rules: null == rules
          ? _value._rules
          : rules // ignore: cast_nullable_to_non_nullable
              as List<RegulatoryRule>,
      restrictedZones: null == restrictedZones
          ? _value._restrictedZones
          : restrictedZones // ignore: cast_nullable_to_non_nullable
              as List<RestrictedZone>,
      permitRequirements: null == permitRequirements
          ? _value._permitRequirements
          : permitRequirements // ignore: cast_nullable_to_non_nullable
              as List<PermitRequirement>,
      gearRestrictions: null == gearRestrictions
          ? _value._gearRestrictions
          : gearRestrictions // ignore: cast_nullable_to_non_nullable
              as List<GearRestriction>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RegulatoryProfileImpl implements _RegulatoryProfile {
  const _$RegulatoryProfileImpl(
      {final List<RegulatoryRule> rules = const <RegulatoryRule>[],
      final List<RestrictedZone> restrictedZones = const <RestrictedZone>[],
      final List<PermitRequirement> permitRequirements =
          const <PermitRequirement>[],
      final List<GearRestriction> gearRestrictions = const <GearRestriction>[]})
      : _rules = rules,
        _restrictedZones = restrictedZones,
        _permitRequirements = permitRequirements,
        _gearRestrictions = gearRestrictions;

  factory _$RegulatoryProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegulatoryProfileImplFromJson(json);

  final List<RegulatoryRule> _rules;
  @override
  @JsonKey()
  List<RegulatoryRule> get rules {
    if (_rules is EqualUnmodifiableListView) return _rules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rules);
  }

  final List<RestrictedZone> _restrictedZones;
  @override
  @JsonKey()
  List<RestrictedZone> get restrictedZones {
    if (_restrictedZones is EqualUnmodifiableListView) return _restrictedZones;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_restrictedZones);
  }

  final List<PermitRequirement> _permitRequirements;
  @override
  @JsonKey()
  List<PermitRequirement> get permitRequirements {
    if (_permitRequirements is EqualUnmodifiableListView)
      return _permitRequirements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_permitRequirements);
  }

  final List<GearRestriction> _gearRestrictions;
  @override
  @JsonKey()
  List<GearRestriction> get gearRestrictions {
    if (_gearRestrictions is EqualUnmodifiableListView)
      return _gearRestrictions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_gearRestrictions);
  }

  @override
  String toString() {
    return 'RegulatoryProfile(rules: $rules, restrictedZones: $restrictedZones, permitRequirements: $permitRequirements, gearRestrictions: $gearRestrictions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegulatoryProfileImpl &&
            const DeepCollectionEquality().equals(other._rules, _rules) &&
            const DeepCollectionEquality()
                .equals(other._restrictedZones, _restrictedZones) &&
            const DeepCollectionEquality()
                .equals(other._permitRequirements, _permitRequirements) &&
            const DeepCollectionEquality()
                .equals(other._gearRestrictions, _gearRestrictions));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_rules),
      const DeepCollectionEquality().hash(_restrictedZones),
      const DeepCollectionEquality().hash(_permitRequirements),
      const DeepCollectionEquality().hash(_gearRestrictions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RegulatoryProfileImplCopyWith<_$RegulatoryProfileImpl> get copyWith =>
      __$$RegulatoryProfileImplCopyWithImpl<_$RegulatoryProfileImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegulatoryProfileImplToJson(
      this,
    );
  }
}

abstract class _RegulatoryProfile implements RegulatoryProfile {
  const factory _RegulatoryProfile(
      {final List<RegulatoryRule> rules,
      final List<RestrictedZone> restrictedZones,
      final List<PermitRequirement> permitRequirements,
      final List<GearRestriction> gearRestrictions}) = _$RegulatoryProfileImpl;

  factory _RegulatoryProfile.fromJson(Map<String, dynamic> json) =
      _$RegulatoryProfileImpl.fromJson;

  @override
  List<RegulatoryRule> get rules;
  @override
  List<RestrictedZone> get restrictedZones;
  @override
  List<PermitRequirement> get permitRequirements;
  @override
  List<GearRestriction> get gearRestrictions;
  @override
  @JsonKey(ignore: true)
  _$$RegulatoryProfileImplCopyWith<_$RegulatoryProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RegulatoryRule _$RegulatoryRuleFromJson(Map<String, dynamic> json) {
  return _RegulatoryRule.fromJson(json);
}

/// @nodoc
mixin _$RegulatoryRule {
  String get id => throw _privateConstructorUsedError;
  String get jurisdictionId => throw _privateConstructorUsedError;
  RuleScope get scope => throw _privateConstructorUsedError;
  Map<String, dynamic> get parameters => throw _privateConstructorUsedError;
  DateTime get effectiveFrom => throw _privateConstructorUsedError;
  SourceReference get source => throw _privateConstructorUsedError;
  String? get subRegionId => throw _privateConstructorUsedError;
  DateTime? get effectiveTo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RegulatoryRuleCopyWith<RegulatoryRule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegulatoryRuleCopyWith<$Res> {
  factory $RegulatoryRuleCopyWith(
          RegulatoryRule value, $Res Function(RegulatoryRule) then) =
      _$RegulatoryRuleCopyWithImpl<$Res, RegulatoryRule>;
  @useResult
  $Res call(
      {String id,
      String jurisdictionId,
      RuleScope scope,
      Map<String, dynamic> parameters,
      DateTime effectiveFrom,
      SourceReference source,
      String? subRegionId,
      DateTime? effectiveTo});

  $SourceReferenceCopyWith<$Res> get source;
}

/// @nodoc
class _$RegulatoryRuleCopyWithImpl<$Res, $Val extends RegulatoryRule>
    implements $RegulatoryRuleCopyWith<$Res> {
  _$RegulatoryRuleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? jurisdictionId = null,
    Object? scope = null,
    Object? parameters = null,
    Object? effectiveFrom = null,
    Object? source = null,
    Object? subRegionId = freezed,
    Object? effectiveTo = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      jurisdictionId: null == jurisdictionId
          ? _value.jurisdictionId
          : jurisdictionId // ignore: cast_nullable_to_non_nullable
              as String,
      scope: null == scope
          ? _value.scope
          : scope // ignore: cast_nullable_to_non_nullable
              as RuleScope,
      parameters: null == parameters
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      effectiveFrom: null == effectiveFrom
          ? _value.effectiveFrom
          : effectiveFrom // ignore: cast_nullable_to_non_nullable
              as DateTime,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as SourceReference,
      subRegionId: freezed == subRegionId
          ? _value.subRegionId
          : subRegionId // ignore: cast_nullable_to_non_nullable
              as String?,
      effectiveTo: freezed == effectiveTo
          ? _value.effectiveTo
          : effectiveTo // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SourceReferenceCopyWith<$Res> get source {
    return $SourceReferenceCopyWith<$Res>(_value.source, (value) {
      return _then(_value.copyWith(source: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RegulatoryRuleImplCopyWith<$Res>
    implements $RegulatoryRuleCopyWith<$Res> {
  factory _$$RegulatoryRuleImplCopyWith(_$RegulatoryRuleImpl value,
          $Res Function(_$RegulatoryRuleImpl) then) =
      __$$RegulatoryRuleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String jurisdictionId,
      RuleScope scope,
      Map<String, dynamic> parameters,
      DateTime effectiveFrom,
      SourceReference source,
      String? subRegionId,
      DateTime? effectiveTo});

  @override
  $SourceReferenceCopyWith<$Res> get source;
}

/// @nodoc
class __$$RegulatoryRuleImplCopyWithImpl<$Res>
    extends _$RegulatoryRuleCopyWithImpl<$Res, _$RegulatoryRuleImpl>
    implements _$$RegulatoryRuleImplCopyWith<$Res> {
  __$$RegulatoryRuleImplCopyWithImpl(
      _$RegulatoryRuleImpl _value, $Res Function(_$RegulatoryRuleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? jurisdictionId = null,
    Object? scope = null,
    Object? parameters = null,
    Object? effectiveFrom = null,
    Object? source = null,
    Object? subRegionId = freezed,
    Object? effectiveTo = freezed,
  }) {
    return _then(_$RegulatoryRuleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      jurisdictionId: null == jurisdictionId
          ? _value.jurisdictionId
          : jurisdictionId // ignore: cast_nullable_to_non_nullable
              as String,
      scope: null == scope
          ? _value.scope
          : scope // ignore: cast_nullable_to_non_nullable
              as RuleScope,
      parameters: null == parameters
          ? _value._parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      effectiveFrom: null == effectiveFrom
          ? _value.effectiveFrom
          : effectiveFrom // ignore: cast_nullable_to_non_nullable
              as DateTime,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as SourceReference,
      subRegionId: freezed == subRegionId
          ? _value.subRegionId
          : subRegionId // ignore: cast_nullable_to_non_nullable
              as String?,
      effectiveTo: freezed == effectiveTo
          ? _value.effectiveTo
          : effectiveTo // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RegulatoryRuleImpl implements _RegulatoryRule {
  const _$RegulatoryRuleImpl(
      {required this.id,
      required this.jurisdictionId,
      required this.scope,
      required final Map<String, dynamic> parameters,
      required this.effectiveFrom,
      required this.source,
      this.subRegionId,
      this.effectiveTo})
      : _parameters = parameters;

  factory _$RegulatoryRuleImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegulatoryRuleImplFromJson(json);

  @override
  final String id;
  @override
  final String jurisdictionId;
  @override
  final RuleScope scope;
  final Map<String, dynamic> _parameters;
  @override
  Map<String, dynamic> get parameters {
    if (_parameters is EqualUnmodifiableMapView) return _parameters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_parameters);
  }

  @override
  final DateTime effectiveFrom;
  @override
  final SourceReference source;
  @override
  final String? subRegionId;
  @override
  final DateTime? effectiveTo;

  @override
  String toString() {
    return 'RegulatoryRule(id: $id, jurisdictionId: $jurisdictionId, scope: $scope, parameters: $parameters, effectiveFrom: $effectiveFrom, source: $source, subRegionId: $subRegionId, effectiveTo: $effectiveTo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegulatoryRuleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.jurisdictionId, jurisdictionId) ||
                other.jurisdictionId == jurisdictionId) &&
            (identical(other.scope, scope) || other.scope == scope) &&
            const DeepCollectionEquality()
                .equals(other._parameters, _parameters) &&
            (identical(other.effectiveFrom, effectiveFrom) ||
                other.effectiveFrom == effectiveFrom) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.subRegionId, subRegionId) ||
                other.subRegionId == subRegionId) &&
            (identical(other.effectiveTo, effectiveTo) ||
                other.effectiveTo == effectiveTo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      jurisdictionId,
      scope,
      const DeepCollectionEquality().hash(_parameters),
      effectiveFrom,
      source,
      subRegionId,
      effectiveTo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RegulatoryRuleImplCopyWith<_$RegulatoryRuleImpl> get copyWith =>
      __$$RegulatoryRuleImplCopyWithImpl<_$RegulatoryRuleImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegulatoryRuleImplToJson(
      this,
    );
  }
}

abstract class _RegulatoryRule implements RegulatoryRule {
  const factory _RegulatoryRule(
      {required final String id,
      required final String jurisdictionId,
      required final RuleScope scope,
      required final Map<String, dynamic> parameters,
      required final DateTime effectiveFrom,
      required final SourceReference source,
      final String? subRegionId,
      final DateTime? effectiveTo}) = _$RegulatoryRuleImpl;

  factory _RegulatoryRule.fromJson(Map<String, dynamic> json) =
      _$RegulatoryRuleImpl.fromJson;

  @override
  String get id;
  @override
  String get jurisdictionId;
  @override
  RuleScope get scope;
  @override
  Map<String, dynamic> get parameters;
  @override
  DateTime get effectiveFrom;
  @override
  SourceReference get source;
  @override
  String? get subRegionId;
  @override
  DateTime? get effectiveTo;
  @override
  @JsonKey(ignore: true)
  _$$RegulatoryRuleImplCopyWith<_$RegulatoryRuleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RestrictedZone _$RestrictedZoneFromJson(Map<String, dynamic> json) {
  return _RestrictedZone.fromJson(json);
}

/// @nodoc
mixin _$RestrictedZone {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  GeoPolygon get polygon => throw _privateConstructorUsedError;
  RestrictionKind get kind => throw _privateConstructorUsedError;
  SourceReference get source => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RestrictedZoneCopyWith<RestrictedZone> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestrictedZoneCopyWith<$Res> {
  factory $RestrictedZoneCopyWith(
          RestrictedZone value, $Res Function(RestrictedZone) then) =
      _$RestrictedZoneCopyWithImpl<$Res, RestrictedZone>;
  @useResult
  $Res call(
      {String id,
      String name,
      GeoPolygon polygon,
      RestrictionKind kind,
      SourceReference source});

  $GeoPolygonCopyWith<$Res> get polygon;
  $SourceReferenceCopyWith<$Res> get source;
}

/// @nodoc
class _$RestrictedZoneCopyWithImpl<$Res, $Val extends RestrictedZone>
    implements $RestrictedZoneCopyWith<$Res> {
  _$RestrictedZoneCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? polygon = null,
    Object? kind = null,
    Object? source = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      polygon: null == polygon
          ? _value.polygon
          : polygon // ignore: cast_nullable_to_non_nullable
              as GeoPolygon,
      kind: null == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as RestrictionKind,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as SourceReference,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GeoPolygonCopyWith<$Res> get polygon {
    return $GeoPolygonCopyWith<$Res>(_value.polygon, (value) {
      return _then(_value.copyWith(polygon: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SourceReferenceCopyWith<$Res> get source {
    return $SourceReferenceCopyWith<$Res>(_value.source, (value) {
      return _then(_value.copyWith(source: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RestrictedZoneImplCopyWith<$Res>
    implements $RestrictedZoneCopyWith<$Res> {
  factory _$$RestrictedZoneImplCopyWith(_$RestrictedZoneImpl value,
          $Res Function(_$RestrictedZoneImpl) then) =
      __$$RestrictedZoneImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      GeoPolygon polygon,
      RestrictionKind kind,
      SourceReference source});

  @override
  $GeoPolygonCopyWith<$Res> get polygon;
  @override
  $SourceReferenceCopyWith<$Res> get source;
}

/// @nodoc
class __$$RestrictedZoneImplCopyWithImpl<$Res>
    extends _$RestrictedZoneCopyWithImpl<$Res, _$RestrictedZoneImpl>
    implements _$$RestrictedZoneImplCopyWith<$Res> {
  __$$RestrictedZoneImplCopyWithImpl(
      _$RestrictedZoneImpl _value, $Res Function(_$RestrictedZoneImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? polygon = null,
    Object? kind = null,
    Object? source = null,
  }) {
    return _then(_$RestrictedZoneImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      polygon: null == polygon
          ? _value.polygon
          : polygon // ignore: cast_nullable_to_non_nullable
              as GeoPolygon,
      kind: null == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as RestrictionKind,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as SourceReference,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RestrictedZoneImpl implements _RestrictedZone {
  const _$RestrictedZoneImpl(
      {required this.id,
      required this.name,
      required this.polygon,
      required this.kind,
      required this.source});

  factory _$RestrictedZoneImpl.fromJson(Map<String, dynamic> json) =>
      _$$RestrictedZoneImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final GeoPolygon polygon;
  @override
  final RestrictionKind kind;
  @override
  final SourceReference source;

  @override
  String toString() {
    return 'RestrictedZone(id: $id, name: $name, polygon: $polygon, kind: $kind, source: $source)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestrictedZoneImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.polygon, polygon) || other.polygon == polygon) &&
            (identical(other.kind, kind) || other.kind == kind) &&
            (identical(other.source, source) || other.source == source));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, polygon, kind, source);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RestrictedZoneImplCopyWith<_$RestrictedZoneImpl> get copyWith =>
      __$$RestrictedZoneImplCopyWithImpl<_$RestrictedZoneImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RestrictedZoneImplToJson(
      this,
    );
  }
}

abstract class _RestrictedZone implements RestrictedZone {
  const factory _RestrictedZone(
      {required final String id,
      required final String name,
      required final GeoPolygon polygon,
      required final RestrictionKind kind,
      required final SourceReference source}) = _$RestrictedZoneImpl;

  factory _RestrictedZone.fromJson(Map<String, dynamic> json) =
      _$RestrictedZoneImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  GeoPolygon get polygon;
  @override
  RestrictionKind get kind;
  @override
  SourceReference get source;
  @override
  @JsonKey(ignore: true)
  _$$RestrictedZoneImplCopyWith<_$RestrictedZoneImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PermitRequirement _$PermitRequirementFromJson(Map<String, dynamic> json) {
  return _PermitRequirement.fromJson(json);
}

/// @nodoc
mixin _$PermitRequirement {
  String get id => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String get issuingAuthority => throw _privateConstructorUsedError;
  String? get infoUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PermitRequirementCopyWith<PermitRequirement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PermitRequirementCopyWith<$Res> {
  factory $PermitRequirementCopyWith(
          PermitRequirement value, $Res Function(PermitRequirement) then) =
      _$PermitRequirementCopyWithImpl<$Res, PermitRequirement>;
  @useResult
  $Res call(
      {String id,
      String displayName,
      String issuingAuthority,
      String? infoUrl});
}

/// @nodoc
class _$PermitRequirementCopyWithImpl<$Res, $Val extends PermitRequirement>
    implements $PermitRequirementCopyWith<$Res> {
  _$PermitRequirementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? issuingAuthority = null,
    Object? infoUrl = freezed,
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
      issuingAuthority: null == issuingAuthority
          ? _value.issuingAuthority
          : issuingAuthority // ignore: cast_nullable_to_non_nullable
              as String,
      infoUrl: freezed == infoUrl
          ? _value.infoUrl
          : infoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PermitRequirementImplCopyWith<$Res>
    implements $PermitRequirementCopyWith<$Res> {
  factory _$$PermitRequirementImplCopyWith(_$PermitRequirementImpl value,
          $Res Function(_$PermitRequirementImpl) then) =
      __$$PermitRequirementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String displayName,
      String issuingAuthority,
      String? infoUrl});
}

/// @nodoc
class __$$PermitRequirementImplCopyWithImpl<$Res>
    extends _$PermitRequirementCopyWithImpl<$Res, _$PermitRequirementImpl>
    implements _$$PermitRequirementImplCopyWith<$Res> {
  __$$PermitRequirementImplCopyWithImpl(_$PermitRequirementImpl _value,
      $Res Function(_$PermitRequirementImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? issuingAuthority = null,
    Object? infoUrl = freezed,
  }) {
    return _then(_$PermitRequirementImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      issuingAuthority: null == issuingAuthority
          ? _value.issuingAuthority
          : issuingAuthority // ignore: cast_nullable_to_non_nullable
              as String,
      infoUrl: freezed == infoUrl
          ? _value.infoUrl
          : infoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PermitRequirementImpl implements _PermitRequirement {
  const _$PermitRequirementImpl(
      {required this.id,
      required this.displayName,
      required this.issuingAuthority,
      this.infoUrl});

  factory _$PermitRequirementImpl.fromJson(Map<String, dynamic> json) =>
      _$$PermitRequirementImplFromJson(json);

  @override
  final String id;
  @override
  final String displayName;
  @override
  final String issuingAuthority;
  @override
  final String? infoUrl;

  @override
  String toString() {
    return 'PermitRequirement(id: $id, displayName: $displayName, issuingAuthority: $issuingAuthority, infoUrl: $infoUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PermitRequirementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.issuingAuthority, issuingAuthority) ||
                other.issuingAuthority == issuingAuthority) &&
            (identical(other.infoUrl, infoUrl) || other.infoUrl == infoUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, displayName, issuingAuthority, infoUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PermitRequirementImplCopyWith<_$PermitRequirementImpl> get copyWith =>
      __$$PermitRequirementImplCopyWithImpl<_$PermitRequirementImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PermitRequirementImplToJson(
      this,
    );
  }
}

abstract class _PermitRequirement implements PermitRequirement {
  const factory _PermitRequirement(
      {required final String id,
      required final String displayName,
      required final String issuingAuthority,
      final String? infoUrl}) = _$PermitRequirementImpl;

  factory _PermitRequirement.fromJson(Map<String, dynamic> json) =
      _$PermitRequirementImpl.fromJson;

  @override
  String get id;
  @override
  String get displayName;
  @override
  String get issuingAuthority;
  @override
  String? get infoUrl;
  @override
  @JsonKey(ignore: true)
  _$$PermitRequirementImplCopyWith<_$PermitRequirementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GearRestriction _$GearRestrictionFromJson(Map<String, dynamic> json) {
  return _GearRestriction.fromJson(json);
}

/// @nodoc
mixin _$GearRestriction {
  String get description => throw _privateConstructorUsedError;
  String? get jurisdictionId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GearRestrictionCopyWith<GearRestriction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GearRestrictionCopyWith<$Res> {
  factory $GearRestrictionCopyWith(
          GearRestriction value, $Res Function(GearRestriction) then) =
      _$GearRestrictionCopyWithImpl<$Res, GearRestriction>;
  @useResult
  $Res call({String description, String? jurisdictionId});
}

/// @nodoc
class _$GearRestrictionCopyWithImpl<$Res, $Val extends GearRestriction>
    implements $GearRestrictionCopyWith<$Res> {
  _$GearRestrictionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? jurisdictionId = freezed,
  }) {
    return _then(_value.copyWith(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      jurisdictionId: freezed == jurisdictionId
          ? _value.jurisdictionId
          : jurisdictionId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GearRestrictionImplCopyWith<$Res>
    implements $GearRestrictionCopyWith<$Res> {
  factory _$$GearRestrictionImplCopyWith(_$GearRestrictionImpl value,
          $Res Function(_$GearRestrictionImpl) then) =
      __$$GearRestrictionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String description, String? jurisdictionId});
}

/// @nodoc
class __$$GearRestrictionImplCopyWithImpl<$Res>
    extends _$GearRestrictionCopyWithImpl<$Res, _$GearRestrictionImpl>
    implements _$$GearRestrictionImplCopyWith<$Res> {
  __$$GearRestrictionImplCopyWithImpl(
      _$GearRestrictionImpl _value, $Res Function(_$GearRestrictionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? jurisdictionId = freezed,
  }) {
    return _then(_$GearRestrictionImpl(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      jurisdictionId: freezed == jurisdictionId
          ? _value.jurisdictionId
          : jurisdictionId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GearRestrictionImpl implements _GearRestriction {
  const _$GearRestrictionImpl({required this.description, this.jurisdictionId});

  factory _$GearRestrictionImpl.fromJson(Map<String, dynamic> json) =>
      _$$GearRestrictionImplFromJson(json);

  @override
  final String description;
  @override
  final String? jurisdictionId;

  @override
  String toString() {
    return 'GearRestriction(description: $description, jurisdictionId: $jurisdictionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GearRestrictionImpl &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.jurisdictionId, jurisdictionId) ||
                other.jurisdictionId == jurisdictionId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, description, jurisdictionId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GearRestrictionImplCopyWith<_$GearRestrictionImpl> get copyWith =>
      __$$GearRestrictionImplCopyWithImpl<_$GearRestrictionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GearRestrictionImplToJson(
      this,
    );
  }
}

abstract class _GearRestriction implements GearRestriction {
  const factory _GearRestriction(
      {required final String description,
      final String? jurisdictionId}) = _$GearRestrictionImpl;

  factory _GearRestriction.fromJson(Map<String, dynamic> json) =
      _$GearRestrictionImpl.fromJson;

  @override
  String get description;
  @override
  String? get jurisdictionId;
  @override
  @JsonKey(ignore: true)
  _$$GearRestrictionImplCopyWith<_$GearRestrictionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SourceReference _$SourceReferenceFromJson(Map<String, dynamic> json) {
  return _SourceReference.fromJson(json);
}

/// @nodoc
mixin _$SourceReference {
  String get authority => throw _privateConstructorUsedError;
  String get documentTitle => throw _privateConstructorUsedError;
  DateTime get lastVerifiedAt => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String? get documentVersion => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SourceReferenceCopyWith<SourceReference> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SourceReferenceCopyWith<$Res> {
  factory $SourceReferenceCopyWith(
          SourceReference value, $Res Function(SourceReference) then) =
      _$SourceReferenceCopyWithImpl<$Res, SourceReference>;
  @useResult
  $Res call(
      {String authority,
      String documentTitle,
      DateTime lastVerifiedAt,
      String? url,
      String? documentVersion});
}

/// @nodoc
class _$SourceReferenceCopyWithImpl<$Res, $Val extends SourceReference>
    implements $SourceReferenceCopyWith<$Res> {
  _$SourceReferenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authority = null,
    Object? documentTitle = null,
    Object? lastVerifiedAt = null,
    Object? url = freezed,
    Object? documentVersion = freezed,
  }) {
    return _then(_value.copyWith(
      authority: null == authority
          ? _value.authority
          : authority // ignore: cast_nullable_to_non_nullable
              as String,
      documentTitle: null == documentTitle
          ? _value.documentTitle
          : documentTitle // ignore: cast_nullable_to_non_nullable
              as String,
      lastVerifiedAt: null == lastVerifiedAt
          ? _value.lastVerifiedAt
          : lastVerifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      documentVersion: freezed == documentVersion
          ? _value.documentVersion
          : documentVersion // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SourceReferenceImplCopyWith<$Res>
    implements $SourceReferenceCopyWith<$Res> {
  factory _$$SourceReferenceImplCopyWith(_$SourceReferenceImpl value,
          $Res Function(_$SourceReferenceImpl) then) =
      __$$SourceReferenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String authority,
      String documentTitle,
      DateTime lastVerifiedAt,
      String? url,
      String? documentVersion});
}

/// @nodoc
class __$$SourceReferenceImplCopyWithImpl<$Res>
    extends _$SourceReferenceCopyWithImpl<$Res, _$SourceReferenceImpl>
    implements _$$SourceReferenceImplCopyWith<$Res> {
  __$$SourceReferenceImplCopyWithImpl(
      _$SourceReferenceImpl _value, $Res Function(_$SourceReferenceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authority = null,
    Object? documentTitle = null,
    Object? lastVerifiedAt = null,
    Object? url = freezed,
    Object? documentVersion = freezed,
  }) {
    return _then(_$SourceReferenceImpl(
      authority: null == authority
          ? _value.authority
          : authority // ignore: cast_nullable_to_non_nullable
              as String,
      documentTitle: null == documentTitle
          ? _value.documentTitle
          : documentTitle // ignore: cast_nullable_to_non_nullable
              as String,
      lastVerifiedAt: null == lastVerifiedAt
          ? _value.lastVerifiedAt
          : lastVerifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      documentVersion: freezed == documentVersion
          ? _value.documentVersion
          : documentVersion // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SourceReferenceImpl implements _SourceReference {
  const _$SourceReferenceImpl(
      {required this.authority,
      required this.documentTitle,
      required this.lastVerifiedAt,
      this.url,
      this.documentVersion});

  factory _$SourceReferenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$SourceReferenceImplFromJson(json);

  @override
  final String authority;
  @override
  final String documentTitle;
  @override
  final DateTime lastVerifiedAt;
  @override
  final String? url;
  @override
  final String? documentVersion;

  @override
  String toString() {
    return 'SourceReference(authority: $authority, documentTitle: $documentTitle, lastVerifiedAt: $lastVerifiedAt, url: $url, documentVersion: $documentVersion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SourceReferenceImpl &&
            (identical(other.authority, authority) ||
                other.authority == authority) &&
            (identical(other.documentTitle, documentTitle) ||
                other.documentTitle == documentTitle) &&
            (identical(other.lastVerifiedAt, lastVerifiedAt) ||
                other.lastVerifiedAt == lastVerifiedAt) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.documentVersion, documentVersion) ||
                other.documentVersion == documentVersion));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, authority, documentTitle,
      lastVerifiedAt, url, documentVersion);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SourceReferenceImplCopyWith<_$SourceReferenceImpl> get copyWith =>
      __$$SourceReferenceImplCopyWithImpl<_$SourceReferenceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SourceReferenceImplToJson(
      this,
    );
  }
}

abstract class _SourceReference implements SourceReference {
  const factory _SourceReference(
      {required final String authority,
      required final String documentTitle,
      required final DateTime lastVerifiedAt,
      final String? url,
      final String? documentVersion}) = _$SourceReferenceImpl;

  factory _SourceReference.fromJson(Map<String, dynamic> json) =
      _$SourceReferenceImpl.fromJson;

  @override
  String get authority;
  @override
  String get documentTitle;
  @override
  DateTime get lastVerifiedAt;
  @override
  String? get url;
  @override
  String? get documentVersion;
  @override
  @JsonKey(ignore: true)
  _$$SourceReferenceImplCopyWith<_$SourceReferenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
