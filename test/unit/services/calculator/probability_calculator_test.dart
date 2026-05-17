import 'package:ai_marine_engine/core/types/catch_record.dart';
import 'package:ai_marine_engine/core/types/condition_result.dart';
import 'package:ai_marine_engine/core/types/conditions.dart';
import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/core/types/score_result.dart';
import 'package:ai_marine_engine/data/species/models/condition_profile.dart';
import 'package:ai_marine_engine/data/species/models/migration_model.dart';
import 'package:ai_marine_engine/data/species/models/regulatory_profile.dart';
import 'package:ai_marine_engine/data/species/models/species_record.dart';
import 'package:ai_marine_engine/services/calculator/probability_calculator.dart';
import 'package:ai_marine_engine/services/conditions/conditions_service.dart';
import 'package:flutter_test/flutter_test.dart';

// ── Fake ConditionsService — only the methods the calculator uses
//    are implemented; the rest throw to surface a test that drifts.

class _FakeConditionsService implements ConditionsService {
  _FakeConditionsService({
    this.waterTemp,
    this.tide,
    this.wind,
    this.baro,
    this.solunar,
    this.depth,
  });

  ConditionResult<double>? waterTemp;
  ConditionResult<TideState>? tide;
  ConditionResult<WindVector>? wind;
  ConditionResult<BarometricState>? baro;
  ConditionResult<SolunarState>? solunar;
  ConditionResult<double>? depth;
  ConditionResult<StructureInfo>? structure;
  List<CatchRecord> catches = const [];

  static ConditionResult<double> _unavailableDouble(DateTime t) =>
      ConditionResult<double>.unavailable(value: double.nan, time: t);
  static ConditionResult<TideState> _unavailableTide(DateTime t) =>
      ConditionResult<TideState>.unavailable(
        value: const TideState(
          phase: TidePhase.slackHigh,
          toNextChange: Duration.zero,
        ),
        time: t,
      );
  static ConditionResult<WindVector> _unavailableWind(DateTime t) =>
      ConditionResult<WindVector>.unavailable(
        value: const WindVector(speedKnots: 0, directionDegrees: 0),
        time: t,
      );
  static ConditionResult<BarometricState> _unavailableBaro(DateTime t) =>
      ConditionResult<BarometricState>.unavailable(
        value: const BarometricState(
          pressureMillibars: 0,
          trend: BarometricTrend.stable,
          rateOfChangeMillibarsPerHour: 0,
        ),
        time: t,
      );
  static ConditionResult<SolunarState> _unavailableSolunar(DateTime t) =>
      ConditionResult<SolunarState>.unavailable(
        value: const SolunarState(
          sunAltitudeDegrees: 0,
          sunAzimuthDegrees: 0,
          moonPhase: MoonPhase.newMoon,
          moonIlluminationFraction: 0,
        ),
        time: t,
      );
  static ConditionResult<StructureInfo> _unavailableStructure(DateTime t) =>
      ConditionResult<StructureInfo>.unavailable(
        value: const StructureInfo(type: StructureType.unknown),
        time: t,
      );

  @override
  Future<ConditionResult<double>> getWaterTemp(
    LatLng loc,
    DateTime t,
  ) async =>
      waterTemp ?? _unavailableDouble(t);
  @override
  Future<ConditionResult<TideState>> getTideState(
    LatLng loc,
    DateTime t,
  ) async =>
      tide ?? _unavailableTide(t);
  @override
  Future<ConditionResult<WindVector>> getWind(
    LatLng loc,
    DateTime t,
  ) async =>
      wind ?? _unavailableWind(t);
  @override
  Future<ConditionResult<BarometricState>> getBarometric(
    LatLng loc,
    DateTime t,
  ) async =>
      baro ?? _unavailableBaro(t);
  @override
  Future<ConditionResult<SolunarState>> getSolunar(
    LatLng loc,
    DateTime t,
  ) async =>
      solunar ?? _unavailableSolunar(t);
  @override
  Future<ConditionResult<StructureInfo>> getStructure(LatLng loc) async =>
      structure ?? _unavailableStructure(DateTime.now().toUtc());
  @override
  Future<ConditionResult<double>> getDepth(LatLng loc) async =>
      depth ?? _unavailableDouble(DateTime.now().toUtc());
  @override
  Future<List<CatchRecord>> getRecentCatches(
    LatLng loc,
    double radiusNm, {
    String? speciesId,
    DateTime? since,
  }) async =>
      catches;

