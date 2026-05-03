import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/sync_queue.dart';

part 'sync_queue_dao.g.dart';

/// Pending-write queue DAO. v1 ships unused; the catches/trip_plans DAOs
/// don't enqueue anything yet — that wiring lands with the v1.5+ sync
/// work specified in TDD §4.3.
@DriftAccessor(tables: [SyncQueue])
class SyncQueueDao extends DatabaseAccessor<AppDatabase>
    with _$SyncQueueDaoMixin {
  SyncQueueDao(super.db);

  Future<int> enqueue(SyncQueueCompanion entry) =>
      into(syncQueue).insert(entry);

  /// Pending entries (those that haven't been removed by a successful
  /// sync), oldest first so retries respect insertion order.
  Future<List<SyncQueueEntry>> pending() {
    final query = select(syncQueue)
      ..orderBy([(t) => OrderingTerm.asc(t.enqueuedAtUtc)]);
    return query.get();
  }

  /// Removes an entry by primary key — call after a successful upload.
  Future<int> dequeue(int id) =>
      (delete(syncQueue)..where((t) => t.id.equals(id))).go();
}
