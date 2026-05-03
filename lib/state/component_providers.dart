import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/sources/ndbc/ndbc_adapter.dart';
import '../data/sources/nws_forecast/nws_adapter.dart';
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
    catches: db.catchesDao,
  );
});
