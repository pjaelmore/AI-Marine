import 'package:ai_marine_engine/platform/gps/phone_gps_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  group('mapPermission', () {
    test('whileInUse and always count as available', () {
      expect(
        mapPermission(LocationPermission.whileInUse),
        GpsAvailability.available,
      );
      expect(
        mapPermission(LocationPermission.always),
        GpsAvailability.available,
      );
    });

    test('denied is recoverable on next prompt', () {
      expect(
        mapPermission(LocationPermission.denied),
        GpsAvailability.permissionDenied,
      );
    });

    test('deniedForever is the only state that needs Settings', () {
      expect(
        mapPermission(LocationPermission.deniedForever),
        GpsAvailability.permissionDeniedForever,
      );
    });

    test('unableToDetermine is treated like denied so a prompt can resolve it',
        () {
      expect(
        mapPermission(LocationPermission.unableToDetermine),
        GpsAvailability.permissionDenied,
      );
    });
  });
}
