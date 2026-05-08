import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/core/types/trip_plan.dart';
import 'package:flutter_test/flutter_test.dart';

const _bbox = LatLngBounds(
  southwest: LatLng(latitude: 27.0, longitude: -83.0),
  northeast: LatLng(latitude: 28.0, longitude: -82.0),
);

TripPlan _trip({
  String id = 'trip-1',
  TripCacheStatus cacheStatus = const TripCacheStatus(),
}) {
  return TripPlan(
    id: id,
    name: 'Tampa Bay snook',
    bounds: _bbox,
    plannedStart: DateTime.utc(2026, 5, 10, 6),
    plannedEnd: DateTime.utc(2026, 5, 10, 18),
    targetSpeciesId: 'common-snook',
    createdAt: DateTime.utc(2026, 5, 7, 22),
    cacheStatus: cacheStatus,
  );
}

void main() {
  group('TripPlan — derived getters', () {
    test('center returns the bbox geometric centre', () {
      final plan = _trip();
      expect(plan.center.latitude, 27.5);
      expect(plan.center.longitude, -82.5);
    });

    test('containsTime is inclusive of the start and end edges', () {
      final plan = _trip();
      expect(plan.containsTime(DateTime.utc(2026, 5, 10, 6)), isTrue);
      expect(plan.containsTime(DateTime.utc(2026, 5, 10, 18)), isTrue);
      // One minute outside each edge.
      expect(plan.containsTime(DateTime.utc(2026, 5, 10, 5, 59)), isFalse);
      expect(plan.containsTime(DateTime.utc(2026, 5, 10, 18, 1)), isFalse);
    });

    test('containsTime returns true for a moment mid-trip', () {
      final plan = _trip();
      expect(plan.containsTime(DateTime.utc(2026, 5, 10, 12)), isTrue);
    });
  });

  group('TripPlan — JSON round-trip', () {
    test('preserves every field through encode + decode', () {
      final plan = _trip(
        cacheStatus: const TripCacheStatus(
          stationId: '41009',
          tilesDownloaded: true,
          scoreGridReady: false,
        ),
      );
      final json = plan.toJson();
      final restored = TripPlan.fromJson(json);
      expect(restored, plan);
    });

    test('default cacheStatus round-trips with all fields at their defaults',
        () {
      final plan = _trip();
      final restored = TripPlan.fromJson(plan.toJson());
      expect(restored.cacheStatus, const TripCacheStatus());
    });
  });

  group('TripCacheStatus — defaults', () {
    test('stationId defaults to null, flags default to false', () {
      const status = TripCacheStatus();
      expect(status.stationId, isNull);
      expect(status.tilesDownloaded, isFalse);
      expect(status.scoreGridReady, isFalse);
    });
  });
}
