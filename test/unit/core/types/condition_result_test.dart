import 'package:ai_marine_engine/core/types/condition_result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SourceDetails JSON round-trip', () {
    test('preserves stationId and cacheHitLayer', () {
      const original = SourceDetails(
        stationId: '44013',
        cacheHitLayer: CacheLayer.warm,
      );
      expect(SourceDetails.fromJson(original.toJson()), original);
    });

    test('handles all-null fields', () {
      const original = SourceDetails();
      final restored = SourceDetails.fromJson(original.toJson());
      expect(restored, original);
      expect(restored.stationId, isNull);
      expect(restored.cacheHitLayer, isNull);
      expect(restored.interpolationDistanceNm, isNull);
    });

    test('preserves interpolation distance for interpolated sources', () {
      const original = SourceDetails(interpolationDistanceNm: 12.4);
      expect(
        SourceDetails.fromJson(original.toJson()).interpolationDistanceNm,
        closeTo(12.4, 1e-9),
      );
    });
  });

  group('ConditionResult equality', () {
    test('two results with the same fields compare equal', () {
      final t = DateTime.utc(2026, 5, 22, 18, 0);
      final a = ConditionResult<double>(
        value: 64.5,
        unit: 'F',
        source: DataSource.noaaNdbc,
        sourceDetails: const SourceDetails(stationId: '44013'),
        fetchedAt: t,
        validUntil: t.add(const Duration(minutes: 30)),
        confidence: 0.95,
      );
      final b = ConditionResult<double>(
        value: 64.5,
        unit: 'F',
        source: DataSource.noaaNdbc,
        sourceDetails: const SourceDetails(stationId: '44013'),
        fetchedAt: t,
        validUntil: t.add(const Duration(minutes: 30)),
        confidence: 0.95,
      );
      expect(a, b);
    });
  });

  group('ConditionResult.unavailable', () {
    test('uses DataSource.unavailable, confidence 0, and the given sentinel',
        () {
      final t = DateTime.utc(2026, 5, 22, 18, 0);
      final r = ConditionResult<double>.unavailable(
        value: double.nan,
        time: t,
      );
      expect(r.source, DataSource.unavailable);
      expect(r.confidence, 0);
      expect(r.value.isNaN, isTrue);
      expect(r.fetchedAt, t);
      expect(r.validUntil, t);
      expect(r.sourceDetails, const SourceDetails());
    });

    test('works for nullable T with a null sentinel', () {
      final t = DateTime.utc(2026, 5, 22, 18, 0);
      final r = ConditionResult<int?>.unavailable(value: null, time: t);
      expect(r.value, isNull);
      expect(r.source, DataSource.unavailable);
      expect(r.confidence, 0);
    });
  });
}
