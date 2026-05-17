// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'score_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GateResult _$GateResultFromJson(Map<String, dynamic> json) {
  return _GateResult.fromJson(json);
}

/// @nodoc
mixin _$GateResult {
  String get name => throw _privateConstructorUsedError;
  bool get passed => throw _privateConstructorUsedError;
  String? get failureReason => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GateResultCopyWith<GateResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GateResultCopyWith<$Res> {
  factory $GateResultCopyWith(
          GateResult value, $Res Function(GateResult) then) =
      _$GateResultCopyWithImpl<$Res, GateResult>;
  @useResult
  $Res call({String name, bool passed, String? failureReason});
}

/// @nodoc
class _$GateResultCopyWithImpl<$Res, $Val extends GateResult>
    implements $GateResultCopyWith<$Res> {
  _$GateResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? passed = null,
    Object? failureReason = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      passed: null == passed
          ? _value.passed
          : passed // ignore: cast_nullable_to_non_nullable
              as bool,
      failureReason: freezed == failureReason
          ? _value.failureReason
          : failureReason // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GateResultImplCopyWith<$Res>
    implements $GateResultCopyWith<$Res> {
  factory _$$GateResultImplCopyWith(
          _$GateResultImpl value, $Res Function(_$GateResultImpl) then) =
      __$$GateResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, bool passed, String? failureReason});
}

/// @nodoc
class __$$GateResultImplCopyWithImpl<$Res>
    extends _$GateResultCopyWithImpl<$Res, _$GateResultImpl>
    implements _$$GateResultImplCopyWith<$Res> {
  __$$GateResultImplCopyWithImpl(
      _$GateResultImpl _value, $Res Function(_$GateResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? passed = null,
    Object? failureReason = freezed,
  }) {
    return _then(_$GateResultImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      passed: null == passed
          ? _value.passed
          : passed // ignore: cast_nullable_to_non_nullable
              as bool,
      failureReason: freezed == failureReason
          ? _value.failureReason
          : failureReason // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GateResultImpl implements _GateResult {
  const _$GateResultImpl(
      {required this.name, required this.passed, this.failureReason});

  factory _$GateResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$GateResultImplFromJson(json);

  @override
  final String name;
  @override
  final bool passed;
  @override
  final String? failureReason;

  @override
  String toString() {
    return 'GateResult(name: $name, passed: $passed, failureReason: $failureReason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GateResultImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.passed, passed) || other.passed == passed) &&
            (identical(other.failureReason, failureReason) ||
                other.failureReason == failureReason));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, passed, failureReason);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GateResultImplCopyWith<_$GateResultImpl> get copyWith =>
      __$$GateResultImplCopyWithImpl<_$GateResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GateResultImplToJson(
      this,
    );
  }
}

abstract class _GateResult implements GateResult {
  const factory _GateResult(
      {required final String name,
      required final bool passed,
      final String? failureReason}) = _$GateResultImpl;

  factory _GateResult.fromJson(Map<String, dynamic> json) =
      _$GateResultImpl.fromJson;

