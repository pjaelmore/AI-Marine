import 'package:ai_marine_engine/ui/design/colors.dart';
import 'package:ai_marine_engine/ui/design/spacing.dart';
import 'package:ai_marine_engine/ui/design/theme.dart';
import 'package:ai_marine_engine/ui/design/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// These tests pin the design tokens to the values specified in TDD §10.1
/// and §10.2.2. If the spec changes, update the tokens and these expectations
/// together; if a token drifts without a spec change, the test fails loud.
void main() {
  group('MarineColors — TDD §10.1 brand palette', () {
    test('deep marine blue is #0F2A47', () {
      expect(MarineColors.deepMarine, const Color(0xFF0F2A47));
    });

    test('action teal is #0F6E56', () {
      expect(MarineColors.actionTeal, const Color(0xFF0F6E56));
    });

    test('warning amber is #E89F3C', () {
      expect(MarineColors.warnAmber, const Color(0xFFE89F3C));
    });
  });

  group('MarineColors — TDD §10.2.2 heatmap stops', () {
    test('amber low has α ≈ 0.20', () {
      expect(MarineColors.heatmapAmberLow.alpha, 0x33);
    });

    test('amber mid has α ≈ 0.35', () {
      expect(MarineColors.heatmapAmberMid.alpha, 0x59);
    });

    test('green mid has α ≈ 0.35', () {
      expect(MarineColors.heatmapGreenMid.alpha, 0x59);
    });

    test('green high has α ≈ 0.45 (peak per spec)', () {
      expect(MarineColors.heatmapGreenHigh.alpha, 0x73);
    });
  });

  group('MarineTypography — TDD §10.1 minimums', () {
    test('body minimum is 16pt', () {
      expect(MarineTypography.bodyMinSize, 16.0);
      expect(MarineTypography.bodyLarge.fontSize, 16.0);
    });

    test('numeric readout minimum is 22pt', () {
      expect(MarineTypography.numericMinSize, 22.0);
      expect(MarineTypography.numericReadout.fontSize, 22.0);
    });

    test('numeric styles use tabular figures', () {
      const tabular = FontFeature.tabularFigures();
      expect(MarineTypography.numericReadout.fontFeatures, contains(tabular));
      expect(MarineTypography.pinNumeral.fontFeatures, contains(tabular));
      expect(MarineTypography.cardScoreNumeral.fontFeatures, contains(tabular));
    });
  });

  group('MarineSpacing — TDD §10.1 touch targets', () {
    test('phone touch target is 48dp', () {
      expect(MarineSpacing.touchPhone, 48.0);
    });

    test('tablet touch target is 56dp', () {
      expect(MarineSpacing.touchTablet, 56.0);
    });

    test('helm-mode touch target is 64dp', () {
      expect(MarineSpacing.touchHelm, 64.0);
    });
  });

  group('buildMarineTheme', () {
    final theme = buildMarineTheme();

    test('is dark-first per TDD §10.1', () {
      expect(theme.brightness, Brightness.dark);
      expect(theme.colorScheme.brightness, Brightness.dark);
    });

    test('uses Material 3', () {
      expect(theme.useMaterial3, isTrue);
    });

    test('primary maps to action teal', () {
      expect(theme.colorScheme.primary, MarineColors.actionTeal);
    });

    test('surface maps to deep marine blue', () {
      expect(theme.colorScheme.surface, MarineColors.deepMarine);
      expect(theme.scaffoldBackgroundColor, MarineColors.deepMarine);
    });

    test('secondary maps to warn amber', () {
      expect(theme.colorScheme.secondary, MarineColors.warnAmber);
    });

    test('elevated buttons enforce phone touch-target minimum', () {
      final size = theme.elevatedButtonTheme.style?.minimumSize?.resolve({});
      expect(size?.height, MarineSpacing.touchPhone);
    });
  });
}
