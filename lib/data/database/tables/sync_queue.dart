import 'package:drift/drift.dart';

/// Pending writes for backend sync — TDD §4.1.5 (v1.5+).
///
/// Provisioned in v1 so the catches DAO's `sync_status='local'` rows have
/// a queue to drain into when sync ships. v1 does not enqueue; the table
/// stays empty.
@DataClassName('SyncQueueEntry')
class SyncQueue extends Table {
  IntColumn get id => integer().autoIncrement()();
  // Dart getter avoids the reserved `Table.tableName` override;
  // SQL column name still matches TDD §4.1.5.
  TextColumn get targetTable => text().named('table_name')();
  TextColumn get recordId => text()();
  TextColumn get operation => text()();
  TextColumn get payloadJson => text()();
  IntColumn get enqueuedAtUtc => integer()();
  IntColumn get attemptCount => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();
}
