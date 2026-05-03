// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tide_station.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TideStation _$TideStationFromJson(Map<String, dynamic> json) {
  return _TideStation.fromJson(json);
}

/// @nodoc
mixin _$TideStation {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  double get lon => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TideStationCopyWith<TideStation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TideStationCopyWith<$Res> {
  factory $TideStationCopyWith(
          TideStation value, $Res Function(TideStation) then) =
      _$TideStationCopyWithImpl<$Res, TideStation>;
  @useResult
  $Res call({String id, String name, double lat, double lon});
}

/// @nodoc
class _$TideStationCopyWithImpl<$Res, $Val extends TideStation>
    implements $TideStationCopyWith<$Res> {
  _$TideStationCopyWithImpl(this._value, this._then);

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
abstract class _$$TideStationImplCopyWith<$Res>
    implements $TideStationCopyWith<$Res> {
  factory _$$TideStationImplCopyWith(
          _$TideStationImpl value, $Res Function(_$TideStationImpl) then) =
      __$$TideStationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, double lat, double lon});
}

/// @nodoc
class __$$TideStationImplCopyWithImpl<$Res>
    extends _$TideStationCopyWithImpl<$Res, _$TideStationImpl>
    implements _$$TideStationImplCopyWith<$Res> {
  __$$TideStationImplCopyWithImpl(
      _$TideStationImpl _value, $Res Function(_$TideStationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? lat = null,
    Object? lon = null,
  }) {
    return _then(_$TideStationImpl(
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
class _$TideStationImpl extends _TideStation {
  const _$TideStationImpl(
      {required this.id,
      required this.name,
      required this.lat,
      required this.lon})
      : super._();

  factory _$TideStationImpl.fromJson(Map<String, dynamic> json) =>
      _$$TideStationImplFromJson(json);

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
    return 'TideStation(id: $id, name: $name, lat: $lat, lon: $lon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TideStationImpl &&
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
  _$$TideStationImplCopyWith<_$TideStationImpl> get copyWith =>
      __$$TideStationImplCopyWithImpl<_$TideStationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TideStationImplToJson(
      this,
    );
  }
}

abstract class _TideStation extends TideStation {
  const factory _TideStation(
      {required final String id,
      required final String name,
      required final double lat,
      required final double lon}) = _$TideStationImpl;
  const _TideStation._() : super._();

  factory _TideStation.fromJson(Map<String, dynamic> json) =
      _$TideStationImpl.fromJson;

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
  _$$TideStationImplCopyWith<_$TideStationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
