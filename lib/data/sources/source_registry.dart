import 'dart:async';

import 'package:sentry_flutter/sentry_flutter.dart';

import '../../core/types/condition_result.dart';
import '../../core/types/lat_lng.dart';
import 'source_adapter.dart';

/// Adapter-of-record-per-data-type registry — TDD §5.7.
///
/// Adapters register themselves at startup; resolve walks the candidates
/// in registration order, picks the first one whose `canServe` passes,
/// and returns its `fetch` result. Adapter-side failures (`SourceException`)
/// are captured to Sentry and the registry falls through to the next
/// candidate. If every candidate refuses or fails, the registry returns
/// a `ConditionResult.unavailable` with the supplied sentinel.
///
/// Order matters: register higher-quality / lower-latency sources first.
/// For water temperature: live NMEA gateway (Phase 2) → NDBC buoy →
/// CoastWatch SST → cache → unavailable.
class SourceRegistry {
  final Map<Type, List<SourceAdapter<Object?>>> _adapters = {};

  /// Adds [adapter] to the candidate list for type [T]. Idempotent for the
  /// same instance; multiple adapters for the same T are kept in the order
  /// they were registered.
  void register<T>(SourceAdapter<T> adapter) {
    final list = _adapters.putIfAbsent(T, () => <SourceAdapter<Object?>>[]);
    list.add(adapter as SourceAdapter<Object?>);
  }

  /// Walks the [T] candidates and returns the first successful fetch.
  ///
  /// [unavailableValue] is the sentinel for the unavailable result when
  /// no candidate produces a value (TDD §2.1.3 specifies double NaN for
  /// numeric values, null for nullable types).
  Future<ConditionResult<T>> resolve<T>({
    required LatLng location,
    required DateTime time,
    required T unavailableValue,
  }) async {
    final candidates = _adapters[T] ?? const [];
    for (final adapter in candidates) {
      if (!adapter.canServe(location, time)) continue;
      try {
        final typed = adapter as SourceAdapter<T>;
        return await typed.fetch(location, time);
      } on SourceException catch (e, st) {
        unawaited(
          Sentry.captureException(
            e,
            stackTrace: st,
            withScope: (scope) {
              if (e.source != null) scope.setTag('source', e.source!.name);
            },
          ),
        );
        // Continue to the next candidate.
      }
    }
    return ConditionResult<T>.unavailable(value: unavailableValue, time: time);
  }

  /// Number of candidates registered for type [T] — useful in tests.
  int candidateCount<T>() => _adapters[T]?.length ?? 0;
}
