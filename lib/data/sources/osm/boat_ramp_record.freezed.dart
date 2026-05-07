// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'boat_ramp_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BoatRampRecord _$BoatRampRecordFromJson(Map<String, dynamic> json) {
  return _BoatRampRecord.fromJson(json);
}

/// @nodoc
mixin _$BoatRampRecord {
  String get id => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  double get lon => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  /// OSM access tag — typically `yes`, `permissive`, `customers`,
  /// `permit`, or null when unset. Explicit `private` ramps are
  /// filtered out at refresh time (trip planning is public-launch).
  String? get access => throw _privateConstructorUsedError;

  /// `yes` / `no` / null. Whether the ramp charges a launch fee.
  String? get fee => throw _privateConstructorUsedError;

  /// `concrete`, `asphalt`, `gravel`, `grass`, etc. — null when
  /// unset upstream.
  String? get surface => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BoatRampRecordCopyWith<BoatRampRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BoatRampRecordCopyWith<$Res> {
  factory $BoatRampRecordCopyWith(
          BoatRampRecord value, $Res Function(BoatRampRecord) then) =
      _$BoatRampRecordCopyWithImpl<$Res, BoatRampRecord>;
  @useResult
  $Res call(
      {String id,
      double lat,
      double lon,
      String? name,
      String? access,
      String? fee,
      String? surface});
}

/// @nodoc
class _$BoatRampRecordCopyWithImpl<$Res, $Val extends BoatRampRecord>
    implements $BoatRampRecordCopyWith<$Res> {
  _$BoatRampRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? lat = null,
    Object? lon = null,
    Object? name = freezed,
    Object? access = freezed,
    Object? fee = freezed,
    Object? surface = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lon: null == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as double,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      access: freezed == access
          ? _value.access
          : access // ignore: cast_nullable_to_non_nullable
              as String?,
      fee: freezed == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as String?,
      surface: freezed == surface
          ? _value.surface
          : surface // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BoatRampRecordImplCopyWith<$Res>
    implements $BoatRampRecordCopyWith<$Res> {
  factory _$$BoatRampRecordImplCopyWith(_$BoatRampRecordImpl value,
          $Res Function(_$BoatRampRecordImpl) then) =
      __$$BoatRampRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      double lat,
      double lon,
      String? name,
      String? access,
      String? fee,
      String? surface});
}

/// @nodoc
class __$$BoatRampRecordImplCopyWithImpl<$Res>
    extends _$BoatRampRecordCopyWithImpl<$Res, _$BoatRampRecordImpl>
    implements _$$BoatRampRecordImplCopyWith<$Res> {
  __$$BoatRampRecordImplCopyWithImpl(
      _$BoatRampRecordImpl _value, $Res Function(_$BoatRampRecordImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? lat = null,
    Object? lon = null,
    Object? name = freezed,
    Object? access = freezed,
    Object? fee = freezed,
    Object? surface = freezed,
  }) {
    return _then(_$BoatRampRecordImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lon: null == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as double,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      access: freezed == access
          ? _value.access
          : access // ignore: cast_nullable_to_non_nullable
              as String?,
      fee: freezed == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as String?,
      surface: freezed == surface
          ? _value.surface
          : surface // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BoatRampRecordImpl extends _BoatRampRecord {
  const _$BoatRampRecordImpl(
      {required this.id,
      required this.lat,
      required this.lon,
      this.name,
      this.access,
      this.fee,
      this.surface})
      : super._();

  factory _$BoatRampRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$BoatRampRecordImplFromJson(json);

  @override
  final String id;
  @override
  final double lat;
  @override
  final double lon;
  @override
  final String? name;

  /// OSM access tag — typically `yes`, `permissive`, `customers`,
  /// `permit`, or null when unset. Explicit `private` ramps are
  /// filtered out at refresh time (trip planning is public-launch).
  @override
  final String? access;

  /// `yes` / `no` / null. Whether the ramp charges a launch fee.
  @override
  final String? fee;

  /// `concrete`, `asphalt`, `gravel`, `grass`, etc. — null when
  /// unset upstream.
  @override
  final String? surface;

  @override
  String toString() {
    return 'BoatRampRecord(id: $id, lat: $lat, lon: $lon, name: $name, access: $access, fee: $fee, surface: $surface)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BoatRampRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lon, lon) || other.lon == lon) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.access, access) || other.access == access) &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.surface, surface) || other.surface == surface));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, lat, lon, name, access, fee, surface);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BoatRampRecordImplCopyWith<_$BoatRampRecordImpl> get copyWith =>
      __$$BoatRampRecordImplCopyWithImpl<_$BoatRampRecordImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BoatRampRecordImplToJson(
      this,
    );
  }
}

abstract class _BoatRampRecord extends BoatRampRecord {
  const factory _BoatRampRecord(
      {required final String id,
      required final double lat,
      required final double lon,
      final String? name,
      final String? access,
      final String? fee,
      final String? surface}) = _$BoatRampRecordImpl;
  const _BoatRampRecord._() : super._();

  factory _BoatRampRecord.fromJson(Map<String, dynamic> json) =
      _$BoatRampRecordImpl.fromJson;

  @override
  String get id;
  @override
  double get lat;
  @override
  double get lon;
  @override
  String? get name;
  @override

  /// OSM access tag — typically `yes`, `permissive`, `customers`,
  /// `permit`, or null when unset. Explicit `private` ramps are
  /// filtered out at refresh time (trip planning is public-launch).
  String? get access;
  @override

  /// `yes` / `no` / null. Whether the ramp charges a launch fee.
  String? get fee;
  @override

  /// `concrete`, `asphalt`, `gravel`, `grass`, etc. — null when
  /// unset upstream.
  String? get surface;
  @override
  @JsonKey(ignore: true)
  _$$BoatRampRecordImplCopyWith<_$BoatRampRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
