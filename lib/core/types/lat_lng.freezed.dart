// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lat_lng.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LatLng _$LatLngFromJson(Map<String, dynamic> json) {
  return _LatLng.fromJson(json);
}

/// @nodoc
mixin _$LatLng {
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LatLngCopyWith<LatLng> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LatLngCopyWith<$Res> {
  factory $LatLngCopyWith(LatLng value, $Res Function(LatLng) then) =
      _$LatLngCopyWithImpl<$Res, LatLng>;
  @useResult
  $Res call({double latitude, double longitude});
}

/// @nodoc
class _$LatLngCopyWithImpl<$Res, $Val extends LatLng>
    implements $LatLngCopyWith<$Res> {
  _$LatLngCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_value.copyWith(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LatLngImplCopyWith<$Res> implements $LatLngCopyWith<$Res> {
  factory _$$LatLngImplCopyWith(
          _$LatLngImpl value, $Res Function(_$LatLngImpl) then) =
      __$$LatLngImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double latitude, double longitude});
}

/// @nodoc
class __$$LatLngImplCopyWithImpl<$Res>
    extends _$LatLngCopyWithImpl<$Res, _$LatLngImpl>
    implements _$$LatLngImplCopyWith<$Res> {
  __$$LatLngImplCopyWithImpl(
      _$LatLngImpl _value, $Res Function(_$LatLngImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_$LatLngImpl(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LatLngImpl extends _LatLng {
  const _$LatLngImpl({required this.latitude, required this.longitude})
      : super._();

  factory _$LatLngImpl.fromJson(Map<String, dynamic> json) =>
      _$$LatLngImplFromJson(json);

  @override
  final double latitude;
  @override
  final double longitude;

  @override
  String toString() {
    return 'LatLng(latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LatLngImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, latitude, longitude);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LatLngImplCopyWith<_$LatLngImpl> get copyWith =>
      __$$LatLngImplCopyWithImpl<_$LatLngImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LatLngImplToJson(
      this,
    );
  }
}

abstract class _LatLng extends LatLng {
  const factory _LatLng(
      {required final double latitude,
      required final double longitude}) = _$LatLngImpl;
  const _LatLng._() : super._();

  factory _LatLng.fromJson(Map<String, dynamic> json) = _$LatLngImpl.fromJson;

  @override
  double get latitude;
  @override
  double get longitude;
  @override
  @JsonKey(ignore: true)
  _$$LatLngImplCopyWith<_$LatLngImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LatLngBounds _$LatLngBoundsFromJson(Map<String, dynamic> json) {
  return _LatLngBounds.fromJson(json);
}

/// @nodoc
mixin _$LatLngBounds {
  LatLng get southwest => throw _privateConstructorUsedError;
  LatLng get northeast => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LatLngBoundsCopyWith<LatLngBounds> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LatLngBoundsCopyWith<$Res> {
  factory $LatLngBoundsCopyWith(
          LatLngBounds value, $Res Function(LatLngBounds) then) =
      _$LatLngBoundsCopyWithImpl<$Res, LatLngBounds>;
  @useResult
  $Res call({LatLng southwest, LatLng northeast});

  $LatLngCopyWith<$Res> get southwest;
  $LatLngCopyWith<$Res> get northeast;
}

/// @nodoc
class _$LatLngBoundsCopyWithImpl<$Res, $Val extends LatLngBounds>
    implements $LatLngBoundsCopyWith<$Res> {
  _$LatLngBoundsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? southwest = null,
    Object? northeast = null,
  }) {
    return _then(_value.copyWith(
      southwest: null == southwest
          ? _value.southwest
          : southwest // ignore: cast_nullable_to_non_nullable
              as LatLng,
      northeast: null == northeast
          ? _value.northeast
          : northeast // ignore: cast_nullable_to_non_nullable
              as LatLng,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LatLngCopyWith<$Res> get southwest {
    return $LatLngCopyWith<$Res>(_value.southwest, (value) {
      return _then(_value.copyWith(southwest: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $LatLngCopyWith<$Res> get northeast {
    return $LatLngCopyWith<$Res>(_value.northeast, (value) {
      return _then(_value.copyWith(northeast: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LatLngBoundsImplCopyWith<$Res>
    implements $LatLngBoundsCopyWith<$Res> {
  factory _$$LatLngBoundsImplCopyWith(
          _$LatLngBoundsImpl value, $Res Function(_$LatLngBoundsImpl) then) =
      __$$LatLngBoundsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({LatLng southwest, LatLng northeast});

  @override
  $LatLngCopyWith<$Res> get southwest;
  @override
  $LatLngCopyWith<$Res> get northeast;
}

/// @nodoc
class __$$LatLngBoundsImplCopyWithImpl<$Res>
    extends _$LatLngBoundsCopyWithImpl<$Res, _$LatLngBoundsImpl>
    implements _$$LatLngBoundsImplCopyWith<$Res> {
  __$$LatLngBoundsImplCopyWithImpl(
      _$LatLngBoundsImpl _value, $Res Function(_$LatLngBoundsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? southwest = null,
    Object? northeast = null,
  }) {
    return _then(_$LatLngBoundsImpl(
      southwest: null == southwest
          ? _value.southwest
          : southwest // ignore: cast_nullable_to_non_nullable
              as LatLng,
      northeast: null == northeast
          ? _value.northeast
          : northeast // ignore: cast_nullable_to_non_nullable
              as LatLng,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LatLngBoundsImpl extends _LatLngBounds {
  const _$LatLngBoundsImpl({required this.southwest, required this.northeast})
      : super._();

  factory _$LatLngBoundsImpl.fromJson(Map<String, dynamic> json) =>
      _$$LatLngBoundsImplFromJson(json);

  @override
  final LatLng southwest;
  @override
  final LatLng northeast;

  @override
  String toString() {
    return 'LatLngBounds(southwest: $southwest, northeast: $northeast)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LatLngBoundsImpl &&
            (identical(other.southwest, southwest) ||
                other.southwest == southwest) &&
            (identical(other.northeast, northeast) ||
                other.northeast == northeast));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, southwest, northeast);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LatLngBoundsImplCopyWith<_$LatLngBoundsImpl> get copyWith =>
      __$$LatLngBoundsImplCopyWithImpl<_$LatLngBoundsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LatLngBoundsImplToJson(
      this,
    );
  }
}

abstract class _LatLngBounds extends LatLngBounds {
  const factory _LatLngBounds(
      {required final LatLng southwest,
      required final LatLng northeast}) = _$LatLngBoundsImpl;
  const _LatLngBounds._() : super._();

  factory _LatLngBounds.fromJson(Map<String, dynamic> json) =
      _$LatLngBoundsImpl.fromJson;

  @override
  LatLng get southwest;
  @override
  LatLng get northeast;
  @override
  @JsonKey(ignore: true)
  _$$LatLngBoundsImplCopyWith<_$LatLngBoundsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GeoPolygon _$GeoPolygonFromJson(Map<String, dynamic> json) {
  return _GeoPolygon.fromJson(json);
}

/// @nodoc
mixin _$GeoPolygon {
  List<List<LatLng>> get rings => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GeoPolygonCopyWith<GeoPolygon> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeoPolygonCopyWith<$Res> {
  factory $GeoPolygonCopyWith(
          GeoPolygon value, $Res Function(GeoPolygon) then) =
      _$GeoPolygonCopyWithImpl<$Res, GeoPolygon>;
  @useResult
  $Res call({List<List<LatLng>> rings});
}

/// @nodoc
class _$GeoPolygonCopyWithImpl<$Res, $Val extends GeoPolygon>
    implements $GeoPolygonCopyWith<$Res> {
  _$GeoPolygonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rings = null,
  }) {
    return _then(_value.copyWith(
      rings: null == rings
          ? _value.rings
          : rings // ignore: cast_nullable_to_non_nullable
              as List<List<LatLng>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GeoPolygonImplCopyWith<$Res>
    implements $GeoPolygonCopyWith<$Res> {
  factory _$$GeoPolygonImplCopyWith(
          _$GeoPolygonImpl value, $Res Function(_$GeoPolygonImpl) then) =
      __$$GeoPolygonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<List<LatLng>> rings});
}

/// @nodoc
class __$$GeoPolygonImplCopyWithImpl<$Res>
    extends _$GeoPolygonCopyWithImpl<$Res, _$GeoPolygonImpl>
    implements _$$GeoPolygonImplCopyWith<$Res> {
  __$$GeoPolygonImplCopyWithImpl(
      _$GeoPolygonImpl _value, $Res Function(_$GeoPolygonImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rings = null,
  }) {
    return _then(_$GeoPolygonImpl(
      rings: null == rings
          ? _value._rings
          : rings // ignore: cast_nullable_to_non_nullable
              as List<List<LatLng>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GeoPolygonImpl extends _GeoPolygon {
  const _$GeoPolygonImpl({required final List<List<LatLng>> rings})
      : _rings = rings,
        super._();

  factory _$GeoPolygonImpl.fromJson(Map<String, dynamic> json) =>
      _$$GeoPolygonImplFromJson(json);

  final List<List<LatLng>> _rings;
  @override
  List<List<LatLng>> get rings {
    if (_rings is EqualUnmodifiableListView) return _rings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rings);
  }

  @override
  String toString() {
    return 'GeoPolygon(rings: $rings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeoPolygonImpl &&
            const DeepCollectionEquality().equals(other._rings, _rings));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_rings));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GeoPolygonImplCopyWith<_$GeoPolygonImpl> get copyWith =>
      __$$GeoPolygonImplCopyWithImpl<_$GeoPolygonImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GeoPolygonImplToJson(
      this,
    );
  }
}

abstract class _GeoPolygon extends GeoPolygon {
  const factory _GeoPolygon({required final List<List<LatLng>> rings}) =
      _$GeoPolygonImpl;
  const _GeoPolygon._() : super._();

  factory _GeoPolygon.fromJson(Map<String, dynamic> json) =
      _$GeoPolygonImpl.fromJson;

  @override
  List<List<LatLng>> get rings;
  @override
  @JsonKey(ignore: true)
  _$$GeoPolygonImplCopyWith<_$GeoPolygonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
