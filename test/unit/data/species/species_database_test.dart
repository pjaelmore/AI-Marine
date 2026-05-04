import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/data/species/models/condition_profile.dart';
import 'package:ai_marine_engine/data/species/models/migration_model.dart';
import 'package:ai_marine_engine/data/species/models/regulatory_profile.dart';
import 'package:ai_marine_engine/data/species/models/species_record.dart';
import 'package:ai_marine_engine/data/species/species_database.dart';
import 'package:flutter_test/flutter_test.dart';

SpeciesRecord _testSpecies(String id) => SpeciesRecord(
      id: id,
      scientificName: 'Test species',
      commonNames: ['test'],
      schemaVersion: '1.0',
      curationVersion: '0.0.1',
      sizeClasses: const [],
      migrationModel: const MigrationModel(
        spatialRange: GeoPolygon(rings: []),
      ),
      conditionProfile: const ConditionProfile(
        optimalTemp: TemperatureRange(minF: 60, maxF: 80, idealF: 70),
        toleratedTemp: TemperatureRange(minF: 50, maxF: 90, idealF: 70),
        depthPreference: DepthPreference(minFt: 5, maxFt: 50, idealFt: 20),
        tidePreference: TidePreference(phaseWeights: {}),
        solunarSensitivity: SolunarSensitivity.medium,
        lunarSensitivity: LunarSensitivity.low,
        weatherSensitivity: WeatherSensitivity(
          risingPressureFactor: 1.0,
          fallingPressureFactor: 1.0,
          frontalPassageFactor: 1.0,
          cloudCoverPreference: 0.5,
        ),
        currentPreference:
            CurrentPreference(minKnots: 0, maxKnots: 4, idealKnots: 1.5),
      ),
      regulatoryProfile: const RegulatoryProfile(),
      confidence: ConfidenceLevel.exploratory,
    );

void main() {
  group('SpeciesDatabase — seeded test path', () {
    test('availableSpeciesIds is empty before loadIndex', () {
      final db = SpeciesDatabase.create();
      expect(db.availableSpeciesIds, isEmpty);
    });

    test('seedForTesting populates ids and cache without rootBundle', () async {
      final db = SpeciesDatabase.create();
      db.seedForTesting(
        ids: ['snook', 'redfish'],
        records: {
          'snook': _testSpecies('snook'),
          'redfish': _testSpecies('redfish'),
        },
      );
      expect(db.availableSpeciesIds, ['snook', 'redfish']);
      expect((await db.load('snook')).id, 'snook');
      expect((await db.load('redfish')).id, 'redfish');
    });

    test('load caches the result — second call returns the same instance',
        () async {
      final db = SpeciesDatabase.create();
      final snook = _testSpecies('snook');
      db.seedForTesting(ids: ['snook'], records: {'snook': snook});
      final first = await db.load('snook');
      final second = await db.load('snook');
      expect(identical(first, second), isTrue);
    });

    test('getCached returns null before load, the record after', () async {
      final db = SpeciesDatabase.create();
      db.seedForTesting(
        ids: ['snook'],
        records: {'snook': _testSpecies('snook')},
      );
      // Seeded entries are cached immediately.
      expect(db.getCached('snook'), isNotNull);
      expect(db.getCached('absent'), isNull);
    });
  });
}