  // Methods the calculator doesn't currently use — throw if any test
  // drifts and starts depending on them so we notice.
  @override
  Future<ConditionResult<CurrentVector>> getCurrent(
    LatLng loc,
    DateTime time, {
    double? depthMeters,
  }) =>
      throw UnimplementedError('not used by calculator');
  @override
  Future<ConditionResult<WaveState>> getWaves(LatLng loc, DateTime t) =>
      throw UnimplementedError('not used by calculator');
}

// ── Helpers for building test species and conditions ──────────────

GeoPolygon _bostonBox() => const GeoPolygon(
      rings: [
        [
          LatLng(latitude: 42, longitude: -71),
          LatLng(latitude: 43, longitude: -71),
          LatLng(latitude: 43, longitude: -70),
          LatLng(latitude: 42, longitude: -70),
          LatLng(latitude: 42, longitude: -71),
        ],
      ],
    );

GeoPolygon _harborBox() => const GeoPolygon(
      rings: [
        [
          LatLng(latitude: 42.3, longitude: -70.7),
          LatLng(latitude: 42.4, longitude: -70.7),
          LatLng(latitude: 42.4, longitude: -70.5),
          LatLng(latitude: 42.3, longitude: -70.5),
          LatLng(latitude: 42.3, longitude: -70.7),
        ],
      ],
    );

const _bostonHarbor = LatLng(latitude: 42.36, longitude: -70.55);
const _greenland = LatLng(latitude: 64, longitude: -50);
final _refTime = DateTime.utc(2026, 5, 22, 18); // week 21

List<double> _allOnes() => List<double>.filled(52, 1.0);
List<double> _allZeros() => List<double>.filled(52, 0.0);

const _profile = ConditionProfile(
  optimalTemp: TemperatureRange(minF: 60, maxF: 68, idealF: 64),
  toleratedTemp: TemperatureRange(minF: 50, maxF: 75, idealF: 64),
  depthPreference: DepthPreference(minFt: 5, maxFt: 50, idealFt: 20),
  tidePreference: TidePreference(
    phaseWeights: {
      TidePhase.rising: 0.9,
      TidePhase.falling: 0.7,
      TidePhase.slackHigh: 0.2,
      TidePhase.slackLow: 0.1,
    },
  ),
  solunarSensitivity: SolunarSensitivity.medium,
  lunarSensitivity: LunarSensitivity.low,
  weatherSensitivity: WeatherSensitivity(
    risingPressureFactor: 1.1,
    fallingPressureFactor: 1.4,
    frontalPassageFactor: 1.3,
    cloudCoverPreference: 0.5,
  ),
  currentPreference: CurrentPreference(
    minKnots: 0,
    maxKnots: 4,
    idealKnots: 1.5,
  ),
);

SpeciesRecord _species({
  required List<double> regionalCurve,
}) =>
    SpeciesRecord(
      id: 'test_species',
      scientificName: 'Test species',
      commonNames: const ['test'],
      schemaVersion: '1.0',
      curationVersion: '0.0.1',
      sizeClasses: const [],
      migrationModel: MigrationModel(
        spatialRange: _bostonBox(),
        regionalCurves: [
          RegionalPresenceCurve(
            regionId: 'boston_harbor',
            regionPolygon: _harborBox(),
            weeklyValues: regionalCurve,
          ),
        ],
      ),
      conditionProfile: _profile,
      regulatoryProfile: const RegulatoryProfile(),
      confidence: ConfidenceLevel.exploratory,
    );

ConditionResult<T> _ok<T>(T value, DateTime time, {double confidence = 0.9}) =>
    ConditionResult<T>(
      value: value,
      unit: '',
      source: DataSource.noaaNdbc,
      sourceDetails: const SourceDetails(),
      fetchedAt: time,
      validUntil: time.add(const Duration(hours: 1)),
      confidence: confidence,
    );

