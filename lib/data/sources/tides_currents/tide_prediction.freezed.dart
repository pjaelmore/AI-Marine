// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tide_prediction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TidePrediction _$TidePredictionFromJson(Map<String, dynamic> json) {
  return _TidePrediction.fromJson(json);
}

/// @nodoc
mixin _$TidePrediction {
  DateTime get time => throw _privateConstructorUsedError;
  double get heightFt => throw _privateConstructorUsedError;
  TideType get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TidePredictionCopyWith<TidePrediction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TidePredictionCopyWith<$Res> {
  factory $TidePredictionCopyWith(
          TidePrediction value, $Res Function(TidePrediction) then) =
      _$TidePredictionCopyWithImpl<$Res, TidePrediction>;
  @useResult
  $Res call({DateTime time, double heightFt, TideType type});
}

/// @nodoc
class _$TidePredictionCopyWithImpl<$Res, $Val extends TidePrediction>
    implements $TidePredictionCopyWith<$Res> {
  _$TidePredictionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? heightFt = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      heightFt: null == heightFt
          ? _value.heightFt
          : heightFt // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TideType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TidePredictionImplCopyWith<$Res>
    implements $TidePredictionCopyWith<$Res> {
  factory _$$TidePredictionImplCopyWith(_$TidePredictionImpl value,
          $Res Function(_$TidePredictionImpl) then) =
      __$$TidePredictionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime time, double heightFt, TideType type});
}

/// @nodoc
class __$$TidePredictionImplCopyWithImpl<$Res>
    extends _$TidePredictionCopyWithImpl<$Res, _$TidePredictionImpl>
    implements _$$TidePredictionImplCopyWith<$Res> {
  __$$TidePredictionImplCopyWithImpl(
      _$TidePredictionImpl _value, $Res Function(_$TidePredictionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? heightFt = null,
    Object? type = null,
  }) {
    return _then(_$TidePredictionImpl(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      heightFt: null == heightFt
          ? _value.heightFt
          : heightFt // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TideType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TidePredictionImpl implements _TidePrediction {
  const _$TidePredictionImpl(
      {required this.time, required this.heightFt, required this.type});

  factory _$TidePredictionImpl.fromJson(Map<String, dynamic> json) =>
      _$$TidePredictionImplFromJson(json);

  @override
  final DateTime time;
  @override
  final double heightFt;
  @override
  final TideType type;

  @override
  String toString() {
    return 'TidePrediction(time: $time, heightFt: $heightFt, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TidePredictionImpl &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.heightFt, heightFt) ||
                other.heightFt == heightFt) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, time, heightFt, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TidePredictionImplCopyWith<_$TidePredictionImpl> get copyWith =>
      __$$TidePredictionImplCopyWithImpl<_$TidePredictionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TidePredictionImplToJson(
      this,
    );
  }
}

abstract class _TidePrediction implements TidePrediction {
  const factory _TidePrediction(
      {required final DateTime time,
      required final double heightFt,
      required final TideType type}) = _$TidePredictionImpl;

  factory _TidePrediction.fromJson(Map<String, dynamic> json) =
      _$TidePredictionImpl.fromJson;

  @override
  DateTime get time;
  @override
  double get heightFt;
  @override
  TideType get type;
  @override
  @JsonKey(ignore: true)
  _$$TidePredictionImplCopyWith<_$TidePredictionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
