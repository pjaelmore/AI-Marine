// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wreck_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WreckRecord _$WreckRecordFromJson(Map<String, dynamic> json) {
  return _WreckRecord.fromJson(json);
}

/// @nodoc
mixin _$WreckRecord {
  String get id => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  double get lon => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  /// Seamark wreck category — typically `dangerous`, `non-dangerous`,
  /// `distributed_remains`, or null when unset upstream.
  String? get category => throw _privateConstructorUsedError;

  /// Charted wreck depth (top of wreck, in metres). Often null.
  double? get depthM => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WreckRecordCopyWith<WreckRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WreckRecordCopyWith<$Res> {
  factory $WreckRecordCopyWith(
          WreckRecord value, $Res Function(WreckRecord) then) =
      _$WreckRecordCopyWithImpl<$Res, WreckRecord>;
  @useResult
  $Res call(
      {String id,
      double lat,
      double lon,
      String? name,
      String? category,
      double? depthM});
}

/// @nodoc
class _$WreckRecordCopyWithImpl<$Res, $Val extends WreckRecord>
    implements $WreckRecordCopyWith<$Res> {
  _$WreckRecordCopyWithImpl(this._value, this._then);

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
    Object? category = freezed,
    Object? depthM = freezed,
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
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      depthM: freezed == depthM
          ? _value.depthM
          : depthM // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WreckRecordImplCopyWith<$Res>
    implements $WreckRecordCopyWith<$Res> {
  factory _$$WreckRecordImplCopyWith(
          _$WreckRecordImpl value, $Res Function(_$WreckRecordImpl) then) =
      __$$WreckRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      double lat,
      double lon,
      String? name,
      String? category,
      double? depthM});
}

/// @nodoc
class __$$WreckRecordImplCopyWithImpl<$Res>
    extends _$WreckRecordCopyWithImpl<$Res, _$WreckRecordImpl>
    implements _$$WreckRecordImplCopyWith<$Res> {
  __$$WreckRecordImplCopyWithImpl(
      _$WreckRecordImpl _value, $Res Function(_$WreckRecordImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? lat = null,
    Object? lon = null,
    Object? name = freezed,
    Object? category = freezed,
    Object? depthM = freezed,
  }) {
    return _then(_$WreckRecordImpl(
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
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      depthM: freezed == depthM
          ? _value.depthM
          : depthM // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WreckRecordImpl extends _WreckRecord {
  const _$WreckRecordImpl(
      {required this.id,
      required this.lat,
      required this.lon,
      this.name,
      this.category,
      this.depthM})
      : super._();

  factory _$WreckRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$WreckRecordImplFromJson(json);

  @override
  final String id;
  @override
  final double lat;
  @override
  final double lon;
  @override
  final String? name;

  /// Seamark wreck category — typically `dangerous`, `non-dangerous`,
  /// `distributed_remains`, or null when unset upstream.
  @override
  final String? category;

  /// Charted wreck depth (top of wreck, in metres). Often null.
  @override
  final double? depthM;

  @override
  String toString() {
    return 'WreckRecord(id: $id, lat: $lat, lon: $lon, name: $name, category: $category, depthM: $depthM)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WreckRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lon, lon) || other.lon == lon) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.depthM, depthM) || other.depthM == depthM));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, lat, lon, name, category, depthM);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WreckRecordImplCopyWith<_$WreckRecordImpl> get copyWith =>
      __$$WreckRecordImplCopyWithImpl<_$WreckRecordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WreckRecordImplToJson(
      this,
    );
  }
}

abstract class _WreckRecord extends WreckRecord {
  const factory _WreckRecord(
      {required final String id,
      required final double lat,
      required final double lon,
      final String? name,
      final String? category,
      final double? depthM}) = _$WreckRecordImpl;
  const _WreckRecord._() : super._();

  factory _WreckRecord.fromJson(Map<String, dynamic> json) =
      _$WreckRecordImpl.fromJson;

  @override
  String get id;
  @override
  double get lat;
  @override
  double get lon;
  @override
  String? get name;
  @override

  /// Seamark wreck category — typically `dangerous`, `non-dangerous`,
  /// `distributed_remains`, or null when unset upstream.
  String? get category;
  @override

  /// Charted wreck depth (top of wreck, in metres). Often null.
  double? get depthM;
  @override
  @JsonKey(ignore: true)
  _$$WreckRecordImplCopyWith<_$WreckRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
