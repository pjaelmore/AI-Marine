import 'package:ai_marine_engine/core/types/catch_record.dart';
import 'package:ai_marine_engine/core/types/condition_result.dart';
import 'package:ai_marine_engine/core/types/conditions.dart';
import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/data/species/models/condition_profile.dart';
import 'package:ai_marine_engine/data/species/models/migration_model.dart';
import 'package:ai_marine_engine/data/species/models/regulatory_profile.dart';
import 'package:ai_marine_engine/data/species/models/species_record.dart';
import 'package:ai_marine_engine/data/species/species_database.dart';
import 'package:ai_marine_engine/services/conditions/conditions_service.dart';
import 'package:ai_marine_engine/state/component_providers.dart';
import 'package:ai_marine_engine/state/engine_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// Conditions stub returning everything unavailable — enough to exercise
/// the calculator's "no conditions, base only" path without binding any
/// real adapters.
class _NullConditions implements ConditionsService {
  @override
  Future<ConditionResult<double>> getWaterTemp(LatLng loc, DateTime t) async =>
      ConditionResult<double>.unavailable(value: double.nan, time: t);
  @override
  Future<ConditionResult<TideState>> getTideState(
    LatLng loc,
    DateTime t,
  ) async =>
      ConditionResult<TideState>.unavailable(
        value: const TideState(
          phase: TidePhase.slackHigh,
          toNextChange: Duration.zero,
        ),
        time: t,
      );
  @override
  Future<ConditionResult<WindVector>> getWind(LatLng loc, DateTime t) async =>
      ConditionResult<WindVector>.unavailable(
        value: const WindVector(speedKnots: 0, directionDegrees: 0),
        time: t,
      );
  @override
  Future<ConditionResult<BarometricState>> getBarometric(
    LatLng loc,
    DateTime t,
  ) async =>
      ConditionResult<BarometricState>.unavailable(
        value: const BarometricState(
          pressureMillibars: 0,
          trend: BarometricTrend.stable,
          rateOfChangeMillibarsPerHour: 0,
        ),
        time: t,
      );
  @override
  Future<ConditionResult<SolunarState>> getSolunar(
    LatLng loc,
    DateTime t,
  ) async =>
      ConditionResult<SolunarState>.unavailable(
        value: const SolunarState(
          sunAltitudeDegrees: 0,
          sunAzimuthDegrees: 0,
          moonPhase: MoonPhase.newMoon,
          moonIlluminationFraction: 0,
        ),
        time: t,
      );
  @override
  Future<ConditionResult<double>> getDepth(LatLng loc) async =>
      ConditionResult<double>.unavailable(
        value: double.nan,
        time: DateTime.now().toUtc(),
      );
  @override
  Future<ConditionResult<StructureInfo>> getStructure(LatLng loc) async =>
      ConditionResult<StructureInfo>.unavailable(
        value: const StructureInfo(type: StructureType.unknown),
        time: DateTime.now().toUtc(),
      );
  @override
  Future<List<CatchRecord>> getRecentCatches(
    LatLng loc,
    double radiusNm, {
    String? speciesId,
    DateTime? since,
  }) async =>
      const [];
  @override
  Future<ConditionResult<CurrentVector>> getCurrent(
    LatLng loc,
    DateTime t, {
    double? depthMeters,
  }) =>
      throw UnimplementedError();
  @override
  Future<ConditionResult<WaveState>> getWaves(LatLng loc, DateTime t) =>
      throw UnimplementedError();
}

GeoPolygon _box() => const GeoPolygon(
      rings: [
        [
          LatLng(latitude: 24, longitude: -88),
          LatLng(latitude: 31, longitude: -88),
          LatLng(latitude: 31, longitude: -78),
          LatLng(latitude: 24, longitude: -78),
          LatLng(latitude: 24, longitude: -88),
        ],
      ],
    );

SpeciesRecord _testSpecies(String id) => SpeciesRecord(
      id: id,
      scientificName: 'Test',
      commonNames: [id],
      schemaVersion: '1.0',
      curationVersion: '0.0.1',
      sizeClasses: const [],
      migrationModel: MigrationModel(
        spatialRange: _box(),
        regionalCurves: [
          RegionalPresenceCurve(
            regionId: 'fl',
            regionPolygon: _box(),
            weeklyValues: List<double>.filled(52, 1.0),
          ),
        ],
      ),
      conditionProfile: const ConditionProfile(
        optimalTemp: TemperatureRange(minF: 60, maxF: 80, idealF: 70),
        toleratedTemp: TemperatureRange(minF: 50, maxF: 90, idealF: 70),
        depthPreference: DepthPreference(minFt: 5, maxFt: 50, idealFt: 20),
        tidePreference: TidePreference(phaseWeights: {}),
        solunarSensitivity: SolunarSensitivity.medium,
        lunarSensitivity: LunarSensitivity.low,
        weatherSensitivity: WeatherSensitivity(
          risingPressureFactor: 1,
          fallingPressureFactor: 1,
          frontalPassageFactor: 1,
          cloudCoverPreference: 0.5,
        ),
        currentPreference:
            CurrentPreference(minKnots: 0, maxKnots: 4, idealKnots: 1.5),
      ),
      regulatoryProfile: const RegulatoryProfile(),
      confidence: ConfidenceLevel.exploratory,
    );

