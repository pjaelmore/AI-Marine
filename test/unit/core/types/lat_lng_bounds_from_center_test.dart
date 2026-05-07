import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LatLngBounds.fromCenter', () {
    test('places the centre at the geometric centre of the bbox', () {
      const center = LatLng(latitude: 27.94, longitude: -82.45);
      final bbox = LatLngBounds.fromCenter(center: center, radiusNm: 15);
      expect(bbox.center.latitude, closeTo(center.latitude, 1e-9));
      expect(bbox.center.longitude, closeTo(center.longitude, 1e-9));
    });

    test('north/south extent is symmetric and ≈ 2 × radius nm', () {
      const center = LatLng(latitude: 27.94, longitude: -82.45);
      final bbox = LatLngBounds.fromCenter(center: center, radiusNm: 15);
      // 1° latitude ≈ 60 nm, so 15 nm radius → 0.25° each side → 30
      // nm height total.
      expect(bbox.heightNm, closeTo(30, 0.1));
    });

    test(
      'east/west extent shrinks with cos(latitude) so the box stays roughly '
      'square in nm at the centre latitude',
      () {
        const tampa = LatLng(latitude: 27.94, longitude: -82.45);
        final bbox = LatLngBounds.fromCenter(center: tampa, radiusNm: 15);
        // widthNm uses the centre latitude internally — at Tampa the
        // box should be approximately as wide as it is tall.
        expect(bbox.widthNm, closeTo(30, 1.0));
      },
    );

    test(
      'a centre near a pole does not divide by zero (cosLat floor)',
      () {
        const polar = LatLng(latitude: 89.999, longitude: 0);
        // No throw — width gets clamped by the cosLat floor.
        final bbox = LatLngBounds.fromCenter(center: polar, radiusNm: 15);
        expect(bbox.heightNm, closeTo(30, 0.1));
        expect(bbox.widthNm.isFinite, isTrue);
        expect(bbox.widthNm.isNaN, isFalse);
      },
    );

    test('larger radius produces a larger bbox (linear in nm)', () {
      const center = LatLng(latitude: 27.94, longitude: -82.45);
      final small = LatLngBounds.fromCenter(center: center, radiusNm: 5);
      final big = LatLngBounds.fromCenter(center: center, radiusNm: 25);
      expect(big.heightNm / small.heightNm, closeTo(5.0, 0.1));
    });
  });
}
