// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_preferences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserPreferences _$UserPreferencesFromJson(Map<String, dynamic> json) {
  return _UserPreferences.fromJson(json);
}

/// @nodoc
mixin _$UserPreferences {
  DateTime get updatedAt => throw _privateConstructorUsedError;
  String? get homeRegionId => throw _privateConstructorUsedError;
  String? get primarySpeciesId => throw _privateConstructorUsedError;
  UnitSystem get units => throw _privateConstructorUsedError;
  bool get privacyOptInAggregate => throw _privateConstructorUsedError;
  int get cacheBudgetMb => throw _privateConstructorUsedError;
  bool get useNmea2000WhenAvailable => throw _privateConstructorUsedError;
  String? get gatewayConfigJson => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserPreferencesCopyWith<UserPreferences> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserPreferencesCopyWith<$Res> {
  factory $UserPreferencesCopyWith(
          UserPreferences value, $Res Function(UserPreferences) then) =
      _$UserPreferencesCopyWithImpl<$Res, UserPreferences>;
  @useResult
  $Res call(
      {DateTime updatedAt,
      String? homeRegionId,
      String? primarySpeciesId,
      UnitSystem units,
      bool privacyOptInAggregate,
      int cacheBudgetMb,
      bool useNmea2000WhenAvailable,
      String? gatewayConfigJson});
}

/// @nodoc
class _$UserPreferencesCopyWithImpl<$Res, $Val extends UserPreferences>
    implements $UserPreferencesCopyWith<$Res> {
  _$UserPreferencesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? updatedAt = null,
    Object? homeRegionId = freezed,
    Object? primarySpeciesId = freezed,
    Object? units = null,
    Object? privacyOptInAggregate = null,
    Object? cacheBudgetMb = null,
    Object? useNmea2000WhenAvailable = null,
    Object? gatewayConfigJson = freezed,
  }) {
    return _then(_value.copyWith(
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      homeRegionId: freezed == homeRegionId
          ? _value.homeRegionId
          : homeRegionId // ignore: cast_nullable_to_non_nullable
              as String?,
      primarySpeciesId: freezed == primarySpeciesId
          ? _value.primarySpeciesId
          : primarySpeciesId // ignore: cast_nullable_to_non_nullable
              as String?,
      units: null == units
          ? _value.units
          : units // ignore: cast_nullable_to_non_nullable
              as UnitSystem,
      privacyOptInAggregate: null == privacyOptInAggregate
          ? _value.privacyOptInAggregate
          : privacyOptInAggregate // ignore: cast_nullable_to_non_nullable
              as bool,
      cacheBudgetMb: null == cacheBudgetMb
          ? _value.cacheBudgetMb
          : cacheBudgetMb // ignore: cast_nullable_to_non_nullable
              as int,
      useNmea2000WhenAvailable: null == useNmea2000WhenAvailable
          ? _value.useNmea2000WhenAvailable
          : useNmea2000WhenAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      gatewayConfigJson: freezed == gatewayConfigJson
          ? _value.gatewayConfigJson
          : gatewayConfigJson // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserPreferencesImplCopyWith<$Res>
    implements $UserPreferencesCopyWith<$Res> {
  factory _$$UserPreferencesImplCopyWith(_$UserPreferencesImpl value,
          $Res Function(_$UserPreferencesImpl) then) =
      __$$UserPreferencesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime updatedAt,
      String? homeRegionId,
      String? primarySpeciesId,
      UnitSystem units,
      bool privacyOptInAggregate,
      int cacheBudgetMb,
      bool useNmea2000WhenAvailable,
      String? gatewayConfigJson});
}

/// @nodoc
class __$$UserPreferencesImplCopyWithImpl<$Res>
    extends _$UserPreferencesCopyWithImpl<$Res, _$UserPreferencesImpl>
    implements _$$UserPreferencesImplCopyWith<$Res> {
  __$$UserPreferencesImplCopyWithImpl(
      _$UserPreferencesImpl _value, $Res Function(_$UserPreferencesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? updatedAt = null,
    Object? homeRegionId = freezed,
    Object? primarySpeciesId = freezed,
    Object? units = null,
    Object? privacyOptInAggregate = null,
    Object? cacheBudgetMb = null,
    Object? useNmea2000WhenAvailable = null,
    Object? gatewayConfigJson = freezed,
  }) {
    return _then(_$UserPreferencesImpl(
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      homeRegionId: freezed == homeRegionId
          ? _value.homeRegionId
          : homeRegionId // ignore: cast_nullable_to_non_nullable
              as String?,
      primarySpeciesId: freezed == primarySpeciesId
          ? _value.primarySpeciesId
          : primarySpeciesId // ignore: cast_nullable_to_non_nullable
              as String?,
      units: null == units
          ? _value.units
          : units // ignore: cast_nullable_to_non_nullable
              as UnitSystem,
      privacyOptInAggregate: null == privacyOptInAggregate
          ? _value.privacyOptInAggregate
          : privacyOptInAggregate // ignore: cast_nullable_to_non_nullable
              as bool,
      cacheBudgetMb: null == cacheBudgetMb
          ? _value.cacheBudgetMb
          : cacheBudgetMb // ignore: cast_nullable_to_non_nullable
              as int,
      useNmea2000WhenAvailable: null == useNmea2000WhenAvailable
          ? _value.useNmea2000WhenAvailable
          : useNmea2000WhenAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      gatewayConfigJson: freezed == gatewayConfigJson
          ? _value.gatewayConfigJson
          : gatewayConfigJson // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserPreferencesImpl implements _UserPreferences {
  const _$UserPreferencesImpl(
      {required this.updatedAt,
      this.homeRegionId,
      this.primarySpeciesId,
      this.units = UnitSystem.imperial,
      this.privacyOptInAggregate = false,
      this.cacheBudgetMb = 500,
      this.useNmea2000WhenAvailable = false,
      this.gatewayConfigJson});

  factory _$UserPreferencesImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserPreferencesImplFromJson(json);

  @override
  final DateTime updatedAt;
  @override
  final String? homeRegionId;
  @override
  final String? primarySpeciesId;
  @override
  @JsonKey()
  final UnitSystem units;
  @override
  @JsonKey()
  final bool privacyOptInAggregate;
  @override
  @JsonKey()
  final int cacheBudgetMb;
  @override
  @JsonKey()
  final bool useNmea2000WhenAvailable;
  @override
  final String? gatewayConfigJson;

  @override
  String toString() {
    return 'UserPreferences(updatedAt: $updatedAt, homeRegionId: $homeRegionId, primarySpeciesId: $primarySpeciesId, units: $units, privacyOptInAggregate: $privacyOptInAggregate, cacheBudgetMb: $cacheBudgetMb, useNmea2000WhenAvailable: $useNmea2000WhenAvailable, gatewayConfigJson: $gatewayConfigJson)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserPreferencesImpl &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.homeRegionId, homeRegionId) ||
                other.homeRegionId == homeRegionId) &&
            (identical(other.primarySpeciesId, primarySpeciesId) ||
                other.primarySpeciesId == primarySpeciesId) &&
            (identical(other.units, units) || other.units == units) &&
            (identical(other.privacyOptInAggregate, privacyOptInAggregate) ||
                other.privacyOptInAggregate == privacyOptInAggregate) &&
            (identical(other.cacheBudgetMb, cacheBudgetMb) ||
                other.cacheBudgetMb == cacheBudgetMb) &&
            (identical(
                    other.useNmea2000WhenAvailable, useNmea2000WhenAvailable) ||
                other.useNmea2000WhenAvailable == useNmea2000WhenAvailable) &&
            (identical(other.gatewayConfigJson, gatewayConfigJson) ||
                other.gatewayConfigJson == gatewayConfigJson));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      updatedAt,
      homeRegionId,
      primarySpeciesId,
      units,
      privacyOptInAggregate,
      cacheBudgetMb,
      useNmea2000WhenAvailable,
      gatewayConfigJson);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserPreferencesImplCopyWith<_$UserPreferencesImpl> get copyWith =>
      __$$UserPreferencesImplCopyWithImpl<_$UserPreferencesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserPreferencesImplToJson(
      this,
    );
  }
}

abstract class _UserPreferences implements UserPreferences {
  const factory _UserPreferences(
      {required final DateTime updatedAt,
      final String? homeRegionId,
      final String? primarySpeciesId,
      final UnitSystem units,
      final bool privacyOptInAggregate,
      final int cacheBudgetMb,
      final bool useNmea2000WhenAvailable,
      final String? gatewayConfigJson}) = _$UserPreferencesImpl;

  factory _UserPreferences.fromJson(Map<String, dynamic> json) =
      _$UserPreferencesImpl.fromJson;

  @override
  DateTime get updatedAt;
  @override
  String? get homeRegionId;
  @override
  String? get primarySpeciesId;
  @override
  UnitSystem get units;
  @override
  bool get privacyOptInAggregate;
  @override
  int get cacheBudgetMb;
  @override
  bool get useNmea2000WhenAvailable;
  @override
  String? get gatewayConfigJson;
  @override
  @JsonKey(ignore: true)
  _$$UserPreferencesImplCopyWith<_$UserPreferencesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