  @override
  String get name;
  @override
  bool get passed;
  @override
  String? get failureReason;
  @override
  @JsonKey(ignore: true)
  _$$GateResultImplCopyWith<_$GateResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ModifierApplication _$ModifierApplicationFromJson(Map<String, dynamic> json) {
  return _ModifierApplication.fromJson(json);
}

/// @nodoc
mixin _$ModifierApplication {
  String get name => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;
  double get rangeMin => throw _privateConstructorUsedError;
  double get rangeMax => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  bool get available => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ModifierApplicationCopyWith<ModifierApplication> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModifierApplicationCopyWith<$Res> {
  factory $ModifierApplicationCopyWith(
          ModifierApplication value, $Res Function(ModifierApplication) then) =
      _$ModifierApplicationCopyWithImpl<$Res, ModifierApplication>;
  @useResult
  $Res call(
      {String name,
      double value,
      double rangeMin,
      double rangeMax,
      String description,
      bool available});
}

/// @nodoc
class _$ModifierApplicationCopyWithImpl<$Res, $Val extends ModifierApplication>
    implements $ModifierApplicationCopyWith<$Res> {
  _$ModifierApplicationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? value = null,
    Object? rangeMin = null,
    Object? rangeMax = null,
    Object? description = null,
    Object? available = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      rangeMin: null == rangeMin
          ? _value.rangeMin
          : rangeMin // ignore: cast_nullable_to_non_nullable
              as double,
      rangeMax: null == rangeMax
          ? _value.rangeMax
          : rangeMax // ignore: cast_nullable_to_non_nullable
              as double,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      available: null == available
          ? _value.available
          : available // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ModifierApplicationImplCopyWith<$Res>
    implements $ModifierApplicationCopyWith<$Res> {
  factory _$$ModifierApplicationImplCopyWith(_$ModifierApplicationImpl value,
          $Res Function(_$ModifierApplicationImpl) then) =
      __$$ModifierApplicationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      double value,
      double rangeMin,
      double rangeMax,
      String description,
      bool available});
}

/// @nodoc
class __$$ModifierApplicationImplCopyWithImpl<$Res>
    extends _$ModifierApplicationCopyWithImpl<$Res, _$ModifierApplicationImpl>
    implements _$$ModifierApplicationImplCopyWith<$Res> {
  __$$ModifierApplicationImplCopyWithImpl(_$ModifierApplicationImpl _value,
      $Res Function(_$ModifierApplicationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? value = null,
    Object? rangeMin = null,
    Object? rangeMax = null,
    Object? description = null,
    Object? available = null,
  }) {
    return _then(_$ModifierApplicationImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      rangeMin: null == rangeMin
          ? _value.rangeMin
          : rangeMin // ignore: cast_nullable_to_non_nullable
              as double,
      rangeMax: null == rangeMax
          ? _value.rangeMax
          : rangeMax // ignore: cast_nullable_to_non_nullable
              as double,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      available: null == available
          ? _value.available
          : available // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ModifierApplicationImpl implements _ModifierApplication {
  const _$ModifierApplicationImpl(
      {required this.name,
      required this.value,
      required this.rangeMin,
      required this.rangeMax,
      required this.description,
      this.available = true});

  factory _$ModifierApplicationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ModifierApplicationImplFromJson(json);

  @override
  final String name;
  @override
  final double value;
  @override
  final double rangeMin;
  @override
  final double rangeMax;
  @override
  final String description;
  @override
  @JsonKey()
  final bool available;

  @override
  String toString() {
    return 'ModifierApplication(name: $name, value: $value, rangeMin: $rangeMin, rangeMax: $rangeMax, description: $description, available: $available)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModifierApplicationImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.rangeMin, rangeMin) ||
                other.rangeMin == rangeMin) &&
            (identical(other.rangeMax, rangeMax) ||
                other.rangeMax == rangeMax) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.available, available) ||
                other.available == available));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, value, rangeMin, rangeMax, description, available);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ModifierApplicationImplCopyWith<_$ModifierApplicationImpl> get copyWith =>
      __$$ModifierApplicationImplCopyWithImpl<_$ModifierApplicationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ModifierApplicationImplToJson(
      this,
    );
  }
}

abstract class _ModifierApplication implements ModifierApplication {
  const factory _ModifierApplication(
      {required final String name,
      required final double value,
      required final double rangeMin,
      required final double rangeMax,
      required final String description,
      final bool available}) = _$ModifierApplicationImpl;

  factory _ModifierApplication.fromJson(Map<String, dynamic> json) =
      _$ModifierApplicationImpl.fromJson;

