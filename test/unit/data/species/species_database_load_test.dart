import 'package:ai_marine_engine/data/species/species_database.dart';
import 'package:flutter_test/flutter_test.dart';

/// Validates every species JSON file in `assets/species/` round-trips
/// through SpeciesRecord.fromJson cleanly. Catches malformed files,
/// schema drift after a freezed type change, missing required fields,
/// and asset-bundle registration mistakes (forgotten pubspec.yaml
/// asset entry surfaces as MissingPluginException at load time).
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SpeciesDatabase — bundled assets', () {
    test(
      'every species in the manifest loads + has the expected id',
      () async {
        final db = SpeciesDatabase.create();
        await db.loadIndex();
        expect(db.availableSpeciesIds, isNotEmpty);
        for (final id in db.availableSpeciesIds) {
          final record = await db.load(id);
          expect(
            record.id,
            id,
            reason: 'file assets/species/$id.json must declare id="$id"',
          );
        }
      },
    );

    test('loadAll returns one record per manifest entry', () async {
      final db = SpeciesDatabase.create();
      final all = await db.loadAll();
      expect(all, hasLength(db.availableSpeciesIds.length));
    });
  });
}
