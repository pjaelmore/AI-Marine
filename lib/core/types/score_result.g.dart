// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GateResultImpl _$$GateResultImplFromJson(Map<String, dynamic> json) =>
    _$GateResultImpl(
      name: json['name'] as String,
      passed: json['passed'] as bool,
      failureReason: json['failureReason'] as String?,
    );

Map<String, dynamic> _$$GateResultImplToJson(_$GateResultImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'passed': instance.passed,
      'failureReason': instance.failureReason,
    };

_$ModifierApplicationImpl _$$ModifierApplicationImplFromJson(
        Map<String, dynamic> json) =>
    _$ModifierApplicationImpl(
      name: json['name'] as String,
      value: (json['value'] as num).toDouble(),
      rangeMin: (json['rangeMin'] as num).toDouble(),
      rangeMax: (json['rangeMax'] as num).toDouble(),
      description: json['description'] as String,
      available: json['available'] as bool? ?? true,
      observedAt: json['observedAt'] == null
          ? null
          : DateTime.parse(json['observedAt'] as String),
    );

Map<String, dynamic> _$$ModifierApplicationImplToJson(
        _$ModifierApplicationImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'rangeMin': instance.rangeMin,
      'rangeMax': instance.rangeMax,
      'description': instance.description,
      'available': instance.available,
      'observedAt': instance.observedAt?.toIso8601String(),
    };

_$ContributorApplicationImpl _$$ContributorApplicationImplFromJson(
        Map<String, dynamic> json) =>
    _$ContributorApplicationImpl(
      name: json['name'] as String,
      value: (json['value'] as num).toDouble(),
      rangeMax: (json['rangeMax'] as num).toDouble(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$$ContributorApplicationImplToJson(
        _$ContributorApplicationImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'rangeMax': instance.rangeMax,
      'description': instance.description,
    };

_$ReasoningBreakdownImpl _$$ReasoningBreakdownImplFromJson(
        Map<String, dynamic> json) =>
    _$ReasoningBreakdownImpl(
      baseProbability: (json['baseProbability'] as num).toDouble(),
      gates: (json['gates'] as List<dynamic>)
          .map((e) => GateResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      modifiers: (json['modifiers'] as List<dynamic>)
          .map((e) => ModifierApplication.fromJson(e as Map<String, dynamic>))
          .toList(),
      contributors: (json['contributors'] as List<dynamic>)
          .map(
              (e) => ContributorApplication.fromJson(e as Map<String, dynamic>))
          .toList(),
      rawScoreBeforeContributors:
          (json['rawScoreBeforeContributors'] as num).toDouble(),
      additiveTotal: (json['additiveTotal'] as num).toDouble(),
      finalScore: (json['finalScore'] as num).toDouble(),
      migrationSummary: json['migrationSummary'] as String,
      suggestedApproach: json['suggestedApproach'] as String,
    );

Map<String, dynamic> _$$ReasoningBreakdownImplToJson(
        _$ReasoningBreakdownImpl instance) =>
    <String, dynamic>{
      'baseProbability': instance.baseProbability,
      'gates': instance.gates.map((e) => e.toJson()).toList(),
      'modifiers': instance.modifiers.map((e) => e.toJson()).toList(),
      'contributors': instance.contributors.map((e) => e.toJson()).toList(),
      'rawScoreBeforeContributors': instance.rawScoreBeforeContributors,
      'additiveTotal': instance.additiveTotal,
      'finalScore': instance.finalScore,
      'migrationSummary': instance.migrationSummary,
      'suggestedApproach': instance.suggestedApproach,
    };

_$ScoreResultImpl _$$ScoreResultImplFromJson(Map<String, dynamic> json) =>
    _$ScoreResultImpl(
      speciesId: json['speciesId'] as String,
      location: LatLng.fromJson(json['location'] as Map<String, dynamic>),
      time: DateTime.parse(json['time'] as String),
      finalScore: (json['finalScore'] as num).toDouble(),
      confidence: (json['confidence'] as num).toDouble(),
      reasoning: ReasoningBreakdown.fromJson(
          json['reasoning'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ScoreResultImplToJson(_$ScoreResultImpl instance) =>
    <String, dynamic>{
      'speciesId': instance.speciesId,
      'location': instance.location.toJson(),
      'time': instance.time.toIso8601String(),
      'finalScore': instance.finalScore,
      'confidence': instance.confidence,
      'reasoning': instance.reasoning.toJson(),
    };
