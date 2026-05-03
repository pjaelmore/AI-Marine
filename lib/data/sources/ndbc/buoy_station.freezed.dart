// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'buoy_station.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BuoyStation _$BuoyStationFromJson(Map<String, dynamic> json) {
  return _BuoyStation.fromJson(json);
}

/// @nodoc
mixin _$BuoyStation {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  double get lon => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BuoyStationCopyWith<BuoyStation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BuoyStationCopyWith<$Res> {
  factory $BuoyStationCopyWith(
          BuoyStation value, $Res Function(BuoyStation) then) =
      _$BuoyStationCopyWithImpl<$Res, BuoyStation>;
  @useResult
  $Res call({String id, String name, double lat, double lon});
}

/// @nodoc
class _$BuoyStationCopyWithImpl<$Res, $Val extends BuoyStation>
    implements $BuoyStationCopyWith<$Res> {
  _$BuoyStationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? lat = null,
    Object? lon = null,
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
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lon: null == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BuoyStationImplCopyWith<$Res>
    implements $BuoyStationCopyWith<$Res> {
  factory _$$BuoyStationImplCopyWith(
          _$BuoyStationImpl value, $Res Function(_$BuoyStationImpl) then) =
      __$$BuoyStationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, double lat, double lon});
}

/// @nodoc
class __$$BuoyStationImplCopyWithImpl<$Res>
    extends _$BuoyStationCopyWithImpl<$Res, _$BuoyStationImpl>
    implements _$$BuoyStationImplCopyWith<$Res> {
  __$$BuoyStationImplCopyWithImpl(
      _$BuoyStationImpl _value, $Res Function(_$BuoyStationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? lat = null,
    Object? lon = null,
  }) {
    return _then(_$BuoyStationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lon: null == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BuoyStationImpl extends _BuoyStation {
  const _$BuoyStationImpl(
      {required this.id,
      required this.name,
      required this.lat,
      required this.lon})
      : super._();

  factory _$BuoyStationImpl.fromJson(Map<String, dynamic> json) =>
      _$$BuoyStationImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final double lat;
  @override
  final double lon;

  @override
  String toString() {
    return 'BuoyStation(id: $id, name: $name, lat: $lat, lon: $lon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BuoyStationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lon, lon) || other.lon == lon));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, lat, lon);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BuoyStationImplCopyWith<_$BuoyStationImpl> get copyWith =>
      __$$BuoyStationImplCopyWithImpl<_$BuoyStationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BuoyStationImplToJson(
      this,
    );
  }
}

abstract class _BuoyStation extends BuoyStation {
  const factory _BuoyStation(
      {required final String id,
      required final String name,
      required final double lat,
      required final double lon}) = _$BuoyStationImpl;
  const _BuoyStation._() : super._();

  factory _BuoyStation.fromJson(Map<String, dynamic> json) =
      _$BuoyStationImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  double get lat;
  @override
  double get lon;
  @override
  @JsonKey(ignore: true)
  _$$BuoyStationImplCopyWith<_$BuoyStationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
