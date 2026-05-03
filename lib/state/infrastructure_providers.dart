import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database/app_database.dart';
import '../data/sources/dio_setup.dart';
import '../data/sources/source_registry.dart';

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

/// Singleton Dio HTTP client shared by every NOAA adapter. Configured with
/// the retry policy from TDD §5.8 and a polite User-Agent.
///
/// Override in tests with `DioForNative()` plus `DioAdapter` from
/// `http_mock_adapter`, or any other Dio with a stub network adapter.
final dioProvider = Provider<Dio>((ref) {
  final dio = buildDio();
  ref.onDispose(() => dio.close(force: true));
  return dio;
});

/// Singleton [SourceRegistry] populated at app startup with every
/// concrete adapter. Adapters land slice-by-slice; for now the registry
/// is empty and `resolve` returns `unavailable` for every type.
final sourceRegistryProvider = Provider<SourceRegistry>((ref) {
  return SourceRegistry();
  // Adapter registration lands as each concrete adapter ships; e.g.:
  //   ..register(NdbcAdapter(ref.watch(dioProvider)))
  //   ..register(TidesAndCurrentsAdapter(ref.watch(dioProvider)))
});
