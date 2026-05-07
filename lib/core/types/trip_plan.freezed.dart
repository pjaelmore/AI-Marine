// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TripPlan _$TripPlanFromJson(Map<String, dynamic> json) {
  return _TripPlan.fromJson(json);
}

/// @nodoc
mixin _$TripPlan {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  LatLngBounds get bounds => throw _privateConstructorUsedError;
  DateTime get plannedStart => throw _privateConstructorUsedError;
  DateTime get plannedEnd => throw _privateConstructorUsedError;
  String get targetSpeciesId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  TripCacheStatus get cacheStatus => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TripPlanCopyWith<TripPlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TripPlanCopyWith<$Res> {
  factory $TripPlanCopyWith(TripPlan value, $Res Function(TripPlan) then) =
      _$TripPlanCopyWithImpl<$Res, TripPlan>;
  @useResult
  $Res call(
      {String id,
      String name,
      LatLngBounds bounds,
      DateTime plannedStart,
      DateTime plannedEnd,
      String targetSpeciesId,
      DateTime createdAt,
      TripCacheStatus cacheStatus,
      String? userId});

  $LatLngBoundsCopyWith<$Res> get bounds;
  $TripCacheStatusCopyWith<$Res> get cacheStatus;
}

/// @nodoc
class _$TripPlanCopyWithImpl<$Res, $Val extends TripPlan>
    implements $TripPlanCopyWith<$Res> {
  _$TripPlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? bounds = null,
    Object? plannedStart = null,
    Object? plannedEnd = null,
    Object? targetSpeciesId = null,
    Object? createdAt = null,
    Object? cacheStatus = null,
    Object? userId = freezed,
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
      bounds: null == bounds
          ? _value.bounds
          : bounds // ignore: cast_nullable_to_non_nullable
              as LatLngBounds,
      plannedStart: null == plannedStart
          ? _value.plannedStart
          : plannedStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      plannedEnd: null == plannedEnd
          ? _value.plannedEnd
          : plannedEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
      targetSpeciesId: null == targetSpeciesId
          ? _value.targetSpeciesId
          : targetSpeciesId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cacheStatus: null == cacheStatus
          ? _value.cacheStatus
          : cacheStatus // ignore: cast_nullable_to_non_nullable
              as TripCacheStatus,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LatLngBoundsCopyWith<$Res> get bounds {
    return $LatLngBoundsCopyWith<$Res>(_value.bounds, (value) {
      return _then(_value.copyWith(bounds: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TripCacheStatusCopyWith<$Res> get cacheStatus {
    return $TripCacheStatusCopyWith<$Res>(_value.cacheStatus, (value) {
      return _then(_value.copyWith(cacheStatus: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TripPlanImplCopyWith<$Res>
    implements $TripPlanCopyWith<$Res> {
  factory _$$TripPlanImplCopyWith(
          _$TripPlanImpl value, $Res Function(_$TripPlanImpl) then) =
      __$$TripPlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      LatLngBounds bounds,
      DateTime plannedStart,
      DateTime plannedEnd,
      String targetSpeciesId,
      DateTime createdAt,
      TripCacheStatus cacheStatus,
      String? userId});

  @override
  $LatLngBoundsCopyWith<$Res> get bounds;
  @override
  $TripCacheStatusCopyWith<$Res> get cacheStatus;
}

/// @nodoc
class __$$TripPlanImplCopyWithImpl<$Res>
    extends _$TripPlanCopyWithImpl<$Res, _$TripPlanImpl>
    implements _$$TripPlanImplCopyWith<$Res> {
  __$$TripPlanImplCopyWithImpl(
      _$TripPlanImpl _value, $Res Function(_$TripPlanImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? bounds = null,
    Object? plannedStart = null,
    Object? plannedEnd = null,
    Object? targetSpeciesId = null,
    Object? createdAt = null,
    Object? cacheStatus = null,
    Object? userId = freezed,
  }) {
    return _then(_$TripPlanImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      bounds: null == bounds
          ? _value.bounds
          : bounds // ignore: cast_nullable_to_non_nullable
              as LatLngBounds,
      plannedStart: null == plannedStart
          ? _value.plannedStart
          : plannedStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      plannedEnd: null == plannedEnd
          ? _value.plannedEnd
          : plannedEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
      targetSpeciesId: null == targetSpeciesId
          ? _value.targetSpeciesId
          : targetSpeciesId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cacheStatus: null == cacheStatus
          ? _value.cacheStatus
          : cacheStatus // ignore: cast_nullable_to_non_nullable
              as TripCacheStatus,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TripPlanImpl extends _TripPlan {
  const _$TripPlanImpl(
      {required this.id,
      required this.name,
      required this.bounds,
      required this.plannedStart,
      required this.plannedEnd,
      required this.targetSpeciesId,
      required this.createdAt,
      this.cacheStatus = const TripCacheStatus(),
      this.userId})
      : super._();

  factory _$TripPlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$TripPlanImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final LatLngBounds bounds;
  @override
  final DateTime plannedStart;
  @override
  final DateTime plannedEnd;
  @override
  final String targetSpeciesId;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final TripCacheStatus cacheStatus;
  @override
  final String? userId;

  @override
  String toString() {
    return 'TripPlan(id: $id, name: $name, bounds: $bounds, plannedStart: $plannedStart, plannedEnd: $plannedEnd, targetSpeciesId: $targetSpeciesId, createdAt: $createdAt, cacheStatus: $cacheStatus, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TripPlanImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.bounds, bounds) || other.bounds == bounds) &&
            (identical(other.plannedStart, plannedStart) ||
                other.plannedStart == plannedStart) &&
            (identical(other.plannedEnd, plannedEnd) ||
                other.plannedEnd == plannedEnd) &&
            (identical(other.targetSpeciesId, targetSpeciesId) ||
                other.targetSpeciesId == targetSpeciesId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.cacheStatus, cacheStatus) ||
                other.cacheStatus == cacheStatus) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, bounds, plannedStart,
      plannedEnd, targetSpeciesId, createdAt, cacheStatus, userId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TripPlanImplCopyWith<_$TripPlanImpl> get copyWith =>
      __$$TripPlanImplCopyWithImpl<_$TripPlanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TripPlanImplToJson(
      this,
    );
  }
}

abstract class _TripPlan extends TripPlan {
  const factory _TripPlan(
      {required final String id,
      required final String name,
      required final LatLngBounds bounds,
      required final DateTime plannedStart,
      required final DateTime plannedEnd,
      required final String targetSpeciesId,
      required final DateTime createdAt,
      final TripCacheStatus cacheStatus,
      final String? userId}) = _$TripPlanImpl;
  const _TripPlan._() : super._();

  factory _TripPlan.fromJson(Map<String, dynamic> json) =
      _$TripPlanImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  LatLngBounds get bounds;
  @override
  DateTime get plannedStart;
  @override
  DateTime get plannedEnd;
  @override
  String get targetSpeciesId;
  @override
  DateTime get createdAt;
  @override
  TripCacheStatus get cacheStatus;
  @override
  String? get userId;
  @override
  @JsonKey(ignore: true)
  _$$TripPlanImplCopyWith<_$TripPlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TripCacheStatus _$TripCacheStatusFromJson(Map<String, dynamic> json) {
  return _TripCacheStatus.fromJson(json);
}

/// @nodoc
mixin _$TripCacheStatus {
  /// OSM boat-ramp id the user picked as the trip's launch anchor.
  /// Persisted here rather than as a first-class column so the
  /// `trip_plans` table stays generic until Phase 7 settles the
  /// pre-trip schema.
  String? get rampId => throw _privateConstructorUsedError;

  /// Whether tiles for `bounds` at the configured zoom range have
  /// been downloaded. Set true by the 13b tile downloader once a
  /// pass completes.
  bool get tilesDownloaded => throw _privateConstructorUsedError;

  /// Whether the score grid for `bounds` × `targetSpeciesId` ×
  /// `plannedStart` has been pre-computed. Set true by 13d.
  bool get scoreGridReady => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TripCacheStatusCopyWith<TripCacheStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TripCacheStatusCopyWith<$Res> {
  factory $TripCacheStatusCopyWith(
          TripCacheStatus value, $Res Function(TripCacheStatus) then) =
      _$TripCacheStatusCopyWithImpl<$Res, TripCacheStatus>;
  @useResult
  $Res call({String? rampId, bool tilesDownloaded, bool scoreGridReady});
}

/// @nodoc
class _$TripCacheStatusCopyWithImpl<$Res, $Val extends TripCacheStatus>
    implements $TripCacheStatusCopyWith<$Res> {
  _$TripCacheStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rampId = freezed,
    Object? tilesDownloaded = null,
    Object? scoreGridReady = null,
  }) {
    return _then(_value.copyWith(
      rampId: freezed == rampId
          ? _value.rampId
          : rampId // ignore: cast_nullable_to_non_nullable
              as String?,
      tilesDownloaded: null == tilesDownloaded
          ? _value.tilesDownloaded
          : tilesDownloaded // ignore: cast_nullable_to_non_nullable
              as bool,
      scoreGridReady: null == scoreGridReady
          ? _value.scoreGridReady
          : scoreGridReady // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TripCacheStatusImplCopyWith<$Res>
    implements $TripCacheStatusCopyWith<$Res> {
  factory _$$TripCacheStatusImplCopyWith(_$TripCacheStatusImpl value,
          $Res Function(_$TripCacheStatusImpl) then) =
      __$$TripCacheStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? rampId, bool tilesDownloaded, bool scoreGridReady});
}

/// @nodoc
class __$$TripCacheStatusImplCopyWithImpl<$Res>
    extends _$TripCacheStatusCopyWithImpl<$Res, _$TripCacheStatusImpl>
    implements _$$TripCacheStatusImplCopyWith<$Res> {
  __$$TripCacheStatusImplCopyWithImpl(
      _$TripCacheStatusImpl _value, $Res Function(_$TripCacheStatusImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rampId = freezed,
    Object? tilesDownloaded = null,
    Object? scoreGridReady = null,
  }) {
    return _then(_$TripCacheStatusImpl(
      rampId: freezed == rampId
          ? _value.rampId
          : rampId // ignore: cast_nullable_to_non_nullable
              as String?,
      tilesDownloaded: null == tilesDownloaded
          ? _value.tilesDownloaded
          : tilesDownloaded // ignore: cast_nullable_to_non_nullable
              as bool,
      scoreGridReady: null == scoreGridReady
          ? _value.scoreGridReady
          : scoreGridReady // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TripCacheStatusImpl implements _TripCacheStatus {
  const _$TripCacheStatusImpl(
      {this.rampId, this.tilesDownloaded = false, this.scoreGridReady = false});

  factory _$TripCacheStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$TripCacheStatusImplFromJson(json);

  /// OSM boat-ramp id the user picked as the trip's launch anchor.
  /// Persisted here rather than as a first-class column so the
  /// `trip_plans` table stays generic until Phase 7 settles the
  /// pre-trip schema.
  @override
  final String? rampId;

  /// Whether tiles for `bounds` at the configured zoom range have
  /// been downloaded. Set true by the 13b tile downloader once a
  /// pass completes.
  @override
  @JsonKey()
  final bool tilesDownloaded;

  /// Whether the score grid for `bounds` × `targetSpeciesId` ×
  /// `plannedStart` has been pre-computed. Set true by 13d.
  @override
  @JsonKey()
  final bool scoreGridReady;

  @override
  String toString() {
    return 'TripCacheStatus(rampId: $rampId, tilesDownloaded: $tilesDownloaded, scoreGridReady: $scoreGridReady)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TripCacheStatusImpl &&
            (identical(other.rampId, rampId) || other.rampId == rampId) &&
            (identical(other.tilesDownloaded, tilesDownloaded) ||
                other.tilesDownloaded == tilesDownloaded) &&
            (identical(other.scoreGridReady, scoreGridReady) ||
                other.scoreGridReady == scoreGridReady));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, rampId, tilesDownloaded, scoreGridReady);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TripCacheStatusImplCopyWith<_$TripCacheStatusImpl> get copyWith =>
      __$$TripCacheStatusImplCopyWithImpl<_$TripCacheStatusImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TripCacheStatusImplToJson(
      this,
    );
  }
}

abstract class _TripCacheStatus implements TripCacheStatus {
  const factory _TripCacheStatus(
      {final String? rampId,
      final bool tilesDownloaded,
      final bool scoreGridReady}) = _$TripCacheStatusImpl;

  factory _TripCacheStatus.fromJson(Map<String, dynamic> json) =
      _$TripCacheStatusImpl.fromJson;

  @override

  /// OSM boat-ramp id the user picked as the trip's launch anchor.
  /// Persisted here rather than as a first-class column so the
  /// `trip_plans` table stays generic until Phase 7 settles the
  /// pre-trip schema.
  String? get rampId;
  @override

  /// Whether tiles for `bounds` at the configured zoom range have
  /// been downloaded. Set true by the 13b tile downloader once a
  /// pass completes.
  bool get tilesDownloaded;
  @override

  /// Whether the score grid for `bounds` × `targetSpeciesId` ×
  /// `plannedStart` has been pre-computed. Set true by 13d.
  bool get scoreGridReady;
  @override
  @JsonKey(ignore: true)
  _$$TripCacheStatusImplCopyWith<_$TripCacheStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
