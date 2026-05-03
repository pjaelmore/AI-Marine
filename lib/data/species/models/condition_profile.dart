import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/types/conditions.dart';

part 'condition_profile.freezed.dart';
part 'condition_profile.g.dart';

/// Species-level (or size-class-level) preferences that the calculator's
/// modifier and contributor functions consume. Mirrors TDD §3.3.3.
///
/// All fields are required because absent data must be modeled explicitly
/// (e.g. a species that doesn't care about salinity sets a wide range or
/// uses a `null` for `salinityPreference`). Empty lists are permitted and
/// treated by callers as "no signal."
@freezed
class ConditionProfile with _$ConditionProfile {
  const factory ConditionProfile({
    required TemperatureRange optimalTemp,
    required TemperatureRange toleratedTemp,
    required DepthPreference depthPreference,
    @Default(<StructurePreference>[])
    List<StructurePreference> structurePreferences,
    required TidePreference tidePreference,
    required SolunarSensitivity solunarSensitivity,
    @Default(<TimeOfDayPreference>[])
    List<TimeOfDayPreference> timeOfDayPreferences,
    required LunarSensitivity lunarSensitivity,
    required WeatherSensitivity weatherSensitivity,
    SalinityPreference? salinityPreference,
    required CurrentPreference currentPreference,
    @Default(<BaitAssociation>[]) List<BaitAssociation> baitAssociations,
  }) = _ConditionProfile;

  factory ConditionProfile.fromJson(Map<String, dynamic> json) =>
      _$ConditionProfileFromJson(json);
}

/// Inclusive range with a single-point ideal — the trapezoidal-curve shape
/// used pervasively in the calculator (TDD §6.3).
@freezed
class TemperatureRange with _$TemperatureRange {
  const factory TemperatureRange({
    required double minF,
    required double maxF,
    required double idealF,
  }) = _TemperatureRange;

  factory TemperatureRange.fromJson(Map<String, dynamic> json) =>
      _$TemperatureRangeFromJson(json);
}

@freezed
class DepthPreference with _$DepthPreference {
  const factory DepthPreference({
    required double minFt,
    required double maxFt,
    required double idealFt,
  }) = _DepthPreference;

  factory DepthPreference.fromJson(Map<String, dynamic> json) =>
      _$DepthPreferenceFromJson(json);
}

/// Preference for one structure type. [weight] is in [0, 1].
@freezed
class StructurePreference with _$StructurePreference {
  const factory StructurePreference({
    required StructureType type,
    required double weight,
  }) = _StructurePreference;

  factory StructurePreference.fromJson(Map<String, dynamic> json) =>
      _$StructurePreferenceFromJson(json);
}

/// Tide-phase preferences. [phaseWeights] maps each [TidePhase] to a weight
/// in [0, 1]; absent keys default to 0 in caller logic.
@freezed
class TidePreference with _$TidePreference {
  const factory TidePreference({
    required Map<TidePhase, double> phaseWeights,
    @Default(false) bool prefersSpringTides,
  }) = _TidePreference;

  factory TidePreference.fromJson(Map<String, dynamic> json) =>
      _$TidePreferenceFromJson(json);
}

enum SolunarSensitivity { none, low, medium, high }

enum LunarSensitivity { none, low, medium, high }

@freezed
class TimeOfDayPreference with _$TimeOfDayPreference {
  const factory TimeOfDayPreference({
    required int startHour,
    required int endHour,
    required double weight,
  }) = _TimeOfDayPreference;

  factory TimeOfDayPreference.fromJson(Map<String, dynamic> json) =>
      _$TimeOfDayPreferenceFromJson(json);
}

@freezed
class WeatherSensitivity with _$WeatherSensitivity {
  const factory WeatherSensitivity({
    required double risingPressureFactor,
    required double fallingPressureFactor,
    required double frontalPassageFactor,
    required double cloudCoverPreference,
  }) = _WeatherSensitivity;

  factory WeatherSensitivity.fromJson(Map<String, dynamic> json) =>
      _$WeatherSensitivityFromJson(json);
}

@freezed
class SalinityPreference with _$SalinityPreference {
  const factory SalinityPreference({
    required double minPpt,
    required double maxPpt,
    required double idealPpt,
  }) = _SalinityPreference;

  factory SalinityPreference.fromJson(Map<String, dynamic> json) =>
      _$SalinityPreferenceFromJson(json);
}

@freezed
class CurrentPreference with _$CurrentPreference {
  const factory CurrentPreference({
    required double minKnots,
    required double maxKnots,
    required double idealKnots,
  }) = _CurrentPreference;

  factory CurrentPreference.fromJson(Map<String, dynamic> json) =>
      _$CurrentPreferenceFromJson(json);
}

@freezed
class BaitAssociation with _$BaitAssociation {
  const factory BaitAssociation({
    required String baitfish,
    required double weight,
  }) = _BaitAssociation;

  factory BaitAssociation.fromJson(Map<String, dynamic> json) =>
      _$BaitAssociationFromJson(json);
}
