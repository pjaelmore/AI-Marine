// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'condition_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SourceDetails _$SourceDetailsFromJson(Map<String, dynamic> json) {
  return _SourceDetails.fromJson(json);
}

/// @nodoc
mixin _$SourceDetails {
  String? get stationId => throw _privateConstructorUsedError;
  String? get gatewayId => throw _privateConstructorUsedError;
  CacheLayer? get cacheHitLayer => throw _privateConstructorUsedError;
  String? get noaaZoneId => throw _privateConstructorUsedError;
  double? get interpolationDistanceNm => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SourceDetailsCopyWith<SourceDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SourceDetailsCopyWith<$Res> {
  factory $SourceDetailsCopyWith(
          SourceDetails value, $Res Function(SourceDetails) then) =
      _$SourceDetailsCopyWithImpl<$Res, SourceDetails>;
  @useResult
  $Res call(
      {String? stationId,
      String? gatewayId,
      CacheLayer? cacheHitLayer,
      String? noaaZoneId,
      double? interpolationDistanceNm});
}

/// @nodoc
class _$SourceDetailsCopyWithImpl<$Res, $Val extends SourceDetails>
    implements $SourceDetailsCopyWith<$Res> {
  _$SourceDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stationId = freezed,
    Object? gatewayId = freezed,
    Object? cacheHitLayer = freezed,
    Object? noaaZoneId = freezed,
    Object? interpolationDistanceNm = freezed,
  }) {
    return _then(_value.copyWith(
      stationId: freezed == stationId
          ? _value.stationId
          : stationId // ignore: cast_nullable_to_non_nullable
              as String?,
      gatewayId: freezed == gatewayId
          ? _value.gatewayId
          : gatewayId // ignore: cast_nullable_to_non_nullable
              as String?,
      cacheHitLayer: freezed == cacheHitLayer
          ? _value.cacheHitLayer
          : cacheHitLayer // ignore: cast_nullable_to_non_nullable
              as CacheLayer?,
      noaaZoneId: freezed == noaaZoneId
          ? _value.noaaZoneId
          : noaaZoneId // ignore: cast_nullable_to_non_nullable
              as String?,
      interpolationDistanceNm: freezed == interpolationDistanceNm
          ? _value.interpolationDistanceNm
          : interpolationDistanceNm // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SourceDetailsImplCopyWith<$Res>
    implements $SourceDetailsCopyWith<$Res> {
  factory _$$SourceDetailsImplCopyWith(
          _$SourceDetailsImpl value, $Res Function(_$SourceDetailsImpl) then) =
      __$$SourceDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? stationId,
      String? gatewayId,
      CacheLayer? cacheHitLayer,
      String? noaaZoneId,
      double? interpolationDistanceNm});
}

/// @nodoc
class __$$SourceDetailsImplCopyWithImpl<$Res>
    extends _$SourceDetailsCopyWithImpl<$Res, _$SourceDetailsImpl>
    implements _$$SourceDetailsImplCopyWith<$Res> {
  __$$SourceDetailsImplCopyWithImpl(
      _$SourceDetailsImpl _value, $Res Function(_$SourceDetailsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stationId = freezed,
    Object? gatewayId = freezed,
    Object? cacheHitLayer = freezed,
    Object? noaaZoneId = freezed,
    Object? interpolationDistanceNm = freezed,
  }) {
    return _then(_$SourceDetailsImpl(
      stationId: freezed == stationId
          ? _value.stationId
          : stationId // ignore: cast_nullable_to_non_nullable
              as String?,
      gatewayId: freezed == gatewayId
          ? _value.gatewayId
          : gatewayId // ignore: cast_nullable_to_non_nullable
              as String?,
      cacheHitLayer: freezed == cacheHitLayer
          ? _value.cacheHitLayer
          : cacheHitLayer // ignore: cast_nullable_to_non_nullable
              as CacheLayer?,
      noaaZoneId: freezed == noaaZoneId
          ? _value.noaaZoneId
          : noaaZoneId // ignore: cast_nullable_to_non_nullable
              as String?,
      interpolationDistanceNm: freezed == interpolationDistanceNm
          ? _value.interpolationDistanceNm
          : interpolationDistanceNm // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SourceDetailsImpl implements _SourceDetails {
  const _$SourceDetailsImpl(
      {this.stationId,
      this.gatewayId,
      this.cacheHitLayer,
      this.noaaZoneId,
      this.interpolationDistanceNm});

  factory _$SourceDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SourceDetailsImplFromJson(json);

  @override
  final String? stationId;
  @override
  final String? gatewayId;
  @override
  final CacheLayer? cacheHitLayer;
  @override
  final String? noaaZoneId;
  @override
  final double? interpolationDistanceNm;

  @override
  String toString() {
    return 'SourceDetails(stationId: $stationId, gatewayId: $gatewayId, cacheHitLayer: $cacheHitLayer, noaaZoneId: $noaaZoneId, interpolationDistanceNm: $interpolationDistanceNm)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SourceDetailsImpl &&
            (identical(other.stationId, stationId) ||
                other.stationId == stationId) &&
            (identical(other.gatewayId, gatewayId) ||
                other.gatewayId == gatewayId) &&
            (identical(other.cacheHitLayer, cacheHitLayer) ||
                other.cacheHitLayer == cacheHitLayer) &&
            (identical(other.noaaZoneId, noaaZoneId) ||
                other.noaaZoneId == noaaZoneId) &&
            (identical(
                    other.interpolationDistanceNm, interpolationDistanceNm) ||
                other.interpolationDistanceNm == interpolationDistanceNm));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, stationId, gatewayId,
      cacheHitLayer, noaaZoneId, interpolationDistanceNm);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SourceDetailsImplCopyWith<_$SourceDetailsImpl> get copyWith =>
      __$$SourceDetailsImplCopyWithImpl<_$SourceDetailsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SourceDetailsImplToJson(
      this,
    );
  }
}

abstract class _SourceDetails implements SourceDetails {
  const factory _SourceDetails(
      {final String? stationId,
      final String? gatewayId,
      final CacheLayer? cacheHitLayer,
      final String? noaaZoneId,
      final double? interpolationDistanceNm}) = _$SourceDetailsImpl;

  factory _SourceDetails.fromJson(Map<String, dynamic> json) =
      _$SourceDetailsImpl.fromJson;

  @override
  String? get stationId;
  @override
  String? get gatewayId;
  @override
  CacheLayer? get cacheHitLayer;
  @override
  String? get noaaZoneId;
  @override
  double? get interpolationDistanceNm;
  @override
  @JsonKey(ignore: true)
  _$$SourceDetailsImplCopyWith<_$SourceDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ConditionResult<T> {
  T get value => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  DataSource get source => throw _privateConstructorUsedError;
  SourceDetails get sourceDetails => throw _privateConstructorUsedError;
  DateTime get fetchedAt => throw _privateConstructorUsedError;
  DateTime get validUntil => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ConditionResultCopyWith<T, ConditionResult<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConditionResultCopyWith<T, $Res> {
  factory $ConditionResultCopyWith(
          ConditionResult<T> value, $Res Function(ConditionResult<T>) then) =
      _$ConditionResultCopyWithImpl<T, $Res, ConditionResult<T>>;
  @useResult
  $Res call(
      {T value,
      String unit,
      DataSource source,
      SourceDetails sourceDetails,
      DateTime fetchedAt,
      DateTime validUntil,
      double confidence});

  $SourceDetailsCopyWith<$Res> get sourceDetails;
}

/// @nodoc
class _$ConditionResultCopyWithImpl<T, $Res, $Val extends ConditionResult<T>>
    implements $ConditionResultCopyWith<T, $Res> {
  _$ConditionResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? unit = null,
    Object? source = null,
    Object? sourceDetails = null,
    Object? fetchedAt = null,
    Object? validUntil = null,
    Object? confidence = null,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as DataSource,
      sourceDetails: null == sourceDetails
          ? _value.sourceDetails
          : sourceDetails // ignore: cast_nullable_to_non_nullable
              as SourceDetails,
      fetchedAt: null == fetchedAt
          ? _value.fetchedAt
          : fetchedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      validUntil: null == validUntil
          ? _value.validUntil
          : validUntil // ignore: cast_nullable_to_non_nullable
              as DateTime,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SourceDetailsCopyWith<$Res> get sourceDetails {
    return $SourceDetailsCopyWith<$Res>(_value.sourceDetails, (value) {
      return _then(_value.copyWith(sourceDetails: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ConditionResultImplCopyWith<T, $Res>
    implements $ConditionResultCopyWith<T, $Res> {
  factory _$$ConditionResultImplCopyWith(_$ConditionResultImpl<T> value,
          $Res Function(_$ConditionResultImpl<T>) then) =
      __$$ConditionResultImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call(
      {T value,
      String unit,
      DataSource source,
      SourceDetails sourceDetails,
      DateTime fetchedAt,
      DateTime validUntil,
      double confidence});

  @override
  $SourceDetailsCopyWith<$Res> get sourceDetails;
}

/// @nodoc
class __$$ConditionResultImplCopyWithImpl<T, $Res>
    extends _$ConditionResultCopyWithImpl<T, $Res, _$ConditionResultImpl<T>>
    implements _$$ConditionResultImplCopyWith<T, $Res> {
  __$$ConditionResultImplCopyWithImpl(_$ConditionResultImpl<T> _value,
      $Res Function(_$ConditionResultImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? unit = null,
    Object? source = null,
    Object? sourceDetails = null,
    Object? fetchedAt = null,
    Object? validUntil = null,
    Object? confidence = null,
  }) {
    return _then(_$ConditionResultImpl<T>(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as DataSource,
      sourceDetails: null == sourceDetails
          ? _value.sourceDetails
          : sourceDetails // ignore: cast_nullable_to_non_nullable
              as SourceDetails,
      fetchedAt: null == fetchedAt
          ? _value.fetchedAt
          : fetchedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      validUntil: null == validUntil
          ? _value.validUntil
          : validUntil // ignore: cast_nullable_to_non_nullable
              as DateTime,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$ConditionResultImpl<T> implements _ConditionResult<T> {
  const _$ConditionResultImpl(
      {required this.value,
      required this.unit,
      required this.source,
      required this.sourceDetails,
      required this.fetchedAt,
      required this.validUntil,
      required this.confidence});

  @override
  final T value;
  @override
  final String unit;
  @override
  final DataSource source;
  @override
  final SourceDetails sourceDetails;
  @override
  final DateTime fetchedAt;
  @override
  final DateTime validUntil;
  @override
  final double confidence;

  @override
  String toString() {
    return 'ConditionResult<$T>(value: $value, unit: $unit, source: $source, sourceDetails: $sourceDetails, fetchedAt: $fetchedAt, validUntil: $validUntil, confidence: $confidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConditionResultImpl<T> &&
            const DeepCollectionEquality().equals(other.value, value) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.sourceDetails, sourceDetails) ||
                other.sourceDetails == sourceDetails) &&
            (identical(other.fetchedAt, fetchedAt) ||
                other.fetchedAt == fetchedAt) &&
            (identical(other.validUntil, validUntil) ||
                other.validUntil == validUntil) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(value),
      unit,
      source,
      sourceDetails,
      fetchedAt,
      validUntil,
      confidence);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConditionResultImplCopyWith<T, _$ConditionResultImpl<T>> get copyWith =>
      __$$ConditionResultImplCopyWithImpl<T, _$ConditionResultImpl<T>>(
          this, _$identity);
}

abstract class _ConditionResult<T> implements ConditionResult<T> {
  const factory _ConditionResult(
      {required final T value,
      required final String unit,
      required final DataSource source,
      required final SourceDetails sourceDetails,
      required final DateTime fetchedAt,
      required final DateTime validUntil,
      required final double confidence}) = _$ConditionResultImpl<T>;

  @override
  T get value;
  @override
  String get unit;
  @override
  DataSource get source;
  @override
  SourceDetails get sourceDetails;
  @override
  DateTime get fetchedAt;
  @override
  DateTime get validUntil;
  @override
  double get confidence;
  @override
  @JsonKey(ignore: true)
  _$$ConditionResultImplCopyWith<T, _$ConditionResultImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
