import 'package:ai_marine_engine/core/types/condition_result.dart';
import 'package:ai_marine_engine/data/cache/result_codec.dart';
import 'package:flutter_test/flutter_test.dart';

ConditionResult<double> _sample({DateTime? observedAt}) {
  final t = DateTime.utc(2026, 5, 16, 19);
  return ConditionResult<double>(
    value: 78.4,
    unit: 'F',
    source: DataSource.noaaNdbc,
    sourceDetails: const SourceDetails(stationId: '41009'),
    fetchedAt: t,
    validUntil: t.add(const Duration(hours: 1)),
    confidence: 0.9,
    observedAt: observedAt,
  );
}

void main() {
  group('result_codec — round-trip', () {
    test('preserves every primary provenance field', () {
      final original = _sample(observedAt: DateTime.utc(2026, 5, 16, 18, 50));
      final decoded = decodeConditionResult<double>(
        encodeConditionResult(original, (v) => v),
        (raw) => (raw as num).toDouble(),
      );
      expect(decoded.value, original.value);
      expect(decoded.unit, original.unit);
      expect(decoded.source, original.source);
      expect(decoded.sourceDetails.stationId, '41009');
      expect(decoded.fetchedAt, original.fetchedAt);
      expect(decoded.validUntil, original.validUntil);
      expect(decoded.confidence, original.confidence);
    });

    test(
      'observedAt round-trips when set — '
      'cache reads must surface the same "Observed h:mm a" subtitle',
      () {
        // Regression for a bug where the cache silently dropped
        // observedAt, so a cached-read of water temp would show no
        // freshness subtitle while the fresh-read directly after a
        // fetch would.
        final ts = DateTime.utc(2026, 5, 16, 18, 50);
        final decoded = decodeConditionResult<double>(
          encodeConditionResult(_sample(observedAt: ts), (v) => v),
          (raw) => (raw as num).toDouble(),
        );
        expect(decoded.observedAt, ts);
      },
    );

    test('observedAt stays null when never set', () {
      final decoded = decodeConditionResult<double>(
        encodeConditionResult(_sample(), (v) => v),
        (raw) => (raw as num).toDouble(),
      );
      expect(decoded.observedAt, isNull);
    });
  });
}
