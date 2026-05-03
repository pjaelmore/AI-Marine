import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'daos/catches_dao.dart';
import 'daos/chart_tile_cache_dao.dart';
import 'daos/conditions_cache_dao.dart';
import 'daos/forecast_cache_dao.dart';
import 'daos/score_cache_dao.dart';
import 'daos/sync_queue_dao.dart';
import 'daos/tide_cache_dao.dart';
import 'daos/trip_plans_dao.dart';
import 'daos/user_preferences_dao.dart';
import 'tables/catches.dart';
import 'tables/chart_tile_cache.dart';
import 'tables/conditions_cache.dart';
import 'tables/forecast_cache.dart';
import 'tables/score_cache.dart';
import 'tables/sync_queue.dart';
import 'tables/tide_cache.dart';
import 'tables/trip_plans.dart';
import 'tables/user_preferences.dart';

part 'app_database.g.dart';

/// Root on-device database. Mirrors TDD §4.1.
///
/// v1 ships at schema version 1 — there are no prior versions to migrate
/// from. The TDD references a §4.1.11 migration system that does not
/// exist in the document; the practical interpretation is the standard
/// Drift [MigrationStrategy] pattern with `onCreate` running the table
/// DDL and the index statements specified per table in §4.1.2 onward.
/// `onUpgrade` is in place for future schema bumps.
@DriftDatabase(
  tables: [
    Catches,
    TripPlans,
    UserPreferencesTable,
    SyncQueue,
    ConditionsCache,
    ScoreCache,
    ChartTileCache,
    ForecastCache,
    TideCache,
  ],
  daos: [
    CatchesDao,
    TripPlansDao,
    UserPreferencesDao,
    SyncQueueDao,
    ConditionsCacheDao,
    ScoreCacheDao,
    ChartTileCacheDao,
    ForecastCacheDao,
    TideCacheDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  /// Production constructor — opens a file-backed SQLite database in the
  /// app documents directory via drift_flutter.
  AppDatabase() : super(_openConnection());

  /// Test/injection constructor — accepts an arbitrary [QueryExecutor]
  /// (typically `NativeDatabase.memory()`).
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          // Indexes from TDD §4.1.2. Drift does not declare these in the
          // table classes; we issue the SQL once at create time. Names
          // match the spec verbatim so a database opened by another tool
          // sees the same names.
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_catches_timestamp '
            'ON catches(timestamp_utc DESC)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_catches_species '
            'ON catches(species_id, timestamp_utc DESC)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_catches_location '
            'ON catches(latitude, longitude)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_catches_sync '
            "ON catches(sync_status) WHERE sync_status != 'synced'",
          );
          // §4.1.4 conditions_cache indexes — freshness and LRU eviction.
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_conditions_valid '
            'ON conditions_cache(valid_until_utc)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_conditions_lru '
            'ON conditions_cache(last_accessed_utc)',
          );
        },
      );
}

QueryExecutor _openConnection() {
  return driftDatabase(name: 'ai_marine');
}
