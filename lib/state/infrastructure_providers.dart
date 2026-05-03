import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database/app_database.dart';

/// Singleton on-device database. Opens a file-backed SQLite database via
/// drift_flutter the first time it's read; closes when the provider is
/// disposed (app shutdown, or a `ProviderContainer.dispose()` in tests).
///
/// Override in tests with `AppDatabase.forTesting(NativeDatabase.memory())`
/// via `ProviderContainer(overrides: [databaseProvider.overrideWithValue(...)])`.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});
