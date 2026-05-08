import 'package:ai_marine_engine/data/sources/ndbc/buoy_station.dart';
import 'package:ai_marine_engine/state/plan_trip_draft_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

const _station = BuoyStation(
  id: '41009',
  name: 'CANAVERAL 20 NM East of Cape Canaveral, FL',
  lat: 28.508,
  lon: -80.185,
);

void main() {
  group('PlanTripDraft.isComplete', () {
    test('returns false until every required field is set', () {
      var draft = const PlanTripDraft();
      expect(draft.isComplete, isFalse);

      draft = draft.copyWith(station: _station);
      expect(draft.isComplete, isFalse);

      draft = draft.copyWith(plannedStart: DateTime.utc(2026, 5, 10, 6));
      expect(draft.isComplete, isFalse);

      draft = draft.copyWith(plannedEnd: DateTime.utc(2026, 5, 10, 18));
      expect(draft.isComplete, isFalse);

      draft = draft.copyWith(targetSpeciesId: 'common-snook');
      expect(draft.isComplete, isTrue);
    });

    test('returns false when targetSpeciesId is the empty string', () {
      final draft = const PlanTripDraft().copyWith(
        station: _station,
        plannedStart: DateTime.utc(2026, 5, 10, 6),
        plannedEnd: DateTime.utc(2026, 5, 10, 18),
        targetSpeciesId: '',
      );
      expect(draft.isComplete, isFalse);
    });
  });

  group('PlanTripDraftNotifier', () {
    test('starts with a fully-empty draft', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final draft = container.read(planTripDraftProvider);
      expect(draft.station, isNull);
      expect(draft.plannedStart, isNull);
      expect(draft.plannedEnd, isNull);
      expect(draft.targetSpeciesId, isNull);
    });

    test('setStation / setTimeWindow / setSpecies write the draft fields', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final notifier = container.read(planTripDraftProvider.notifier);

      notifier.setStation(_station);
      expect(container.read(planTripDraftProvider).station, _station);

      notifier.setTimeWindow(
        DateTime.utc(2026, 5, 10, 6),
        DateTime.utc(2026, 5, 10, 18),
      );
      final mid = container.read(planTripDraftProvider);
      expect(mid.plannedStart, DateTime.utc(2026, 5, 10, 6));
      expect(mid.plannedEnd, DateTime.utc(2026, 5, 10, 18));

      notifier.setSpecies('red-drum');
      final final_ = container.read(planTripDraftProvider);
      expect(final_.targetSpeciesId, 'red-drum');
      expect(final_.isComplete, isTrue);
    });

    test('reset() clears every field back to defaults', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final notifier = container.read(planTripDraftProvider.notifier);
      notifier.setStation(_station);
      notifier.setSpecies('red-drum');
      notifier.reset();
      final after = container.read(planTripDraftProvider);
      expect(after.station, isNull);
      expect(after.targetSpeciesId, isNull);
      expect(after.isComplete, isFalse);
    });
  });
}
