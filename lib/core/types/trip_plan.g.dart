// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TripPlanImpl _$$TripPlanImplFromJson(Map<String, dynamic> json) =>
    _$TripPlanImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      bounds: LatLngBounds.fromJson(json['bounds'] as Map<String, dynamic>),
      plannedStart: DateTime.parse(json['plannedStart'] as String),
      plannedEnd: DateTime.parse(json['plannedEnd'] as String),
      targetSpeciesId: json['targetSpeciesId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      cacheStatus: json['cacheStatus'] == null
          ? const TripCacheStatus()
          : TripCacheStatus.fromJson(
              json['cacheStatus'] as Map<String, dynamic>),
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$$TripPlanImplToJson(_$TripPlanImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'bounds': instance.bounds.toJson(),
      'plannedStart': instance.plannedStart.toIso8601String(),
      'plannedEnd': instance.plannedEnd.toIso8601String(),
      'targetSpeciesId': instance.targetSpeciesId,
      'createdAt': instance.createdAt.toIso8601String(),
      'cacheStatus': instance.cacheStatus.toJson(),
      'userId': instance.userId,
    };

_$TripCacheStatusImpl _$$TripCacheStatusImplFromJson(
        Map<String, dynamic> json) =>
    _$TripCacheStatusImpl(
      rampId: json['rampId'] as String?,
      tilesDownloaded: json['tilesDownloaded'] as bool? ?? false,
      scoreGridReady: json['scoreGridReady'] as bool? ?? false,
    );

Map<String, dynamic> _$$TripCacheStatusImplToJson(
        _$TripCacheStatusImpl instance) =>
    <String, dynamic>{
      'rampId': instance.rampId,
      'tilesDownloaded': instance.tilesDownloaded,
      'scoreGridReady': instance.scoreGridReady,
    };
