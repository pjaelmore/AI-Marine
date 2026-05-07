import 'package:ai_marine_engine/state/osm_ramps_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('osmRampsProvider', () {
    test('parses the bundled assets/osm_ramps.json into BoatRampRecords',
        () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final ramps = await container.read(osmRampsProvider.future);
      expect(ramps, isNotEmpty);
      // Every record must have valid coords inside the FL bbox; the
      // refresh script enforces this and the loader should not emit
      // synthetic blanks.
      for (final r in ramps) {
        expect(r.id, isNotEmpty);
        expect(r.lat, inInclusiveRange(22.0, 32.0));
        expect(r.lon, inInclusiveRange(-92.0, -76.0));
      }
    });

    test('private ramps were dropped at refresh time', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final ramps = await container.read(osmRampsProvider.future);
      // The refresh script filters access==private upstream — none
      // should reach the bundled snapshot.
      expect(ramps.where((r) => r.access == 'private'), isEmpty);
    });
  });
}
