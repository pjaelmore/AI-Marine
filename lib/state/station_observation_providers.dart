import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/types/condition_result.dart';
import '../data/sources/ndbc/buoy_observation.dart';
import '../data/sources/ndbc/buoy_station.dart';
import 'component_providers.dart';
import 'engine_providers.dart';

/// Live observation for a single NDBC station, fetched on demand when
/// the user taps that buoy on the chart. Family-keyed by [BuoyStation]
/// (record-equal stations resolve to the same cached future) and
/// auto-disposed when no widget is watching so dismissed station info
/// cards don't pin futures.
///
/// Pulls through [NdbcAdapter.fetch] using the station's own
/// coordinates — `interpolationDistanceNm` ends up at 0 since the
/// query location IS the station, and confidence is at 1.0.
final stationObservationProvider = FutureProvider.autoDispose
    .family<ConditionResult<BuoyObservation>, BuoyStation>(
        (ref, station) async {
  final adapter = await ref.watch(ndbcAdapterProvider.future);
  final time = ref.watch(selectedTimeProvider);
  return adapter.fetch(station.location, time);
});
