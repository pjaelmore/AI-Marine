import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../platform/gps/phone_gps_provider.dart';

/// Shared singleton of the platform GPS wrapper.
final phoneGpsProvider =
    Provider<PhoneGpsProvider>((ref) => const PhoneGpsProvider());

/// Streams device GPS position once the user has granted permission.
///
/// Phase 1 placeholder for the full TDD §9.2.2 `vesselPositionProvider`:
/// Phase 2 swaps in NMEA 2000 fallback and the richer `VesselPosition`
/// value type. Until then, the provider closes the stream silently when
/// permission is denied or location services are off — no banner, no
/// error surfaced; the chart simply renders without a vessel dot.
final currentPositionProvider = StreamProvider<Position>((ref) async* {
  final gps = ref.watch(phoneGpsProvider);
  final state = await gps.ensureAvailable();
  if (state != GpsAvailability.available) {
    return;
  }
  yield* gps.positionStream();
});
