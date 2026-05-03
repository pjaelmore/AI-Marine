import 'package:ai_marine_engine/core/types/user_preferences.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserPreferences defaults', () {
    test('match the §4.1.3 SQL column defaults', () {
      final p = UserPreferences(updatedAt: DateTime.utc(2026, 5, 22));
      expect(p.units, UnitSystem.imperial);
      expect(p.privacyOptInAggregate, isFalse);
      expect(p.cacheBudgetMb, 500);
      expect(p.useNmea2000WhenAvailable, isFalse);
      expect(p.homeRegionId, isNull);
      expect(p.primarySpeciesId, isNull);
      expect(p.gatewayConfigJson, isNull);
    });
  });

  group('UserPreferences JSON round-trip', () {
    test('preserves a fully-populated record', () {
      final original = UserPreferences(
        updatedAt: DateTime.utc(2026, 5, 22, 18, 0),
        homeRegionId: 'mass_bay',
        primarySpeciesId: 'striped_bass',
        units: UnitSystem.metric,
        privacyOptInAggregate: true,
        cacheBudgetMb: 1024,
        useNmea2000WhenAvailable: true,
        gatewayConfigJson: '{"gatewayId":"vesper-01"}',
      );
      expect(UserPreferences.fromJson(original.toJson()), original);
    });

    test('round-trips an all-default record', () {
      final original = UserPreferences(updatedAt: DateTime.utc(2026, 1, 1));
      expect(UserPreferences.fromJson(original.toJson()), original);
    });
  });
}
