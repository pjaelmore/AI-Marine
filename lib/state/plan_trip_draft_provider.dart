import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/sources/ndbc/buoy_station.dart';

/// In-progress fields the user has filled in while stepping through
/// the "Plan a trip" wizard (slice 13a.2). The PlanTripScreen
/// stepper writes to this notifier as the user moves between steps;
/// the final "Save" handler reads it once and persists a `TripPlan`
/// via [TripPlansRepository].
///
/// The trip's launch anchor is an NDBC buoy station — picking one of
/// the bundled stations gives the user a known saltwater reference
/// point with id + description, and the score grid + tile downloader
/// in later slices key off `station.location` for the trip bbox.
///
/// Auto-disposes when the planner screen is gone so opening the
/// wizard again starts from a clean draft.
class PlanTripDraft {
  const PlanTripDraft({
    this.station,
    this.plannedStart,
    this.plannedEnd,
    this.targetSpeciesId,
    this.name,
  });

  final BuoyStation? station;
  final DateTime? plannedStart;
  final DateTime? plannedEnd;
  final String? targetSpeciesId;
  final String? name;

  /// Whether every required field has been chosen — gates the
  /// "Save" button on the review step.
  bool get isComplete =>
      station != null &&
      plannedStart != null &&
      plannedEnd != null &&
      targetSpeciesId != null &&
      targetSpeciesId!.isNotEmpty;

  PlanTripDraft copyWith({
    BuoyStation? station,
    DateTime? plannedStart,
    DateTime? plannedEnd,
    String? targetSpeciesId,
    String? name,
  }) {
    return PlanTripDraft(
      station: station ?? this.station,
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

  void setStation(BuoyStation station) {
    state = state.copyWith(station: station);
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
