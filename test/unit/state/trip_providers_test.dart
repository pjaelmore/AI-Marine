import 'dart:async';

import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/core/types/trip_plan.dart';
import 'package:ai_marine_engine/state/trip_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

const _bbox = LatLngBounds(
  southwest: LatLng(latitude: 27.0, longitude: -83.0),
  northeast: LatLng(latitude: 28.0, longitude: -82.0),
);

TripPlan _trip(String id) => TripPlan(
      id: id,
      name: 'Trip $id',
      bounds: _bbox,
      plannedStart: DateTime.utc(2026, 5, 10, 6),
      plannedEnd: DateTime.utc(2026, 5, 10, 18),
      targetSpeciesId: 'common-snook',
      createdAt: DateTime.utc(2026, 5, 7, 22),
    );

void main() {
  group('activeTripProvider', () {
    test('returns null when activeTripIdProvider is null', () async {
      final container = ProviderContainer(
        overrides: [
          savedTripsProvider.overrideWith((ref) async => [_trip('a')]),
        ],
      );
      addTearDown(container.dispose);
      // Force the saved-trips future to resolve so the resolver has
      // a non-loading list to consult.
      await container.read(savedTripsProvider.future);
      expect(container.read(activeTripProvider), isNull);
    });

    test('returns null while savedTripsProvider is still loading', () {
      // Override with a future that never resolves so the resolver
      // sees AsyncValue.loading.
      final never = Completer<List<TripPlan>>();
      addTearDown(() {
        if (!never.isCompleted) never.complete(const []);
      });
      final container = ProviderContainer(
        overrides: [
          activeTripIdProvider.overrideWith((ref) => 'a'),
          savedTripsProvider.overrideWith((ref) => never.future),
        ],
      );
      addTearDown(container.dispose);
      expect(container.read(activeTripProvider), isNull);
    });

    test('resolves to the trip with the matching id when both are set',
        () async {
      final container = ProviderContainer(
        overrides: [
          activeTripIdProvider.overrideWith((ref) => 'b'),
          savedTripsProvider.overrideWith(
            (ref) async => [_trip('a'), _trip('b'), _trip('c')],
          ),
        ],
      );
      addTearDown(container.dispose);
      await container.read(savedTripsProvider.future);
      final active = container.read(activeTripProvider);
      expect(active?.id, 'b');
    });

    test('returns null when active id points at a deleted trip', () async {
      final container = ProviderContainer(
        overrides: [
          activeTripIdProvider.overrideWith((ref) => 'gone'),
          savedTripsProvider.overrideWith((ref) async => [_trip('a')]),
        ],
      );
      addTearDown(container.dispose);
      await container.read(savedTripsProvider.future);
      expect(container.read(activeTripProvider), isNull);
    });
  });
}
