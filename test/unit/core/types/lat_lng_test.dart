import 'dart:convert';

import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LatLng.isValid', () {
    test('accepts the WGS-84 range', () {
      expect(const LatLng(latitude: 0, longitude: 0).isValid, isTrue);
      expect(const LatLng(latitude: -90, longitude: -180).isValid, isTrue);
      expect(const LatLng(latitude: 90, longitude: 180).isValid, isTrue);
    });

    test('rejects coordinates outside the WGS-84 range', () {
      expect(const LatLng(latitude: 90.0001, longitude: 0).isValid, isFalse);
      expect(const LatLng(latitude: -90.0001, longitude: 0).isValid, isFalse);
      expect(const LatLng(latitude: 0, longitude: 180.0001).isValid, isFalse);
      expect(const LatLng(latitude: 0, longitude: -180.0001).isValid, isFalse);
    });
  });

  group('LatLng.distanceTo', () {
    test('a point to itself is 0', () {
      const p = LatLng(latitude: 42.36, longitude: -70.55);
      expect(p.distanceTo(p), closeTo(0, 1e-6));
    });

    test('is symmetric', () {
      const a = LatLng(latitude: 42.36, longitude: -70.55);
      const b = LatLng(latitude: 41.0, longitude: -71.5);
      expect(a.distanceTo(b), closeTo(b.distanceTo(a), 1e-9));
    });

    // Reference distances published by great-circle calculators / standard
    // navigation tables. Tolerance is 1% to allow for spherical-vs-WGS-84
    // ellipsoidal divergence (TDD §3.1 specifies haversine, which assumes
    // a sphere).
    final cityPairs = <(String, LatLng, LatLng, double)>[
      (
        'NYC -> Los Angeles',
        const LatLng(latitude: 40.7128, longitude: -74.0060),
        const LatLng(latitude: 34.0522, longitude: -118.2437),
        2125, // ≈ 2451 statute miles
      ),
      (
        'London -> Paris',
        const LatLng(latitude: 51.5074, longitude: -0.1278),
        const LatLng(latitude: 48.8566, longitude: 2.3522),
        186, // ≈ 214 statute miles
      ),
      (
        'Boston -> Provincetown',
        const LatLng(latitude: 42.3601, longitude: -71.0589),
        const LatLng(latitude: 42.0584, longitude: -70.1859),
        43,
      ),
    ];

    for (final pair in cityPairs) {
      final name = pair.$1;
      final a = pair.$2;
      final b = pair.$3;
      final expectedNm = pair.$4;
      test('$name reference distance', () {
        expect(a.distanceTo(b), closeTo(expectedNm, expectedNm * 0.01));
      });
    }
  });

  group('LatLng JSON', () {
    test('round-trip through Map preserves both fields', () {
      const original = LatLng(latitude: 42.3601, longitude: -71.0589);
      final restored = LatLng.fromJson(original.toJson());
      expect(restored, original);
    });

    test('round-trip through encoded string preserves both fields', () {
      const original = LatLng(latitude: -33.8688, longitude: 151.2093);
      final str = jsonEncode(original.toJson());
      final restored = LatLng.fromJson(jsonDecode(str) as Map<String, dynamic>);
      expect(restored, original);
    });
  });

  group('LatLngBounds', () {
    const bounds = LatLngBounds(
      southwest: LatLng(latitude: 42.0, longitude: -71.0),
      northeast: LatLng(latitude: 43.0, longitude: -70.0),
    );

    test('contains a clearly-inside point', () {
      expect(
        bounds.contains(const LatLng(latitude: 42.5, longitude: -70.5)),
        isTrue,
      );
    });

    test('contains points exactly on edges', () {
      expect(
        bounds.contains(const LatLng(latitude: 42.0, longitude: -70.5)),
        isTrue,
      );
      expect(
        bounds.contains(const LatLng(latitude: 43.0, longitude: -71.0)),
        isTrue,
      );
    });

    test('rejects points outside', () {
      expect(
        bounds.contains(const LatLng(latitude: 41.99, longitude: -70.5)),
        isFalse,
      );
      expect(
        bounds.contains(const LatLng(latitude: 42.5, longitude: -69.99)),
        isFalse,
      );
    });

    test('center is the midpoint', () {
      expect(bounds.center.latitude, closeTo(42.5, 1e-9));
      expect(bounds.center.longitude, closeTo(-70.5, 1e-9));
    });

    test('heightNm is 60 nm per degree of latitude', () {
      expect(bounds.heightNm, closeTo(60.0, 0.01));
    });

    test('widthNm shrinks with cos(latitude)', () {
      // At lat 42.5°: cos ≈ 0.737, so 1° lon ≈ 44.2 nm.
      expect(bounds.widthNm, closeTo(44.2, 0.5));
    });

    test('JSON round-trip preserves both corners', () {
      final restored = LatLngBounds.fromJson(bounds.toJson());
      expect(restored, bounds);
    });
  });

  group('GeoPolygon.contains', () {
    const square = GeoPolygon(
      rings: [
        [
          LatLng(latitude: 0, longitude: 0),
          LatLng(latitude: 0, longitude: 10),
          LatLng(latitude: 10, longitude: 10),
          LatLng(latitude: 10, longitude: 0),
        ],
      ],
    );

    test('a point clearly inside', () {
      expect(square.contains(const LatLng(latitude: 5, longitude: 5)), isTrue);
    });

    test('a point exactly on a vertex', () {
      expect(square.contains(const LatLng(latitude: 0, longitude: 0)), isTrue);
    });

    test('a point exactly on an edge midpoint', () {
      expect(square.contains(const LatLng(latitude: 5, longitude: 0)), isTrue);
    });

    test('a point clearly outside', () {
      expect(
        square.contains(const LatLng(latitude: 11, longitude: 11)),
        isFalse,
      );
    });

    test('handles concave polygon — point in indent is outside', () {
      // U-shape opening downward: indent is in the middle of the bottom.
      const u = GeoPolygon(
        rings: [
          [
            LatLng(latitude: 0, longitude: 0),
            LatLng(latitude: 10, longitude: 0),
            LatLng(latitude: 10, longitude: 10),
            LatLng(latitude: 0, longitude: 10),
            LatLng(latitude: 0, longitude: 7),
            LatLng(latitude: 7, longitude: 7),
            LatLng(latitude: 7, longitude: 3),
            LatLng(latitude: 0, longitude: 3),
          ],
        ],
      );
      // Inside the indent: outside the polygon.
      expect(u.contains(const LatLng(latitude: 3, longitude: 5)), isFalse);
      // Inside one of the U's arms.
      expect(u.contains(const LatLng(latitude: 8, longitude: 5)), isTrue);
    });

    test('handles polygon with a hole — point in hole is outside', () {
      const donut = GeoPolygon(
        rings: [
          // Outer 10×10 square.
          [
            LatLng(latitude: 0, longitude: 0),
            LatLng(latitude: 0, longitude: 10),
            LatLng(latitude: 10, longitude: 10),
            LatLng(latitude: 10, longitude: 0),
          ],
          // 4–6 square in the centre (hole).
          [
            LatLng(latitude: 4, longitude: 4),
            LatLng(latitude: 4, longitude: 6),
            LatLng(latitude: 6, longitude: 6),
            LatLng(latitude: 6, longitude: 4),
          ],
        ],
      );
      expect(
        donut.contains(const LatLng(latitude: 5, longitude: 5)),
        isFalse,
        reason: 'centre of hole',
      );
      expect(
        donut.contains(const LatLng(latitude: 2, longitude: 2)),
        isTrue,
        reason: 'inside donut ring',
      );
      expect(
        donut.contains(const LatLng(latitude: 11, longitude: 5)),
        isFalse,
        reason: 'outside outer ring',
      );
    });

    test('empty polygon contains no points', () {
      const empty = GeoPolygon(rings: []);
      expect(empty.contains(const LatLng(latitude: 0, longitude: 0)), isFalse);
    });

    test('JSON round-trip preserves rings', () {
      const polygon = GeoPolygon(
        rings: [
          [
            LatLng(latitude: 0, longitude: 0),
            LatLng(latitude: 0, longitude: 1),
            LatLng(latitude: 1, longitude: 1),
          ],
        ],
      );
      final restored = GeoPolygon.fromJson(polygon.toJson());
      expect(restored, polygon);
    });
  });
}
