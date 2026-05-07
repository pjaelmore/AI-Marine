import 'dart:convert';

import 'package:drift/drift.dart';

import '../../core/types/lat_lng.dart';
import '../../core/types/trip_plan.dart';
import 'app_database.dart';
import 'daos/trip_plans_dao.dart';

/// Reads and writes [TripPlan] values through [TripPlansDao].
///
/// The DAO surfaces raw Drift rows (split bounds into 4 doubles, time
/// as epoch-ms, cacheStatus as a JSON blob); this repository wraps
/// those primitives in proper [LatLngBounds] / `DateTime` /
/// [TripCacheStatus] values so callers (the UI flow + trip providers)
/// don't need to know the storage shape.
class TripPlansRepository {
  TripPlansRepository(this._dao);

  final TripPlansDao _dao;

  /// Persist a trip plan (insert or update by id).
  Future<void> save(TripPlan plan) {
    return _dao.upsert(_toCompanion(plan));
  }

  /// Fetch a trip by id, or null if missing.
  Future<TripPlan?> getById(String id) async {
    final row = await _dao.getById(id);
    return row == null ? null : _fromRow(row);
  }

  /// All saved trips, ordered by planned-start descending (most recent
  /// upcoming or in-progress trip first).
  Future<List<TripPlan>> getAll() async {
    final rows = await _dao.getAll();
    return rows.map(_fromRow).toList(growable: false);
  }

  /// Remove a trip by id. Returns true when a row was actually
  /// deleted.
  Future<bool> delete(String id) async {
    final removed = await _dao.deleteById(id);
    return removed > 0;
  }

  // ────────────────────────────────────────────────────────────────
  // Row ↔ value conversion
  // ────────────────────────────────────────────────────────────────

  TripPlansCompanion _toCompanion(TripPlan plan) {
    return TripPlansCompanion(
      id: Value(plan.id),
      userId: Value(plan.userId),
      name: Value(plan.name),
      boundsSwLat: Value(plan.bounds.southwest.latitude),
      boundsSwLon: Value(plan.bounds.southwest.longitude),
      boundsNeLat: Value(plan.bounds.northeast.latitude),
      boundsNeLon: Value(plan.bounds.northeast.longitude),
      plannedStartUtc: Value(plan.plannedStart.toUtc().millisecondsSinceEpoch),
      plannedEndUtc: Value(plan.plannedEnd.toUtc().millisecondsSinceEpoch),
      targetSpeciesId: Value(plan.targetSpeciesId),
      cacheStatusJson: Value(jsonEncode(plan.cacheStatus.toJson())),
      createdAtUtc: Value(plan.createdAt.toUtc().millisecondsSinceEpoch),
    );
  }

  TripPlan _fromRow(TripPlanRow row) {
    return TripPlan(
      id: row.id,
      userId: row.userId,
      name: row.name,
      bounds: LatLngBounds(
        southwest:
            LatLng(latitude: row.boundsSwLat, longitude: row.boundsSwLon),
        northeast:
            LatLng(latitude: row.boundsNeLat, longitude: row.boundsNeLon),
      ),
      plannedStart:
          DateTime.fromMillisecondsSinceEpoch(row.plannedStartUtc, isUtc: true),
      plannedEnd:
          DateTime.fromMillisecondsSinceEpoch(row.plannedEndUtc, isUtc: true),
      targetSpeciesId: row.targetSpeciesId,
      cacheStatus: _decodeCacheStatus(row.cacheStatusJson),
      createdAt:
          DateTime.fromMillisecondsSinceEpoch(row.createdAtUtc, isUtc: true),
    );
  }

  /// Defensively decode the cache-status blob — older rows might
  /// predate this slice's schema (e.g. the integration test seeds
  /// `{"tiles":0,"forecasts":0}`). Unknown keys are ignored, missing
  /// keys take their freezed defaults.
  TripCacheStatus _decodeCacheStatus(String json) {
    if (json.isEmpty) return const TripCacheStatus();
    try {
      final map = jsonDecode(json);
      if (map is! Map<String, dynamic>) return const TripCacheStatus();
      return TripCacheStatus.fromJson(map);
    } on FormatException {
      return const TripCacheStatus();
    }
  }
}