ProviderContainer _container({
  required SpeciesDatabase speciesDb,
  ConditionsService? conditions,
}) {
  return ProviderContainer(
    overrides: [
      speciesDatabaseProvider.overrideWith((ref) async => speciesDb),
      conditionsServiceProvider
          .overrideWith((ref) async => conditions ?? _NullConditions()),
    ],
  );
}

void main() {
  group('selectedSpeciesIdProvider', () {
    test('defaults to common-snook', () {
      final c = ProviderContainer();
      addTearDown(c.dispose);
      expect(c.read(selectedSpeciesIdProvider), 'common-snook');
    });

    test('can be overridden', () {
      final c = ProviderContainer();
      addTearDown(c.dispose);
      c.read(selectedSpeciesIdProvider.notifier).state = 'mahi-mahi';
      expect(c.read(selectedSpeciesIdProvider), 'mahi-mahi');
    });
  });

  group('selectedTimeProvider', () {
    test('defaults to a UTC instant', () {
      final c = ProviderContainer();
      addTearDown(c.dispose);
      expect(c.read(selectedTimeProvider).isUtc, isTrue);
    });
  });

  group('availableSpeciesProvider', () {
    test('returns species sorted by id', () async {
      final db = SpeciesDatabase.create();
      db.seedForTesting(
        ids: ['mahi-mahi', 'common-snook', 'tarpon'],
        records: {
          'mahi-mahi': _testSpecies('mahi-mahi'),
          'common-snook': _testSpecies('common-snook'),
          'tarpon': _testSpecies('tarpon'),
        },
      );
      final c = _container(speciesDb: db);
      addTearDown(c.dispose);
      final list = await c.read(availableSpeciesProvider.future);
      expect(
        list.map((r) => r.id).toList(),
        ['common-snook', 'mahi-mahi', 'tarpon'],
      );
    });
  });

  group('scoreAtLocationProvider', () {
    test(
      'produces a ScoreResult for a passing-gate species + location',
      () async {
        final db = SpeciesDatabase.create();
        db.seedForTesting(
          ids: ['common-snook'],
          records: {'common-snook': _testSpecies('common-snook')},
        );
        final c = _container(speciesDb: db);
        addTearDown(c.dispose);

        final query = (
          speciesId: 'common-snook',
          location: const LatLng(latitude: 27.94, longitude: -82.45),
          time: DateTime.utc(2026, 5, 22, 18),
        );
        final result = await c.read(scoreAtLocationProvider(query).future);
        expect(result.speciesId, 'common-snook');
        expect(result.reasoning.gates.first.passed, isTrue);
      },
    );

    test('record-equal queries share the same future (family caching)', () {
      final db = SpeciesDatabase.create();
      db.seedForTesting(
        ids: ['x'],
        records: {'x': _testSpecies('x')},
      );
      final c = _container(speciesDb: db);
      addTearDown(c.dispose);

      // Build two distinct ScoreQuery records with the same fields.
      final time = DateTime.utc(2026, 5, 22, 18);
      const location = LatLng(latitude: 27.94, longitude: -82.45);
      final qA = (speciesId: 'x', location: location, time: time);
      final qB = (speciesId: 'x', location: location, time: time);
      final f1 = c.read(scoreAtLocationProvider(qA).future);
      final f2 = c.read(scoreAtLocationProvider(qB).future);
      expect(
        identical(f1, f2),
        isTrue,
        reason: 'family with record key should reuse the same future',
      );
    });
  });

  group('scoreGridProvider', () {
    test(
      'returns one cell per grid position for a small bbox',
      () async {
        final db = SpeciesDatabase.create();
        db.seedForTesting(
          ids: ['x'],
          records: {'x': _testSpecies('x')},
        );
        final c = _container(speciesDb: db);
        addTearDown(c.dispose);

        final query = (
          speciesId: 'x',
          bbox: const LatLngBounds(
            southwest: LatLng(latitude: 27.5, longitude: -82.7),
            northeast: LatLng(latitude: 28.0, longitude: -82.3),
          ),
          time: DateTime.utc(2026, 5, 22, 18),
          resolutionNm: 30.0,
        );
        final list = await c.read(scoreGridProvider(query).future);
        expect(list, isNotEmpty);
        expect(list.first.speciesId, 'x');
      },
    );
  });
}
