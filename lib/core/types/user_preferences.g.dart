// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserPreferencesImpl _$$UserPreferencesImplFromJson(
        Map<String, dynamic> json) =>
    _$UserPreferencesImpl(
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      homeRegionId: json['homeRegionId'] as String?,
      primarySpeciesId: json['primarySpeciesId'] as String?,
      units: $enumDecodeNullable(_$UnitSystemEnumMap, json['units']) ??
          UnitSystem.imperial,
      privacyOptInAggregate: json['privacyOptInAggregate'] as bool? ?? false,
      cacheBudgetMb: (json['cacheBudgetMb'] as num?)?.toInt() ?? 500,
      useNmea2000WhenAvailable:
          json['useNmea2000WhenAvailable'] as bool? ?? false,
      gatewayConfigJson: json['gatewayConfigJson'] as String?,
    );

Map<String, dynamic> _$$UserPreferencesImplToJson(
        _$UserPreferencesImpl instance) =>
    <String, dynamic>{
      'updatedAt': instance.updatedAt.toIso8601String(),
      'homeRegionId': instance.homeRegionId,
      'primarySpeciesId': instance.primarySpeciesId,
      'units': _$UnitSystemEnumMap[instance.units]!,
      'privacyOptInAggregate': instance.privacyOptInAggregate,
      'cacheBudgetMb': instance.cacheBudgetMb,
      'useNmea2000WhenAvailable': instance.useNmea2000WhenAvailable,
      'gatewayConfigJson': instance.gatewayConfigJson,
    };

const _$UnitSystemEnumMap = {
  UnitSystem.imperial: 'imperial',
  UnitSystem.metric: 'metric',
};
