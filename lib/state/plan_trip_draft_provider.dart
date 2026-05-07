import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/sources/osm/boat_ramp_record.dart';

/// In-progress fields the user has filled in while stepping through
/// the "Plan a trip" wizard (slice 13a.2). The PlanTripScreen
/// stepper writes to this notifier as the user moves between steps;
/// the final "Save" handler reads it once and persists a `TripPlan`
/// via [TripPlansRepository].
///
/// Auto-disposes when the planner screen is gone so opening the
/// wizard again starts from a clean draft.
class PlanTripDraft {
  const PlanTripDraft({
    this.ramp,
    this.plannedStart,
    this.plannedEnd,
    this.targetSpeciesId,
    this.name,
  });

  final BoatRampRecord? ramp;
  final DateTime? plannedStart;
  final DateTime? plannedEnd;
  final String? targetSpeciesId;
  final String? name;

  /// Whether every required field has been chosen — gates the
  /// "Save" button on the review step.
  bool get isComplete =>
      ramp != null &&
      plannedStart != null &&
      plannedEnd != null &&
      targetSpeciesId != null &&
      targetSpeciesId!.isNotEmpty;

  PlanTripDraft copyWith({
    BoatRampRecord? ramp,
    DateTime? plannedStart,
    DateTime? plannedEnd,
    String? targetSpeciesId,
    String? name,
  }) {
    return PlanTripDraft(
      ramp: ramp ?? this.ramp,
      plannedStart: plannedStart ?? this.plannedStart,
      plannedEnd: plannedEnd ?? this.plannedEnd,
      targetSpeciesId: targetSpeciesId ?? this.targetSpeciesId,
      name: name ?? this.name,
    );
  }
}

class PlanTripDraftNotifier extends AutoDisposeNotifier<PlanTripDraft> {
  @override
  PlanTripDraft build() => const PlanTripDraft();

  void setRamp(BoatRampRecord ramp) {
    state = state.copyWith(ramp: ramp);
  }

  void setTimeWindow(DateTime start, DateTime end) {
    state = state.copyWith(plannedStart: start, plannedEnd: end);
  }

  void setSpecies(String id) {
    state = state.copyWith(targetSpeciesId: id);
  }

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  void reset() {
    state = const PlanTripDraft();
  }
}

final planTripDraftProvider =
    NotifierProvider.autoDispose<PlanTripDraftNotifier, PlanTripDraft>(
  PlanTripDraftNotifier.new,
);