void main() {
  group('ProbabilityCalculator — gate fail short-circuits', () {
    test('outside spatial range → finalScore 0 with the gate failure surfaced',
        () async {
      final svc = _FakeConditionsService();
      final calc = ProbabilityCalculator(conditions: svc);
      final r = await calc.scoreLocation(
        species: _species(regionalCurve: _allOnes()),
        location: _greenland,
        time: _refTime,
      );
      expect(r.finalScore, 0);
      expect(r.confidence, 1.0);
      expect(r.reasoning.gates.first.passed, isFalse);
      expect(r.reasoning.modifiers, isEmpty);
      expect(r.reasoning.contributors, isEmpty);
      expect(r.reasoning.suggestedApproach, contains('different location'));
    });

    test('zero presence this week → finalScore 0', () async {
      final svc = _FakeConditionsService();
      final calc = ProbabilityCalculator(conditions: svc);
      final r = await calc.scoreLocation(
        species: _species(regionalCurve: _allZeros()),
        location: _bostonHarbor,
        time: _refTime,
      );
      expect(r.finalScore, 0);
      expect(r.reasoning.gates.first.passed, isFalse);
    });
  });

  group('ProbabilityCalculator — base × modifiers', () {
    test(
      'no conditions available → score = base × 1.0 (neutral GM) × 5',
      () async {
        // Curve at 1.0 → base = 1.0. Every sensor returns unavailable
        // so every modifier row is `available: false`. GM is computed
        // over the empty *active* set → defaults to 1.0. Expected raw
        // = 1.0 × 1.0 × 5 = 5.0.
        final svc = _FakeConditionsService();
        final calc = ProbabilityCalculator(conditions: svc);
        final r = await calc.scoreLocation(
          species: _species(regionalCurve: _allOnes()),
          location: _bostonHarbor,
          time: _refTime,
        );
        expect(r.reasoning.baseProbability, 1.0);
        // Placeholder rows are surfaced for transparency — none active.
        expect(
          r.reasoning.modifiers.where((m) => m.available),
          isEmpty,
        );
        expect(r.reasoning.modifiers, isNotEmpty);
        expect(r.reasoning.rawScoreBeforeContributors, closeTo(5.0, 1e-9));
        expect(r.finalScore, closeTo(5.0, 1e-9));
        expect(
          r.confidence,
          0.0,
          reason: 'no available conditions → confidence 0',
        );
      },
    );

    test(
      'all modifiers neutral (1.0) → raw = base × 1 × 5 (still 5 with full base)',
      () async {
        final svc = _FakeConditionsService(
          waterTemp: _ok(64, _refTime), // mid-plateau → mod 2.0
          tide: _ok(
            const TideState(
              phase: TidePhase.slackHigh,
              toNextChange: Duration(hours: 3),
            ),
            _refTime,
          ),
          wind: _ok(
            const WindVector(speedKnots: 5, directionDegrees: 0),
            _refTime,
          ),
          baro: _ok(
            const BarometricState(
              pressureMillibars: 1015,
              trend: BarometricTrend.stable,
              rateOfChangeMillibarsPerHour: 0,
            ),
            _refTime,
          ),
          solunar: _ok(
            const SolunarState(
              sunAltitudeDegrees: 30,
              sunAzimuthDegrees: 250,
              moonPhase: MoonPhase.waxingGibbous,
              moonIlluminationFraction: 0.6,
            ),
            _refTime,
          ),
        );
        final calc = ProbabilityCalculator(conditions: svc);
        final r = await calc.scoreLocation(
          species: _species(regionalCurve: _allOnes()),
          location: _bostonHarbor,
          time: _refTime,
        );

        // Modifier values for these inputs:
        //   water_temp 64°F      → 2.0 (plateau)
        //   tide slackHigh       → 0.4 (weight 0.2 × 2)
        //   wind 5 kt            → 2.0 (plateau)
        //   baro stable          → 1.0
        //   solunar (no windows) → 1.0 (no active window)
        // product = 2 * 0.4 * 2 * 1 * 1 = 1.6
        // GM = 1.6^(1/5) = 1.6^0.2 ≈ 1.0986
        // raw = 1.0 * 1.0986 * 5 ≈ 5.493
        final active = r.reasoning.modifiers.where((m) => m.available).toList();
        expect(active, hasLength(5));
        expect(r.reasoning.rawScoreBeforeContributors, closeTo(5.493, 0.01));
        expect(
          r.confidence,
          closeTo(0.9, 1e-9),
          reason: 'every condition reported confidence 0.9',
        );
      },
    );

    test(
      'water way out of tolerated kills the GM → final = 0 + contributors',
      () async {
        // Water 90°F is above the tolerated 75°F → modifier value 0.
        // GM with a zero factor is zero. Raw = 0. Final = additive only.
        final svc = _FakeConditionsService(
          waterTemp: _ok(90, _refTime),
        );
        final calc = ProbabilityCalculator(conditions: svc);
        final r = await calc.scoreLocation(
          species: _species(regionalCurve: _allOnes()),
          location: _bostonHarbor,
          time: _refTime,
        );
        expect(r.reasoning.rawScoreBeforeContributors, 0);
        // No contributors fire either → final = 0.
        expect(r.finalScore, 0);
      },
    );
  });

  group('ProbabilityCalculator — time-of-day modifier wiring', () {
    SpeciesRecord withWindows(List<TimeOfDayPreference> windows) =>
        SpeciesRecord(
          id: 'test',
          scientificName: 'Test',
          commonNames: const ['test'],
          schemaVersion: '1.0',
          curationVersion: '0.0.1',
          sizeClasses: const [],
          migrationModel: MigrationModel(
            spatialRange: _bostonBox(),
            regionalCurves: [
              RegionalPresenceCurve(
                regionId: 'boston_harbor',
                regionPolygon: _harborBox(),
                weeklyValues: _allOnes(),
              ),
            ],
          ),
          conditionProfile: _profile.copyWith(timeOfDayPreferences: windows),
          regulatoryProfile: const RegulatoryProfile(),
          confidence: ConfidenceLevel.exploratory,
        );

    test(
      'hour inside a feeding window surfaces a >1.0 time_of_day modifier',
      () async {
        // Empty FakeConditionsService → no other modifiers fire.
        // Time-of-day modifier is the only entry in the breakdown.
        final svc = _FakeConditionsService();
        final calc = ProbabilityCalculator(conditions: svc);
        final r = await calc.scoreLocation(
          species: withWindows(const [
            TimeOfDayPreference(startHour: 17, endHour: 20, weight: 0.8),
          ]),
          location: _bostonHarbor,
          time: _refTime, // 18:00 UTC, inside [17, 20]
        );
        final tod = r.reasoning.modifiers
            .where((m) => m.name == 'time_of_day')
            .toList();
        expect(tod, hasLength(1));
        // weight 0.8 → 0.7 + 0.8 * 0.8 = 1.34
        expect(tod.first.value, closeTo(1.34, 1e-9));
        // No contributors fire (no catches, no structure data).
        expect(r.reasoning.additiveTotal, 0);
        // raw = base 1.0 × GM 1.34 × 5 = 6.7
        expect(
          r.reasoning.rawScoreBeforeContributors,
          closeTo(6.7, 1e-9),
        );
      },
    );

    test(
      'hour outside every window drags the score below the neutral baseline',
      () async {
        // Without the time-of-day promotion, a no-other-conditions
        // score would sit at 5.0 (base × neutral GM × 5). With the
        // outside-window penalty (0.4 → only modifier), GM = 0.4,
        // raw = base 1.0 × 0.4 × 5 = 2.0. This is the mahi-at-night
        // regression test.
        final svc = _FakeConditionsService();
        final calc = ProbabilityCalculator(conditions: svc);
        final r = await calc.scoreLocation(
          species: withWindows(const [
            TimeOfDayPreference(startHour: 6, endHour: 10, weight: 1.0),
            TimeOfDayPreference(startHour: 16, endHour: 19, weight: 0.9),
          ]),
          location: _bostonHarbor,
          time: DateTime.utc(2026, 5, 22, 23), // outside every window
        );
        final tod =
            r.reasoning.modifiers.singleWhere((m) => m.name == 'time_of_day');
        expect(tod.value, closeTo(0.4, 1e-9));
        expect(r.reasoning.rawScoreBeforeContributors, closeTo(2.0, 1e-9));
        expect(r.finalScore, lessThan(5.0));
      },
    );

    test(
      'species with no timeOfDayPreferences → row present but available: false',
      () async {
        // _profile defaults to an empty preferences list. The modifier
        // surfaces in the breakdown for transparency but is excluded
        // from the math — same contract as a missing sensor reading.
        final svc = _FakeConditionsService();
        final calc = ProbabilityCalculator(conditions: svc);
        final r = await calc.scoreLocation(
          species: _species(regionalCurve: _allOnes()),
          location: _bostonHarbor,
          time: _refTime,
        );
        final tod =
            r.reasoning.modifiers.singleWhere((m) => m.name == 'time_of_day');
        expect(tod.available, isFalse);
      },
    );

    test('contributors block no longer carries a time_of_day entry', () async {
      // Regression guard against re-introducing it as a contributor.
      final svc = _FakeConditionsService();
      final calc = ProbabilityCalculator(conditions: svc);
      final r = await calc.scoreLocation(
        species: withWindows(const [
          TimeOfDayPreference(startHour: 17, endHour: 20, weight: 0.8),
        ]),
        location: _bostonHarbor,
        time: _refTime,
      );
      final names = r.reasoning.contributors.map((c) => c.name).toList();
      expect(names, isNot(contains('time_of_day')));
    });
  });

  group('ProbabilityCalculator — depth modifier wiring', () {
    test(
      'depth at species ideal surfaces a 2.0 modifier in the breakdown',
      () async {
        // Profile's depthPreference is 5–50 ft, ideal 20.
        final svc = _FakeConditionsService(depth: _ok(20.0, _refTime));
        final calc = ProbabilityCalculator(conditions: svc);
        final r = await calc.scoreLocation(
          species: _species(regionalCurve: _allOnes()),
          location: _bostonHarbor,
          time: _refTime,
        );
        final depthMod =
            r.reasoning.modifiers.where((m) => m.name == 'depth').toList();
        expect(depthMod, hasLength(1));
        expect(depthMod.first.value, 2.0);
      },
    );

    test(
      'unavailable depth → row present but marked unavailable',
      () async {
        // No depth set → fake returns unavailable. The placeholder row
        // shows the user "no bathymetry for this location" rather than
        // silently dropping the dimension from the breakdown.
        final svc = _FakeConditionsService();
        final calc = ProbabilityCalculator(conditions: svc);
        final r = await calc.scoreLocation(
          species: _species(regionalCurve: _allOnes()),
          location: _bostonHarbor,
          time: _refTime,
        );
        final depthMod =
            r.reasoning.modifiers.singleWhere((m) => m.name == 'depth');
        expect(depthMod.available, isFalse);
        expect(depthMod.description, contains('bathymetry'));
      },
    );
  });

  group('ProbabilityCalculator — unavailable modifier transparency', () {
    test(
      'every known modifier surfaces a row even when all sensors are out',
      () async {
        // The user must be able to see which signals are *missing*, not
        // just which ones fired. With every sensor unavailable and an
        // empty time-of-day preferences list on the species, the seven
        // canonical modifier rows should still all appear.
        final svc = _FakeConditionsService();
        final calc = ProbabilityCalculator(conditions: svc);
        final r = await calc.scoreLocation(
          species: _species(regionalCurve: _allOnes()),
          location: _bostonHarbor,
          time: _refTime,
        );
        final names = r.reasoning.modifiers.map((m) => m.name).toSet();
        expect(
          names,
          containsAll([
            'water_temperature',
            'tide_phase',
            'wind_speed',
            'barometric_trend',
            'solunar_window',
            'depth',
            'time_of_day',
          ]),
        );
        expect(
          r.reasoning.modifiers.every((m) => !m.available),
          isTrue,
          reason: 'no sensor data → every row should be `available: false`',
        );
      },
    );

    test(
      'unavailable rows are excluded from the geometric mean math',
      () async {
        // Only water-temp is available. Without proper filtering, the
        // unavailable rows (value=0) would zero out the product and
        // tank the score. Real GM should be just the water-temp value.
        final svc = _FakeConditionsService(waterTemp: _ok(64, _refTime));
        final calc = ProbabilityCalculator(conditions: svc);
        final r = await calc.scoreLocation(
          species: _species(regionalCurve: _allOnes()),
          location: _bostonHarbor,
          time: _refTime,
        );
        // water_temp 64°F is mid-plateau → modifier 2.0 → GM 2.0.
        // raw = 1.0 × 2.0 × 5 = 10.0, clamped to 10 by the envelope.
        expect(r.reasoning.rawScoreBeforeContributors, closeTo(10.0, 1e-9));
      },
    );
  });

  group('ProbabilityCalculator — final score envelope', () {
    test('final score is clamped to [0, 10]', () async {
      // Stack everything: max base, every modifier maxed, max contributors.
      // Without clamping, raw + add could exceed 10.
      final svc = _FakeConditionsService(
        waterTemp: _ok(64, _refTime), // 2.0
        wind: _ok(
          const WindVector(speedKnots: 5, directionDegrees: 0),
          _refTime,
        ), // 2.0
      );
      final calc = ProbabilityCalculator(conditions: svc);
      final r = await calc.scoreLocation(
        species: _species(regionalCurve: _allOnes()),
        location: _bostonHarbor,
        time: _refTime,
      );
      expect(r.finalScore, lessThanOrEqualTo(10));
      expect(r.finalScore, greaterThanOrEqualTo(0));
    });
  });

  group('ProbabilityCalculator.scoreGrid', () {
    test(
      'small bbox at coarse resolution produces the expected cell count',
      () async {
        // 1° height × 1° width box (Boston box) ≈ 60 nm × ~44 nm at
        // this latitude. At 30 nm resolution: rows = ceil(60/30) = 2,
        // cols = ceil(~44/30) = 2 → 4 cells.
        final svc = _FakeConditionsService();
        final calc = ProbabilityCalculator(conditions: svc);
        final grid = await calc.scoreGrid(
          species: _species(regionalCurve: _allOnes()),
          bbox: const LatLngBounds(
            southwest: LatLng(latitude: 42, longitude: -71),
            northeast: LatLng(latitude: 43, longitude: -70),
          ),
          time: _refTime,
          resolutionNm: 30,
        );
        expect(grid, hasLength(4));
      },
    );

    test('every cell center sits inside the requested bbox', () async {
      const bbox = LatLngBounds(
        southwest: LatLng(latitude: 42, longitude: -71),
        northeast: LatLng(latitude: 43, longitude: -70),
      );
      final svc = _FakeConditionsService();
      final calc = ProbabilityCalculator(conditions: svc);
      final grid = await calc.scoreGrid(
        species: _species(regionalCurve: _allOnes()),
        bbox: bbox,
        time: _refTime,
        resolutionNm: 15,
      );
      for (final r in grid) {
        expect(
          bbox.contains(r.location),
          isTrue,
          reason: 'cell ${r.location} should be inside the bbox',
        );
      }
    });

    test(
      'cell centers are uniformly spaced — first cell offset half a step '
      'inside the southwest corner',
      () async {
        const bbox = LatLngBounds(
          southwest: LatLng(latitude: 42, longitude: -71),
          northeast: LatLng(latitude: 43, longitude: -70),
        );
        final svc = _FakeConditionsService();
        final calc = ProbabilityCalculator(conditions: svc);
        // 60 nm height / 30 nm = 2 rows. Each row is 0.5°.
        // First row center: 42 + 0.25 = 42.25.
        final grid = await calc.scoreGrid(
          species: _species(regionalCurve: _allOnes()),
          bbox: bbox,
          time: _refTime,
          resolutionNm: 30,
        );
        final lats = grid.map((r) => r.location.latitude).toSet().toList()
          ..sort();
        expect(lats, hasLength(2));
        expect(lats.first, closeTo(42.25, 1e-9));
        expect(lats.last, closeTo(42.75, 1e-9));
      },
    );

    test(
      'cells outside the species spatial range still appear with finalScore 0',
      () async {
        // A bbox extending well outside the spatial range should
        // produce some passing-gate cells and some failing-gate
        // cells — both surface in the heatmap.
        const bbox = LatLngBounds(
          southwest: LatLng(latitude: 40, longitude: -75),
          northeast: LatLng(latitude: 45, longitude: -68),
        );
        final svc = _FakeConditionsService();
        final calc = ProbabilityCalculator(conditions: svc);
        final grid = await calc.scoreGrid(
          species: _species(regionalCurve: _allOnes()),
          bbox: bbox,
          time: _refTime,
          resolutionNm: 60,
        );
        final outOfRange = grid.where((r) => r.finalScore == 0).toList();
        expect(
          outOfRange,
          isNotEmpty,
          reason: 'cells outside the spatial range should score 0',
        );
        // And conversely, at least one cell should be in-range and
        // produce a non-zero score.
        final inRange = grid.where((r) => r.finalScore > 0).toList();
        expect(inRange, isNotEmpty);
      },
    );

    test(
      'every grid cell carries species, time, and a reasoning breakdown',
      () async {
        final svc = _FakeConditionsService();
        final calc = ProbabilityCalculator(conditions: svc);
        final species = _species(regionalCurve: _allOnes());
        final grid = await calc.scoreGrid(
          species: species,
          bbox: const LatLngBounds(
            southwest: LatLng(latitude: 42.3, longitude: -70.7),
            northeast: LatLng(latitude: 42.4, longitude: -70.5),
          ),
          time: _refTime,
          resolutionNm: 5,
        );
        for (final r in grid) {
          expect(r.speciesId, species.id);
          expect(r.time, _refTime);
          expect(r.reasoning, isA<ReasoningBreakdown>());
        }
      },
    );
  });
}
