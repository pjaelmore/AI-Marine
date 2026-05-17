import 'dart:convert';

import '../../core/types/condition_result.dart';

/// Serializes a [ConditionResult] into a JSON string for the warm
/// cache, preserving every provenance field so the on-read rebuild
/// is faithful to the original fetch.
///
/// Why per-T factories: `condition_result.dart` line 50 documents that
/// freezed's json_serializable can't codegen a generic envelope's
/// fromJson without them. The cache layer owns this boilerplate
/// rather than every condition type carrying a typed cache adapter.
String encodeConditionResult<T>(
  ConditionResult<T> r,
  Object? Function(T value) toJsonT,
) {
  return jsonEncode(<String, Object?>{
    'v': toJsonT(r.value),
    'unit': r.unit,
    'src': r.source.name,
    'sd': r.sourceDetails.toJson(),
    'fA': r.fetchedAt.millisecondsSinceEpoch,
    'vU': r.validUntil.millisecondsSinceEpoch,
    'c': r.confidence,
    // Optional fields — only emit when set so old cache rows don't
    // grow new keys gratuitously.
    if (r.observedAt != null) 'oA': r.observedAt!.millisecondsSinceEpoch,
  });
}

/// Inverse of [encodeConditionResult]. The caller supplies [fromJsonT]
/// because freezed types' fromJson needs a Map<String,dynamic>; doubles
/// and other primitives unwrap differently.
ConditionResult<T> decodeConditionResult<T>(
  String json,
  T Function(Object? rawValue) fromJsonT,
) {
  final m = jsonDecode(json) as Map<String, dynamic>;
  final observedAtRaw = m['oA'];
  return ConditionResult<T>(
    value: fromJsonT(m['v']),
    unit: m['unit'] as String,
    source: DataSource.values.byName(m['src'] as String),
    sourceDetails: SourceDetails.fromJson(m['sd'] as Map<String, dynamic>),
    fetchedAt: DateTime.fromMillisecondsSinceEpoch(
      m['fA'] as int,
      isUtc: true,
    ),
    validUntil: DateTime.fromMillisecondsSinceEpoch(
      m['vU'] as int,
      isUtc: true,
    ),
    confidence: (m['c'] as num).toDouble(),
    observedAt: observedAtRaw == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(
            observedAtRaw as int,
            isUtc: true,
          ),
  );
}
