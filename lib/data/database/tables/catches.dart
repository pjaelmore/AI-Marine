import 'package:drift/drift.dart';

/// Catch log table — TDD §4.1.2.
///
/// Latitude/longitude are stored as separate REAL columns rather than a
/// single `LatLng` so SQLite can index them for radius-around-here queries
/// (the §3.8 catch-log map view and the personal-history contributor in
/// the calculator both walk this index). Conditions and engine reasoning
/// are stored as JSON-encoded TEXT — these are written once at log time,
/// read whole, and never queried by sub-fields, so opening up to a
/// schema-style decomposition would cost migrations without saving reads.
///
/// The Drift data class is named `CatchRow` (not the default `Catch`)
/// because `catch` is a reserved word in modern Dart pattern matching.
@DataClassName('CatchRow')
class Catches extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text().nullable()();
  IntColumn get timestampUtc => integer()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  TextColumn get locationSource => text()();

  TextColumn get speciesId => text()();
  TextColumn get sizeClassId => text().nullable()();
  RealColumn get lengthInches => real().nullable()();
  RealColumn get weightPounds => real().nullable()();
  TextColumn get baitOrLure => text().nullable()();
  BoolColumn get released => boolean().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get photoLocalPath => text().nullable()();
  TextColumn get recommendationPinId => text().nullable()();

  TextColumn get conditionsJson => text()();
  RealColumn get engineScoreAtCatch => real().nullable()();
  TextColumn get engineReasoningJson => text().nullable()();

  IntColumn get createdAtUtc => integer()();
  IntColumn get updatedAtUtc => integer()();
  TextColumn get syncStatus => text().withDefault(const Constant('local'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
