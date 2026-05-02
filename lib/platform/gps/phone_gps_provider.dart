import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

/// Terminal availability state for the device GPS.
///
/// Collapses geolocator's permission and service-status APIs into a single
/// enum so callers can switch on a clear outcome rather than chaining
/// conditionals against `LocationPermission` and `isLocationServiceEnabled`.
enum GpsAvailability {
  /// Permission granted and location services on — streaming may proceed.
  available,

  /// User has not granted permission this session; the next prompt may help.
  permissionDenied,

  /// User permanently denied; only a system Settings trip will recover.
  permissionDeniedForever,

  /// System location services are off; the user must enable them globally.
  servicesDisabled,
}

/// Thin wrapper over the `geolocator` package.
///
/// Phase 1 scope (Implementation Guide §2.2.2 task 8): permission gate plus
/// continuous position stream sufficient to render a vessel dot on the chart.
/// Phase 2 evolves into the `VesselPosition` source pipeline alongside the
/// NMEA 2000 bridge per TDD §9.2.2.
class PhoneGpsProvider {
  const PhoneGpsProvider();

  /// Returns the current GPS availability state, requesting permission if it
  /// is currently `denied` (a no-op if it is `deniedForever` or `granted`).
  Future<GpsAvailability> ensureAvailable() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      return GpsAvailability.servicesDisabled;
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return mapPermission(permission);
  }

  /// Best-effort cached position. Returns `null` if no fix has been recorded
  /// since boot.
  Future<Position?> lastKnown() => Geolocator.getLastKnownPosition();

  /// Live position updates.
  ///
  /// The 5-metre default `distanceFilter` keeps the stream quiet at anchor
  /// while still emitting promptly when underway. Increase the filter to
  /// reduce CPU / battery on long passages where chart-position precision
  /// matters less than endurance.
  Stream<Position> positionStream({
    LocationAccuracy accuracy = LocationAccuracy.best,
    int distanceFilterMeters = 5,
  }) {
    return Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: accuracy,
        distanceFilter: distanceFilterMeters,
      ),
    );
  }
}

/// Maps geolocator's `LocationPermission` to our [GpsAvailability].
///
/// Exposed for testing because mocking the static `Geolocator.*` surface
/// adds more wiring than it pays back; the meaningful logic is the mapping.
@visibleForTesting
GpsAvailability mapPermission(LocationPermission p) => switch (p) {
      LocationPermission.always ||
      LocationPermission.whileInUse =>
        GpsAvailability.available,
      LocationPermission.deniedForever =>
        GpsAvailability.permissionDeniedForever,
      LocationPermission.denied ||
      LocationPermission.unableToDetermine =>
        GpsAvailability.permissionDenied,
    };
