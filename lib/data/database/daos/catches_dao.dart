import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../core/types/catch_record.dart';
import '../../../core/types/lat_lng.dart';
import '../../../core/types/score_result.dart';
import '../app_database.dart';
import '../tables/catches.dart';

part 'catches_dao.g.dart';

/// CRUD over the catches table. Translates between the Drift row shape
/// (primitives + JSON-encoded condition snapshots) and the [CatchRecord]
/// value type (TDD §3.4).
@DriftAccessor(tables: [Catches])
class CatchesDao extends DatabaseAccessor<AppDatabase> with _$CatchesDaoMixin {
  CatchesDao(super.db);

  /// Inserts or replaces a catch record by id.
  Future<void> upsert(CatchRecord record) =>
      into(catches).insertOnConflictUpdate(_toCompanion(record));

  /// Returns the catch with [id], or `null` if none exists.
  Future<CatchRecord?> getById(String id) async {
    final row = await (select(catches)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _fromRow(row);
  }

  /// All catches, newest first.
  Future<List<CatchRecord>> getAll() async {
    final query = select(catches)
      ..orderBy([(t) => OrderingTerm.desc(t.timestampUtc)]);
    return (await query.get()).map(_fromRow).toList();
  }

  /// Live stream of all catches, newest first; emits whenever the table
  /// changes. Drives `catchStream` per TDD §3.8 DoD.
  Stream<List<CatchRecord>> watchAll() {
    final query = select(catches)
      ..orderBy([(t) => OrderingTerm.desc(t.timestampUtc)]);
    return query.watch().map((rows) => rows.map(_fromRow).toList());
  }

  /// Deletes the catch with [id]; returns the number of rows removed (0 or 1).
  Future<int> deleteById(String id) =>
      (delete(catches)..where((t) => t.id.equals(id))).go();
}

CatchesCompanion _toCompanion(CatchRecord r) => CatchesCompanion(
      id: Value(r.id),
      userId: Value(r.userId),
      timestampUtc: Value(r.timestamp.toUtc().millisecondsSinceEpoch),
      latitude: Value(r.location.latitude),
      longitude: Value(r.location.longitude),
      locationSource: Value(r.locationSource.name),
      speciesId: Value(r.speciesId),
      sizeClassId: Value(r.sizeClassId),
      lengthInches: Value(r.lengthInches),
      weightPounds: Value(r.weightPounds),
      baitOrLure: Value(r.baitOrLure),
      released: Value(r.released),
      notes: Value(r.notes),
      photoLocalPath: Value(r.photoLocalPath),
      recommendationPinId: Value(r.recommendationPinId),
      conditionsJson: Value(jsonEncode(r.conditions.toJson())),
      engineScoreAtCatch: Value(r.engineScoreAtCatch),
      engineReasoningJson: Value(
        r.engineReasoningAtCatch == null
            ? null
            : jsonEncode(r.engineReasoningAtCatch!.toJson()),
      ),
      createdAtUtc: Value(r.createdAt.toUtc().millisecondsSinceEpoch),
      updatedAtUtc: Value(r.updatedAt.toUtc().millisecondsSinceEpoch),
    );

CatchRecord _fromRow(CatchRow row) => CatchRecord(
      id: row.id,
      // The TDD §4.1.2 SQL allows user_id to be NULL for forward-compat with
      // anonymous local catches; v1 always supplies a value, so an empty
      // string here means a corrupted row (defensive default — let it
      // surface visually rather than throw on read).
      userId: row.userId ?? '',
      timestamp:
          DateTime.fromMillisecondsSinceEpoch(row.timestampUtc, isUtc: true),
      location: LatLng(latitude: row.latitude, longitude: row.longitude),
      locationSource: LocationSource.values.byName(row.locationSource),
      speciesId: row.speciesId,
      sizeClassId: row.sizeClassId,
      lengthInches: row.lengthInches,
      weightPounds: row.weightPounds,
      baitOrLure: row.baitOrLure,
      released: row.released,
      notes: row.notes,
      photoLocalPath: row.photoLocalPath,
      recommendationPinId: row.recommendationPinId,
      conditions: ConditionSnapshot.fromJson(
        jsonDecode(row.conditionsJson) as Map<String, dynamic>,
      ),
      engineScoreAtCatch: row.engineScoreAtCatch,
      engineReasoningAtCatch: row.engineReasoningJson == null
          ? null
          : ReasoningBreakdown.fromJson(
              jsonDecode(row.engineReasoningJson!) as Map<String, dynamic>,
            ),
      createdAt:
          DateTime.fromMillisecondsSinceEpoch(row.createdAtUtc, isUtc: true),
      updatedAt:
          DateTime.fromMillisecondsSinceEpoch(row.updatedAtUtc, isUtc: true),
    );
