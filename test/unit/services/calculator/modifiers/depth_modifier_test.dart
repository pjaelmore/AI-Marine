import 'package:ai_marine_engine/data/species/models/condition_profile.dart';
import 'package:ai_marine_engine/services/calculator/modifiers/depth_modifier.dart';
import 'package:flutter_test/flutter_test.dart';

/// Snook-flavored point-depth preference: prefer 5–25 ft with peak
/// around 12 ft (mangrove-shoreline / dock-piling depths). Boundary
/// values are illustrative; calibration tuples in a later slice
/// will pin real species data.
const _snookDepth = DepthPreference(minFt: 5, maxFt: 25, idealFt: 12);

void main() {
  group('evaluateDepthModifier — envelope', () {
    test('returns ModifierApplication with name and rangeMin/rangeMax', () {
      final r = evaluateDepthModifier(
        depthFt: 12,
        preference: _snookDepth,
      );
      expect(r.name, 'depth');
      expect(r.rangeMin, 0);
      expect(r.rangeMax, 2);
      expect(r.description, contains('12.0 ft'));
      expect(r.description, contains('ideal 12 ft'));
      expect(r.description, contains('5–25 ft'));
    });
  });

  group('evaluateDepthModifier — peak and bounds', () {
    test('depth at idealFt returns max multiplier 2.0', () {
      expect(
        evaluateDepthModifier(depthFt: 12, preference: _snookDepth).value,
        2.0,
      );
    });

    test('depth at minFt returns 0 (range bound exclusive)', () {
      expect(
        evaluateDepthModifier(depthFt: 5, preference: _snookDepth).value,
        0,
      );
    });

    test('depth at maxFt returns 0 (range bound exclusive)', () {
      expect(
        evaluateDepthModifier(depthFt: 25, preference: _snookDepth).value,
        0,
      );
    });

    test('depth well outside the range returns 0', () {
      expect(
        evaluateDepthModifier(depthFt: 1, preference: _snookDepth).value,
        0,
      );
      expect(
        evaluateDepthModifier(depthFt: 200, preference: _snookDepth).value,
        0,
      );
    });
  });

  group('evaluateDepthModifier — linear ramps', () {
    test(
      'rising-edge midpoint (8.5 ft, halfway between 5 and 12) reads ~1.0',
      () {
        // preference = 0.5, multiplier = 1.0
        expect(
          evaluateDepthModifier(depthFt: 8.5, preference: _snookDepth).value,
          closeTo(1.0, 1e-9),
        );
      },
    );

    test(
      'falling-edge midpoint (18.5 ft, halfway between 12 and 25) reads ~1.0',
      () {
        expect(
          evaluateDepthModifier(depthFt: 18.5, preference: _snookDepth).value,
          closeTo(1.0, 1e-9),
        );
      },
    );

    test('rising edge is monotone increasing', () {
      double m(double d) =>
          evaluateDepthModifier(depthFt: d, preference: _snookDepth).value;
      expect(m(6) < m(8), isTrue);
      expect(m(8) < m(10), isTrue);
      expect(m(10) < m(11), isTrue);
    });
  });

  group('evaluateDepthModifier — offshore species', () {
    test('a deeper preference (gag grouper-like) peaks where you expect', () {
      // 60–120 ft tolerated, 90 ft ideal — typical mid-shelf reef.
      const grouperDepth = DepthPreference(
        minFt: 60,
        maxFt: 120,
        idealFt: 90,
      );
      expect(
        evaluateDepthModifier(depthFt: 90, preference: grouperDepth).value,
        2.0,
      );
      // 30 ft is well below tolerated.
      expect(
        evaluateDepthModifier(depthFt: 30, preference: grouperDepth).value,
        0,
      );
    });
  });
}