  @override
  String get name;
  @override
  double get value;
  @override
  double get rangeMin;
  @override
  double get rangeMax;
  @override
  String get description;
  @override
  bool get available;
  @override
  @JsonKey(ignore: true)
  _$$ModifierApplicationImplCopyWith<_$ModifierApplicationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ContributorApplication _$ContributorApplicationFromJson(
    Map<String, dynamic> json) {
  return _ContributorApplication.fromJson(json);
}

/// @nodoc
mixin _$ContributorApplication {
  String get name => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;
  double get rangeMax => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ContributorApplicationCopyWith<ContributorApplication> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContributorApplicationCopyWith<$Res> {
  factory $ContributorApplicationCopyWith(ContributorApplication value,
          $Res Function(ContributorApplication) then) =
      _$ContributorApplicationCopyWithImpl<$Res, ContributorApplication>;
  @useResult
  $Res call({String name, double value, double rangeMax, String description});
}

/// @nodoc
class _$ContributorApplicationCopyWithImpl<$Res,
        $Val extends ContributorApplication>
    implements $ContributorApplicationCopyWith<$Res> {
  _$ContributorApplicationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? value = null,
    Object? rangeMax = null,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      rangeMax: null == rangeMax
          ? _value.rangeMax
          : rangeMax // ignore: cast_nullable_to_non_nullable
              as double,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContributorApplicationImplCopyWith<$Res>
    implements $ContributorApplicationCopyWith<$Res> {
  factory _$$ContributorApplicationImplCopyWith(
          _$ContributorApplicationImpl value,
          $Res Function(_$ContributorApplicationImpl) then) =
      __$$ContributorApplicationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, double value, double rangeMax, String description});
}

/// @nodoc
class __$$ContributorApplicationImplCopyWithImpl<$Res>
    extends _$ContributorApplicationCopyWithImpl<$Res,
        _$ContributorApplicationImpl>
    implements _$$ContributorApplicationImplCopyWith<$Res> {
  __$$ContributorApplicationImplCopyWithImpl(
      _$ContributorApplicationImpl _value,
      $Res Function(_$ContributorApplicationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? value = null,
    Object? rangeMax = null,
    Object? description = null,
  }) {
    return _then(_$ContributorApplicationImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      rangeMax: null == rangeMax
          ? _value.rangeMax
          : rangeMax // ignore: cast_nullable_to_non_nullable
              as double,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContributorApplicationImpl implements _ContributorApplication {
  const _$ContributorApplicationImpl(
      {required this.name,
      required this.value,
      required this.rangeMax,
      required this.description});

  factory _$ContributorApplicationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContributorApplicationImplFromJson(json);

  @override
  final String name;
  @override
  final double value;
  @override
  final double rangeMax;
  @override
  final String description;

  @override
  String toString() {
    return 'ContributorApplication(name: $name, value: $value, rangeMax: $rangeMax, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContributorApplicationImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.rangeMax, rangeMax) ||
                other.rangeMax == rangeMax) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, value, rangeMax, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContributorApplicationImplCopyWith<_$ContributorApplicationImpl>
      get copyWith => __$$ContributorApplicationImplCopyWithImpl<
          _$ContributorApplicationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContributorApplicationImplToJson(
      this,
    );
  }
}

abstract class _ContributorApplication implements ContributorApplication {
  const factory _ContributorApplication(
      {required final String name,
      required final double value,
      required final double rangeMax,
      required final String description}) = _$ContributorApplicationImpl;

  factory _ContributorApplication.fromJson(Map<String, dynamic> json) =
      _$ContributorApplicationImpl.fromJson;

  @override
  String get name;
  @override
  double get value;
  @override
  double get rangeMax;
  @override
  String get description;
  @override
  @JsonKey(ignore: true)
  _$$ContributorApplicationImplCopyWith<_$ContributorApplicationImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ReasoningBreakdown _$ReasoningBreakdownFromJson(Map<String, dynamic> json) {
  return _ReasoningBreakdown.fromJson(json);
}

/// @nodoc
mixin _$ReasoningBreakdown {
  double get baseProbability => throw _privateConstructorUsedError;
  List<GateResult> get gates => throw _privateConstructorUsedError;
  List<ModifierApplication> get modifiers => throw _privateConstructorUsedError;
  List<ContributorApplication> get contributors =>
      throw _privateConstructorUsedError;
  double get rawScoreBeforeContributors => throw _privateConstructorUsedError;
  double get additiveTotal => throw _privateConstructorUsedError;
  double get finalScore => throw _privateConstructorUsedError;
  String get migrationSummary => throw _privateConstructorUsedError;
  String get suggestedApproach => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReasoningBreakdownCopyWith<ReasoningBreakdown> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReasoningBreakdownCopyWith<$Res> {
  factory $ReasoningBreakdownCopyWith(
          ReasoningBreakdown value, $Res Function(ReasoningBreakdown) then) =
      _$ReasoningBreakdownCopyWithImpl<$Res, ReasoningBreakdown>;
  @useResult
  $Res call(
      {double baseProbability,
      List<GateResult> gates,
      List<ModifierApplication> modifiers,
      List<ContributorApplication> contributors,
      double rawScoreBeforeContributors,
      double additiveTotal,
      double finalScore,
      String migrationSummary,
      String suggestedApproach});
}

/// @nodoc
class _$ReasoningBreakdownCopyWithImpl<$Res, $Val extends ReasoningBreakdown>
    implements $ReasoningBreakdownCopyWith<$Res> {
  _$ReasoningBreakdownCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? baseProbability = null,
    Object? gates = null,
    Object? modifiers = null,
    Object? contributors = null,
    Object? rawScoreBeforeContributors = null,
    Object? additiveTotal = null,
    Object? finalScore = null,
    Object? migrationSummary = null,
    Object? suggestedApproach = null,
  }) {
    return _then(_value.copyWith(
      baseProbability: null == baseProbability
          ? _value.baseProbability
          : baseProbability // ignore: cast_nullable_to_non_nullable
              as double,
      gates: null == gates
          ? _value.gates
          : gates // ignore: cast_nullable_to_non_nullable
              as List<GateResult>,
      modifiers: null == modifiers
          ? _value.modifiers
          : modifiers // ignore: cast_nullable_to_non_nullable
              as List<ModifierApplication>,
      contributors: null == contributors
          ? _value.contributors
          : contributors // ignore: cast_nullable_to_non_nullable
              as List<ContributorApplication>,
      rawScoreBeforeContributors: null == rawScoreBeforeContributors
          ? _value.rawScoreBeforeContributors
          : rawScoreBeforeContributors // ignore: cast_nullable_to_non_nullable
              as double,
      additiveTotal: null == additiveTotal
          ? _value.additiveTotal
          : additiveTotal // ignore: cast_nullable_to_non_nullable
              as double,
      finalScore: null == finalScore
          ? _value.finalScore
          : finalScore // ignore: cast_nullable_to_non_nullable
              as double,
      migrationSummary: null == migrationSummary
          ? _value.migrationSummary
          : migrationSummary // ignore: cast_nullable_to_non_nullable
              as String,
      suggestedApproach: null == suggestedApproach
          ? _value.suggestedApproach
          : suggestedApproach // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReasoningBreakdownImplCopyWith<$Res>
    implements $ReasoningBreakdownCopyWith<$Res> {
  factory _$$ReasoningBreakdownImplCopyWith(_$ReasoningBreakdownImpl value,
          $Res Function(_$ReasoningBreakdownImpl) then) =
      __$$ReasoningBreakdownImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double baseProbability,
      List<GateResult> gates,
      List<ModifierApplication> modifiers,
      List<ContributorApplication> contributors,
      double rawScoreBeforeContributors,
      double additiveTotal,
      double finalScore,
      String migrationSummary,
      String suggestedApproach});
}

/// @nodoc
class __$$ReasoningBreakdownImplCopyWithImpl<$Res>
    extends _$ReasoningBreakdownCopyWithImpl<$Res, _$ReasoningBreakdownImpl>
    implements _$$ReasoningBreakdownImplCopyWith<$Res> {
  __$$ReasoningBreakdownImplCopyWithImpl(_$ReasoningBreakdownImpl _value,
      $Res Function(_$ReasoningBreakdownImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? baseProbability = null,
    Object? gates = null,
    Object? modifiers = null,
    Object? contributors = null,
    Object? rawScoreBeforeContributors = null,
    Object? additiveTotal = null,
    Object? finalScore = null,
    Object? migrationSummary = null,
    Object? suggestedApproach = null,
  }) {
    return _then(_$ReasoningBreakdownImpl(
      baseProbability: null == baseProbability
          ? _value.baseProbability
          : baseProbability // ignore: cast_nullable_to_non_nullable
              as double,
      gates: null == gates
          ? _value._gates
          : gates // ignore: cast_nullable_to_non_nullable
              as List<GateResult>,
      modifiers: null == modifiers
          ? _value._modifiers
          : modifiers // ignore: cast_nullable_to_non_nullable
              as List<ModifierApplication>,
      contributors: null == contributors
          ? _value._contributors
          : contributors // ignore: cast_nullable_to_non_nullable
              as List<ContributorApplication>,
      rawScoreBeforeContributors: null == rawScoreBeforeContributors
          ? _value.rawScoreBeforeContributors
          : rawScoreBeforeContributors // ignore: cast_nullable_to_non_nullable
              as double,
      additiveTotal: null == additiveTotal
          ? _value.additiveTotal
          : additiveTotal // ignore: cast_nullable_to_non_nullable
              as double,
      finalScore: null == finalScore
          ? _value.finalScore
          : finalScore // ignore: cast_nullable_to_non_nullable
              as double,
      migrationSummary: null == migrationSummary
          ? _value.migrationSummary
          : migrationSummary // ignore: cast_nullable_to_non_nullable
              as String,
      suggestedApproach: null == suggestedApproach
          ? _value.suggestedApproach
          : suggestedApproach // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReasoningBreakdownImpl implements _ReasoningBreakdown {
  const _$ReasoningBreakdownImpl(
      {required this.baseProbability,
      required final List<GateResult> gates,
      required final List<ModifierApplication> modifiers,
      required final List<ContributorApplication> contributors,
      required this.rawScoreBeforeContributors,
      required this.additiveTotal,
      required this.finalScore,
      required this.migrationSummary,
      required this.suggestedApproach})
      : _gates = gates,
        _modifiers = modifiers,
        _contributors = contributors;

  factory _$ReasoningBreakdownImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReasoningBreakdownImplFromJson(json);

  @override
  final double baseProbability;
  final List<GateResult> _gates;
  @override
  List<GateResult> get gates {
    if (_gates is EqualUnmodifiableListView) return _gates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_gates);
  }

  final List<ModifierApplication> _modifiers;
  @override
  List<ModifierApplication> get modifiers {
    if (_modifiers is EqualUnmodifiableListView) return _modifiers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_modifiers);
  }

  final List<ContributorApplication> _contributors;
  @override
  List<ContributorApplication> get contributors {
    if (_contributors is EqualUnmodifiableListView) return _contributors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contributors);
  }

  @override
  final double rawScoreBeforeContributors;
  @override
  final double additiveTotal;
  @override
  final double finalScore;
  @override
  final String migrationSummary;
  @override
  final String suggestedApproach;

  @override
  String toString() {
    return 'ReasoningBreakdown(baseProbability: $baseProbability, gates: $gates, modifiers: $modifiers, contributors: $contributors, rawScoreBeforeContributors: $rawScoreBeforeContributors, additiveTotal: $additiveTotal, finalScore: $finalScore, migrationSummary: $migrationSummary, suggestedApproach: $suggestedApproach)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReasoningBreakdownImpl &&
            (identical(other.baseProbability, baseProbability) ||
                other.baseProbability == baseProbability) &&
            const DeepCollectionEquality().equals(other._gates, _gates) &&
            const DeepCollectionEquality()
                .equals(other._modifiers, _modifiers) &&
            const DeepCollectionEquality()
                .equals(other._contributors, _contributors) &&
            (identical(other.rawScoreBeforeContributors,
                    rawScoreBeforeContributors) ||
                other.rawScoreBeforeContributors ==
                    rawScoreBeforeContributors) &&
            (identical(other.additiveTotal, additiveTotal) ||
                other.additiveTotal == additiveTotal) &&
            (identical(other.finalScore, finalScore) ||
                other.finalScore == finalScore) &&
            (identical(other.migrationSummary, migrationSummary) ||
                other.migrationSummary == migrationSummary) &&
            (identical(other.suggestedApproach, suggestedApproach) ||
                other.suggestedApproach == suggestedApproach));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      baseProbability,
      const DeepCollectionEquality().hash(_gates),
      const DeepCollectionEquality().hash(_modifiers),
      const DeepCollectionEquality().hash(_contributors),
      rawScoreBeforeContributors,
      additiveTotal,
      finalScore,
      migrationSummary,
      suggestedApproach);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReasoningBreakdownImplCopyWith<_$ReasoningBreakdownImpl> get copyWith =>
      __$$ReasoningBreakdownImplCopyWithImpl<_$ReasoningBreakdownImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReasoningBreakdownImplToJson(
      this,
    );
  }
}

abstract class _ReasoningBreakdown implements ReasoningBreakdown {
  const factory _ReasoningBreakdown(
      {required final double baseProbability,
      required final List<GateResult> gates,
      required final List<ModifierApplication> modifiers,
      required final List<ContributorApplication> contributors,
      required final double rawScoreBeforeContributors,
      required final double additiveTotal,
      required final double finalScore,
      required final String migrationSummary,
      required final String suggestedApproach}) = _$ReasoningBreakdownImpl;

  factory _ReasoningBreakdown.fromJson(Map<String, dynamic> json) =
      _$ReasoningBreakdownImpl.fromJson;

  @override
  double get baseProbability;
  @override
  List<GateResult> get gates;
  @override
  List<ModifierApplication> get modifiers;
  @override
  List<ContributorApplication> get contributors;
  @override
  double get rawScoreBeforeContributors;
  @override
  double get additiveTotal;
  @override
  double get finalScore;
  @override
  String get migrationSummary;
  @override
  String get suggestedApproach;
  @override
  @JsonKey(ignore: true)
  _$$ReasoningBreakdownImplCopyWith<_$ReasoningBreakdownImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ScoreResult _$ScoreResultFromJson(Map<String, dynamic> json) {
  return _ScoreResult.fromJson(json);
}

/// @nodoc
mixin _$ScoreResult {
  String get speciesId => throw _privateConstructorUsedError;
  LatLng get location => throw _privateConstructorUsedError;
  DateTime get time => throw _privateConstructorUsedError;
  double get finalScore => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  ReasoningBreakdown get reasoning => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScoreResultCopyWith<ScoreResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScoreResultCopyWith<$Res> {
  factory $ScoreResultCopyWith(
          ScoreResult value, $Res Function(ScoreResult) then) =
      _$ScoreResultCopyWithImpl<$Res, ScoreResult>;
  @useResult
  $Res call(
      {String speciesId,
      LatLng location,
      DateTime time,
      double finalScore,
      double confidence,
      ReasoningBreakdown reasoning});

  $LatLngCopyWith<$Res> get location;
  $ReasoningBreakdownCopyWith<$Res> get reasoning;
}

/// @nodoc
class _$ScoreResultCopyWithImpl<$Res, $Val extends ScoreResult>
    implements $ScoreResultCopyWith<$Res> {
  _$ScoreResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? speciesId = null,
    Object? location = null,
    Object? time = null,
    Object? finalScore = null,
    Object? confidence = null,
    Object? reasoning = null,
  }) {
    return _then(_value.copyWith(
      speciesId: null == speciesId
          ? _value.speciesId
          : speciesId // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LatLng,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      finalScore: null == finalScore
          ? _value.finalScore
          : finalScore // ignore: cast_nullable_to_non_nullable
              as double,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      reasoning: null == reasoning
          ? _value.reasoning
          : reasoning // ignore: cast_nullable_to_non_nullable
              as ReasoningBreakdown,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LatLngCopyWith<$Res> get location {
    return $LatLngCopyWith<$Res>(_value.location, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ReasoningBreakdownCopyWith<$Res> get reasoning {
    return $ReasoningBreakdownCopyWith<$Res>(_value.reasoning, (value) {
      return _then(_value.copyWith(reasoning: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ScoreResultImplCopyWith<$Res>
    implements $ScoreResultCopyWith<$Res> {
  factory _$$ScoreResultImplCopyWith(
          _$ScoreResultImpl value, $Res Function(_$ScoreResultImpl) then) =
      __$$ScoreResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String speciesId,
      LatLng location,
      DateTime time,
      double finalScore,
      double confidence,
      ReasoningBreakdown reasoning});

  @override
  $LatLngCopyWith<$Res> get location;
  @override
  $ReasoningBreakdownCopyWith<$Res> get reasoning;
}

/// @nodoc
class __$$ScoreResultImplCopyWithImpl<$Res>
    extends _$ScoreResultCopyWithImpl<$Res, _$ScoreResultImpl>
    implements _$$ScoreResultImplCopyWith<$Res> {
  __$$ScoreResultImplCopyWithImpl(
      _$ScoreResultImpl _value, $Res Function(_$ScoreResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? speciesId = null,
    Object? location = null,
    Object? time = null,
    Object? finalScore = null,
    Object? confidence = null,
    Object? reasoning = null,
  }) {
    return _then(_$ScoreResultImpl(
      speciesId: null == speciesId
          ? _value.speciesId
          : speciesId // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LatLng,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      finalScore: null == finalScore
          ? _value.finalScore
          : finalScore // ignore: cast_nullable_to_non_nullable
              as double,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      reasoning: null == reasoning
          ? _value.reasoning
          : reasoning // ignore: cast_nullable_to_non_nullable
              as ReasoningBreakdown,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScoreResultImpl implements _ScoreResult {
  const _$ScoreResultImpl(
      {required this.speciesId,
      required this.location,
      required this.time,
      required this.finalScore,
      required this.confidence,
      required this.reasoning});

  factory _$ScoreResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScoreResultImplFromJson(json);

  @override
  final String speciesId;
  @override
  final LatLng location;
  @override
  final DateTime time;
  @override
  final double finalScore;
  @override
  final double confidence;
  @override
  final ReasoningBreakdown reasoning;

  @override
  String toString() {
    return 'ScoreResult(speciesId: $speciesId, location: $location, time: $time, finalScore: $finalScore, confidence: $confidence, reasoning: $reasoning)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScoreResultImpl &&
            (identical(other.speciesId, speciesId) ||
                other.speciesId == speciesId) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.finalScore, finalScore) ||
                other.finalScore == finalScore) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.reasoning, reasoning) ||
                other.reasoning == reasoning));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, speciesId, location, time,
      finalScore, confidence, reasoning);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScoreResultImplCopyWith<_$ScoreResultImpl> get copyWith =>
      __$$ScoreResultImplCopyWithImpl<_$ScoreResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScoreResultImplToJson(
      this,
    );
  }
}

abstract class _ScoreResult implements ScoreResult {
  const factory _ScoreResult(
      {required final String speciesId,
      required final LatLng location,
      required final DateTime time,
      required final double finalScore,
      required final double confidence,
      required final ReasoningBreakdown reasoning}) = _$ScoreResultImpl;

  factory _ScoreResult.fromJson(Map<String, dynamic> json) =
      _$ScoreResultImpl.fromJson;

  @override
  String get speciesId;
  @override
  LatLng get location;
  @override
  DateTime get time;
  @override
  double get finalScore;
  @override
  double get confidence;
  @override
  ReasoningBreakdown get reasoning;
  @override
  @JsonKey(ignore: true)
  _$$ScoreResultImplCopyWith<_$ScoreResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
