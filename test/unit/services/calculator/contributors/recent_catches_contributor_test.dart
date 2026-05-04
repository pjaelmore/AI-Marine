import 'dart:math' as math;

import 'package:ai_marine_engine/core/types/catch_record.dart';
import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/services/calculator/contributors/recent_catches_contributor.dart';
import 'package:flutter_test/flutter_test.dart';

const _refTime = '2026-05-22T18:00:00Z';

DateTime get _now => DateTime.parse(_refTime);

CatchRecord _catch({required Duration ago}) {
  final ts = _now.subtract(ago);
  return CatchRecord(
    id: 'c-${ago.inHours}',
    userId: 'u',
    timestamp: ts,
    location: const LatLng(latitude: 27.94, longitude: -82.45),
    locationSource: LocationSource.phoneGps,
    speciesId: 'snook',
    conditions: const ConditionSnapshot(),
    createdAt: ts,
    updatedAt: ts,
  );
}

void main() {
  group('evaluateRecentCatchesContributor — envelope', () {
    test('returns ContributorApplication with name and rangeMax', () {
      final r = evaluateRecentCatchesContributor(
        recentCatches: const [],
        referenceTime: _now,
      );
      expect(r.name, 'recent_catches');
      expect(r.rangeMax, 1.0);
    });
  });

  group('evaluateRecentCatchesContributor — empty list', () {
    test('no catches → 0 with descriptive reason', () {
      final r = evaluateRecentCatchesContributor(
        recentCatches: const [],
        referenceTime: _now,
      );
      expect(r.value, 0);
      expect(r.description, contains('No recent catches'));
    });
  });

  group('evaluateRecentCatchesContributor — exponential decay', () {
    test(
      'a catch at the half-life mark (14 days) contributes ~0.5',
      () {
        final r = evaluateRecentCatchesContributor(
          recentCatches: [_catch(ago: const Duration(days: 14))],
          referenceTime: _now,
        );
        expect(r.value, closeTo(0.5, 1e-6));
      },
    );

    test('a catch right now contributes ~1.0 (capped at rangeMax)', () {
      final r = evaluateRecentCatchesContributor(
        recentCatches: [_catch(ago: Duration.zero)],
        referenceTime: _now,
      );
      // exp(0) = 1.0 exactly.
      expect(r.value, closeTo(1.0, 1e-9));
    });

    test('a catch 28 days old (two half-lives) contributes ~0.25', () {
      final r = evaluateRecentCatchesContributor(
        recentCatches: [_catch(ago: const Duration(days: 28))],
        referenceTime: _now,
      );
      expect(r.value, closeTo(0.25, 1e-6));
    });

    test('older catch contributes less than newer catch', () {
      final newer = evaluateRecentCatchesContributor(
        recentCatches: [_catch(ago: const Duration(days: 3))],
        referenceTime: _now,
      ).value;
      final older = evaluateRecentCatchesContributor(
        recentCatches: [_catch(ago: const Duration(days: 30))],
        referenceTime: _now,
      ).value;
      expect(newer > older, isTrue);
    });
  });

  group('evaluateRecentCatchesContributor — accumulation and clamp', () {
    test('multiple catches sum their decay weights', () {
      // Two catches at different ages: contributions add.
      final r = evaluateRecentCatchesContributor(
        recentCatches: [
          _catch(ago: const Duration(days: 14)), // 0.5
          _catch(ago: const Duration(days: 28)), // 0.25
        ],
        referenceTime: _now,
      );
      expect(r.value, closeTo(0.75, 1e-6));
    });

    test('many recent catches saturate at rangeMax (1.0)', () {
      // Five very-recent catches would sum to ~5; cap at 1.0.
      final r = evaluateRecentCatchesContributor(
        recentCatches: [
          for (var i = 0; i < 5; i++) _catch(ago: Duration(hours: i)),
        ],
        referenceTime: _now,
      );
      expect(r.value, 1.0);
    });

    test('reports the count in the description', () {
      final r = evaluateRecentCatchesContributor(
        recentCatches: [
          _catch(ago: const Duration(days: 1)),
          _catch(ago: const Duration(days: 5)),
          _catch(ago: const Duration(days: 12)),
        ],
        referenceTime: _now,
      );
      expect(r.description, contains('3 recent catches'));
    });

    test('singular vs plural: 1 catch → "catch", 2+ → "catches"', () {
      final one = evaluateRecentCatchesContributor(
        recentCatches: [_catch(ago: const Duration(hours: 1))],
        referenceTime: _now,
      );
      expect(one.description, contains('1 recent catch '));

      final two = evaluateRecentCatchesContributor(
        recentCatches: [
          _catch(ago: const Duration(hours: 1)),
          _catch(ago: const Duration(hours: 2)),
        ],
        referenceTime: _now,
      );
      expect(two.description, contains('2 recent catches'));
    });
  });

  group('evaluateRecentCatchesContributor — defensive', () {
    test('future-stamped catches are skipped, not given negative weight', () {
      // A catch with a timestamp after referenceTime is data noise.
      // Skip it rather than letting exp(positive) blow up.
      final r = evaluateRecentCatchesContributor(
        recentCatches: [_catch(ago: const Duration(days: -5))],
        referenceTime: _now,
      );
      expect(r.value, 0);
    });

    test(
      'matches the analytical formula across sample ages',
      () {
        // Sanity-check against an explicit formula: contribution =
        //   sum(0.5^(daysOld / halfLife)).
        const ages = [0, 1, 7, 14, 21, 30, 45];
        final catches =
            ages.map((d) => _catch(ago: Duration(days: d))).toList();
        final expected = ages
            .map((d) => math.pow(0.5, d / 14))
            .fold<double>(0.0, (a, b) => a + b)
            .clamp(0.0, 1.0);
        final actual = evaluateRecentCatchesContributor(
          recentCatches: catches,
          referenceTime: _now,
        ).value;
        expect(actual, closeTo(expected, 1e-6));
      },
    );
  });
}
