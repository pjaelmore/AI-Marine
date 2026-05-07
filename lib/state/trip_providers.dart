import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/types/trip_plan.dart';
import '../data/database/trip_plans_repository.dart';
import 'infrastructure_providers.dart';

/// Repository singleton wrapping the Drift trip-plans DAO.
final tripPlansRepositoryProvider = Provider<TripPlansRepository>((ref) {
  return TripPlansRepository(ref.watch(databaseProvider).tripPlansDao);
});

/// Auto-disposes itself per resolution so saving / deleting a trip
/// invalidates dependent watchers.
final savedTripsProvider = FutureProvider<List<TripPlan>>((ref) async {
  return ref.watch(tripPlansRepositoryProvider).getAll();
});

/// Identifier of the trip the user is "currently executing" — null
/// means no active trip (the chart shows the regular live overlay).
/// Setting this id is how 13a.2's UI flow signals "make this saved
/// trip the one the chart should focus on" once the user finishes
/// planning.
final activeTripIdProvider = StateProvider<String?>((ref) => null);

/// The active trip resolved from [activeTripIdProvider] + the saved
/// trip list. Null when no id is set, when the saved list is still
/// loading, or when the id points at a trip that no longer exists
/// (e.g. user deleted it after activating).
final activeTripProvider = Provider<TripPlan?>((ref) {
  final id = ref.watch(activeTripIdProvider);
  if (id == null) return null;
  final saved = ref.watch(savedTripsProvider).valueOrNull;
  if (saved == null) return null;
  for (final t in saved) {
    if (t.id == id) return t;
  }
  return null;
});
