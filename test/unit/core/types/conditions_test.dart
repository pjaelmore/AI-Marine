import 'package:ai_marine_engine/core/types/conditions.dart';
import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TideState JSON round-trip', () {
    test('preserves all fields including Duration', () {
      const original = TideState(
        phase: TidePhase.rising,
        toNextChange: Duration(hours: 2, minutes: 15),
        amplitudeFt: 4.2,
      );
      final restored = TideState.fromJson(original.toJson());
      expect(restored, original);
    });

    test('handles a null amplitudeFt', () {
      const original = TideState(
        phase: TidePhase.slackHigh,
        toNextChange: Duration(minutes: 30),
      );
      final restored = TideState.fromJson(original.toJson());
      expect(restored, original);
      expect(restored.amplitudeFt, isNull);
    });
  });

  group('WindVector', () {
    test('round-trips with optional gusts', () {
      const original = WindVector(
        speedKnots: 12.0,
        directionDegrees: 270.0,
        gustsKnots: 18.0,
      );
      expect(WindVector.fromJson(original.toJson()), original);
    });

    test('round-trips without gusts', () {
      const original = WindVector(
        speedKnots: 5.0,
        directionDegrees: 180.0,
      );
      expect(WindVector.fromJson(original.toJson()), original);
    });
  });

  group('CurrentVector', () {
    test('round-trips', () {
      const original = CurrentVector(
        speedKnots: 1.5,
        directionDegrees: 90.0,
      );
      expect(CurrentVector.fromJson(original.toJson()), original);
    });
  });

  group('WaveState', () {
    test('round-trips with optional period', () {
      const original = WaveState(
        significantHeightFt: 3.5,
        dominantPeriodSec: 8.0,
      );
      expect(WaveState.fromJson(original.toJson()), original);
    });

    test('round-trips without period', () {
      const original = WaveState(significantHeightFt: 1.0);
      expect(WaveState.fromJson(original.toJson()), original);
    });
  });

  group('SolunarWindow.isActiveAt', () {
    final start = DateTime.utc(2026, 5, 22, 18, 0);
    final end = DateTime.utc(2026, 5, 22, 19, 0);
    final window = SolunarWindow(
      start: start,
      end: end,
      strength: SolunarStrength.major,
    );

    test('time before the window is inactive', () {
      expect(
        window.isActiveAt(DateTime.utc(2026, 5, 22, 17, 59)),
        isFalse,
      );
    });

    test('time inside the window is active', () {
      expect(
        window.isActiveAt(DateTime.utc(2026, 5, 22, 18, 30)),
        isTrue,
      );
    });

    test('time exactly at start is active (inclusive)', () {
      expect(window.isActiveAt(start), isTrue);
    });

    test('time exactly at end is active (inclusive)', () {
      expect(window.isActiveAt(end), isTrue);
    });

    test('time after the window is inactive', () {
      expect(
        window.isActiveAt(DateTime.utc(2026, 5, 22, 19, 1)),
        isFalse,
      );
    });
  });

  group('SolunarWindow JSON round-trip', () {
    test('preserves DateTime fields', () {
      final original = SolunarWindow(
        start: DateTime.utc(2026, 5, 22, 18, 0),
        end: DateTime.utc(2026, 5, 22, 19, 0),
        strength: SolunarStrength.major,
      );
      expect(SolunarWindow.fromJson(original.toJson()), original);
    });
  });

  group('SolunarState JSON round-trip', () {
    test('preserves nested windows', () {
      final original = SolunarState(
        sunAltitudeDegrees: 35.4,
        sunAzimuthDegrees: 120.0,
        moonPhase: MoonPhase.firstQuarter,
        moonIlluminationFraction: 0.5,
        majorWindow: SolunarWindow(
          start: DateTime.utc(2026, 5, 22, 18, 0),
          end: DateTime.utc(2026, 5, 22, 19, 0),
          strength: SolunarStrength.major,
        ),
      );
      expect(SolunarState.fromJson(original.toJson()), original);
    });

    test('handles both windows null', () {
      const original = SolunarState(
        sunAltitudeDegrees: -10.0,
        sunAzimuthDegrees: 270.0,
        moonPhase: MoonPhase.newMoon,
        moonIlluminationFraction: 0.0,
      );
      expect(SolunarState.fromJson(original.toJson()), original);
    });
  });

  group('NamedFeature JSON round-trip', () {
    test('preserves nested LatLng', () {
      const original = NamedFeature(
        name: 'Boston Channel Buoy 12',
        location: LatLng(latitude: 42.3, longitude: -70.9),
        distanceM: 350.0,
      );
      expect(NamedFeature.fromJson(original.toJson()), original);
    });
  });

  group('StructureInfo JSON round-trip', () {
    test('preserves type, transition distance, and feature list', () {
      const original = StructureInfo(
        type: StructureType.channelEdge,
        distanceToContourTransitionM: 25.5,
        nearbyFeatures: [
          NamedFeature(
            name: 'Marker R "2"',
            location: LatLng(latitude: 42.36, longitude: -70.94),
          ),
        ],
      );
      expect(StructureInfo.fromJson(original.toJson()), original);
    });

    test('defaults nearbyFeatures to an empty list', () {
      const info = StructureInfo(type: StructureType.flatBottom);
      expect(info.nearbyFeatures, isEmpty);
      expect(StructureInfo.fromJson(info.toJson()), info);
    });
  });

  group('BarometricState JSON round-trip', () {
    test('preserves all fields', () {
      const original = BarometricState(
        pressureMillibars: 1013.25,
        trend: BarometricTrend.falling,
        rateOfChangeMillibarsPerHour: -1.2,
      );
      expect(BarometricState.fromJson(original.toJson()), original);
    });
  });
}
