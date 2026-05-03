import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/trip_plans.dart';

part 'trip_plans_dao.g.dart';

/// CRUD over the trip_plans table. v1 surfaces Drift rows directly; a
/// `TripPlan` value type lives with the Pre-Trip Planner work in Phase 7
/// once the schema for [cacheStatusJson] is settled.
@DriftAccessor(tables: [TripPlans])
class TripPlansDao extends DatabaseAccessor<AppDatabase>
    with _$TripPlansDaoMixin {
  TripPlansDao(super.db);

  Future<void> upsert(TripPlansCompanion plan) =>
      into(tripPlans).insertOnConflictUpdate(plan);

  Future<TripPlanRow?> getById(String id) =>
      (select(tripPlans)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<List<TripPlanRow>> getAll() {
    final query = select(tripPlans)
      ..orderBy([(t) => OrderingTerm.desc(t.plannedStartUtc)]);
    return query.get();
  }

  Future<int> deleteById(String id) =>
      (delete(tripPlans)..where((t) => t.id.equals(id))).go();
}
