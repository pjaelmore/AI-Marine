import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/cache/cache_manager.dart';
import '../data/cache/cold_cache.dart';
import '../data/cache/eviction_service.dart';
import '../data/cache/hot_cache.dart';
import '../data/cache/live_sensor_buffer.dart';
import '../data/cache/warm_cache.dart';
import '../data/sources/ndbc/buoy_station.dart';
import '../data/sources/ndbc/ndbc_adapter.dart';
import '../data/sources/nws_forecast/nws_adapter.dart';
import '../data/sources/open_meteo_marine/open_meteo_marine_adapter.dart';
import '../data/sources/open_topo_data/open_topo_data_adapter.dart';
import '../data/sources/solunar/solunar_adapter.dart';
import '../data/sources/tides_currents/tides_currents_adapter.dart';
import '../services/conditions/conditions_service.dart';
import '../services/conditions/conditions_service_impl.dart';
import 'infrastructure_providers.dart';

/// NDBC adapter with its bundled station list pre-loaded — TDD §9.1.
final ndbcAdapterProvider = FutureProvider<NdbcAdapter>((ref) async {
  final adapter = NdbcAdapter(http: ref.watch(dioProvider));
  await adapter.loadStations();
  return adapter;
});

/// Loaded NDBC stations from the bundled asset, surfaced as a
/// list for the chart marker layer. Composes
/// [ndbcAdapterProvider] so the adapter only loads once even when
/// both the scoring path and the marker layer watch stations.
final ndbcStationsProvider = FutureProvider<List<BuoyStation>>((ref) async {
  final adapter = await ref.watch(ndbcAdapterProvider.future);
  return adapter.stations;
});

/// Tides & Currents adapter with its bundled station list pre-loaded.
final tidesAndCurrentsAdapterProvider =
    FutureProvider<TidesAndCurrentsAdapter>((ref) async {
  final adapter = TidesAndCurrentsAdapter(http: ref.watch(dioProvider));
  await adapter.loadStations();
  return adapter;
});

/// NWS forecast adapter — no bundled assets, no async setup.
final nwsAdapterProvider = Provider<NwsAdapter>((ref) {
  return NwsAdapter(http: ref.watch(dioProvider));
});

/// Solunar adapter — pure local computation.
final solunarAdapterProvider = Provider<SolunarAdapter>((ref) {
  return SolunarAdapter();
});

/// Open-Meteo Marine adapter — model-derived SST fallback when no NDBC
/// buoy with a `WTMP` reading is in range. No bundled assets, no async
/// setup.
final openMeteoMarineAdapterProvider = Provider<OpenMeteoMarineAdapter>((ref) {
  return OpenMeteoMarineAdapter(http: ref.watch(dioProvider));
});

/// OpenTopoData GEBCO bathymetry adapter — global ocean depth lookup
/// so the depth modifier can fire against species `depthPreference`
/// profiles. Static-data source; no auth.
final openTopoDataAdapterProvider = Provider<OpenTopoDataAdapter>((ref) {
  return OpenTopoDataAdapter(http: ref.watch(dioProvider));
});

/// Four-tier cache manager (TDD §2.1.4). Composed once per app session.
/// Live and hot tiers are in-memory and disposed with the provider; warm
/// and cold are Drift-backed and survive restart.
final cacheManagerProvider = Provider<CacheManager>((ref) {
  final db = ref.watch(databaseProvider);
  return CacheManager(
    live: LiveSensorBuffer(),
    hot: HotCache(),
    warm: WarmCache(dao: db.conditionsCacheDao),
    cold: ColdCache(
      tideDao: db.tideCacheDao,
      forecastDao: db.forecastCacheDao,
    ),
  );
});

/// Drives TTL-expired sweeps across warm + cold tiers. Phase 6 will
/// wire this to lifecycle observers (foreground / background) and a
/// periodic timer; for now it's exposed for callers that want to
/// trigger a pass on demand.
final evictionServiceProvider = Provider<EvictionService>((ref) {
  final db = ref.watch(databaseProvider);
  return EvictionService(
    warm: WarmCache(dao: db.conditionsCacheDao),
    cold: ColdCache(
      tideDao: db.tideCacheDao,
      forecastDao: db.forecastCacheDao,
    ),
  );
});

/// Composite Conditions Service — composes the four source adapters.
/// Async because the NDBC and Tides & Currents station lists load lazily
/// via [rootBundle].
final conditionsServiceProvider = FutureProvider<ConditionsService>((
  ref,
) async {
  final ndbc = await ref.watch(ndbcAdapterProvider.future);
  final tides = await ref.watch(tidesAndCurrentsAdapterProvider.future);
  final nws = ref.watch(nwsAdapterProvider);
  final solunar = ref.watch(solunarAdapterProvider);
  final db = ref.watch(databaseProvider);
  return ConditionsServiceImpl(
    ndbc: ndbc,
    tides: tides,
    nws: nws,
    solunar: solunar,
    openMeteo: ref.watch(openMeteoMarineAdapterProvider),
    bathymetry: ref.watch(openTopoDataAdapterProvider),
    catches: db.catchesDao,
    cache: ref.watch(cacheManagerProvider),
  );
});
