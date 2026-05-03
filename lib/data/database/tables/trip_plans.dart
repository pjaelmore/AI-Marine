import 'package:drift/drift.dart';

/// Saved trip plans with per-plan cache status — TDD §4.1.3.
///
/// `boundsSwLat`/`boundsSwLon`/`boundsNeLat`/`boundsNeLon` are stored as
/// four primitives (mirroring the SQL DDL) rather than a serialised
/// `LatLngBounds` so per-coordinate range queries remain possible. The
/// per-plan cache status is JSON-encoded TEXT — its structure is set by
/// the Pre-Trip Planner (Phase 7), so v1 keeps the schema-level shape
/// generic to avoid migrations when that phase nails down the keys.
@DataClassName('TripPlanRow')
class TripPlans extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text().nullable()();
  TextColumn get name => text()();
  RealColumn get boundsSwLat => real()();
  RealColumn get boundsSwLon => real()();
  RealColumn get boundsNeLat => real()();
  RealColumn get boundsNeLon => real()();
  IntColumn get plannedStartUtc => integer()();
  IntColumn get plannedEndUtc => integer()();
  TextColumn get targetSpeciesId => text()();
  TextColumn get cacheStatusJson => text()();
  IntColumn get createdAtUtc => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
