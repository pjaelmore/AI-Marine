import 'package:ai_marine_engine/core/types/condition_result.dart';
import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/data/sources/solunar/solunar_adapter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SolunarAdapter', () {
    final adapter = SolunarAdapter();
    const boston = LatLng(latitude: 42.3601, longitude: -71.0589);
    final t = DateTime.utc(2026, 5, 22, 18);

    test('claims sourceId computedLocal — no network', () {
      expect(adapter.sourceId, DataSource.computedLocal);
    });

    test('canServe is universally true (sun/moon math is global)', () {
      expect(adapter.canServe(boston, t), isTrue);
      expect(
        adapter.canServe(const LatLng(latitude: 0, longitude: 0), t),
        isTrue,
      );
    });

    test('fetch returns a SolunarState with confidence 1', () async {
      final result = await adapter.fetch(boston, t);
      expect(result.source, DataSource.computedLocal);
      expect(result.confidence, 1);
      expect(result.value.moonIlluminationFraction, inInclusiveRange(0, 1));
    });

    test('fetch stamps a defaultTtl of 1 hour', () async {
      final result = await adapter.fetch(boston, t);
      final span = result.validUntil.difference(result.fetchedAt);
      expect(span, const Duration(hours: 1));
    });
  });
}
