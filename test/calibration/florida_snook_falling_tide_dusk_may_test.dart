import 'package:ai_marine_engine/core/types/catch_record.dart';
import 'package:ai_marine_engine/core/types/condition_result.dart';
import 'package:ai_marine_engine/core/types/conditions.dart';
import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/data/species/models/condition_profile.dart';
import 'package:ai_marine_engine/data/species/models/migration_model.dart';
import 'package:ai_marine_engine/data/species/models/regulatory_profile.dart';
import 'package:ai_marine_engine/data/species/models/species_record.dart';
import 'package:ai_marine_engine/services/calculator/probability_calculator.dart';
import 'package:ai_marine_engine/services/conditions/conditions_service.dart';
import 'package:flutter_test/flutter_test.dart';

/// **Calibration tuple #1 — snook, falling tide, dusk, May, Tampa Bay.**
///
/// First entry in the calibration suite (TDD §6 / Implementation Guide
/// §3.5). The CI gate from `.github/workflows/ci.yml` line 13 was
/// blocked on "no tuples yet" — this slice unblocks it. From here on,
/// any code or data change that drifts this score out of the expected
/// band fails CI.
///
/// **What this tuple pins:** classic favorable inshore snook conditions.
///   - Tampa Bay shipping channel mouth, 2026-05-22 23:00 UTC
///     (≈ 19:00 EDT, dusk).
///   - Water 78°F (square in snook's optimal 72–84°F band).
///   - Falling tide (snook's strongest phase — drains bait off the
///     grass flats).
///   - Light SW wind, 7 kt (well inside the comfort plateau).
///   - Falling barometric pressure at 1011 mb (front-incoming —
///     snook fire on this; species data carries fallingPressureFactor
///     1.5).
///   - Active major solunar window centered on the lookup time.
///   - Depth 14 ft, near species ideal of 12 ft.
///   - Inside the species's spatial range and a high-presence regional
///     curve.
///
/// **Expected score:** 7.0 ≤ finalScore ≤ 10.0. Tight enough that a
/// regression that knocks the score below ~7 (or somehow inflates it
/// above the 10 cap) breaks the build; loose enough that calibration
/// tweaks within sane bounds don't false-positive.
///
/// **Species data is inline-synthetic for v1.** Authoring real Florida
/// species files (snook, redfish, seatrout, …) is parallel work that
/// hasn't started; the values here are biologist-plausible defaults
/// for Centropomus undecimalis. When real species JSON lands, this
/// tuple should switch to loading from it.
void main() {
  test(
    'snook on a falling tide at dusk in Tampa Bay scores in [7.0, 10.0]',
    () async {
      final time = DateTime.utc(2026, 5, 22, 23); // 19:00 EDT
      const tampaBayChannel = LatLng(latitude: 27.94, longitude: -82.45);

      final svc = _StubbedConditions(time: time);
      final calc = ProbabilityCalculator(conditions: svc);
      final result = await calc.scoreLocation(
        species: _snook(),
        location: tampaBayChannel,
        time: time,
      );

      expect(
        result.finalScore,
        inInclusiveRange(7.0, 10.0),
        reason: 'classic favorable snook conditions should land in the '
            'high-confidence band; got finalScore=${result.finalScore} '
            'with breakdown ${result.reasoning}',
      );
      expect(result.reasoning.gates.first.passed, isTrue);
      expect(result.reasoning.modifiers, isNotEmpty);
    },
  );
}

// ─── Species data (synthetic snook profile) ─────────────────────────

SpeciesRecord _snook() => SpeciesRecord(
      id: 'common_snook',
      scientificName: 'Centropomus undecimalis',
      commonNames: const ['snook', 'common snook', 'robalo'],
      schemaVersion: '1.0',
      curationVersion: '0.0.1-calibration',
      sizeClasses: const [],
      migrationModel: MigrationModel(
        // Florida coastal box — snook range hugs the southern half of
        // both coasts plus the Keys.
        spatialRange: _floridaCoastalBox(),
        regionalCurves: [
          RegionalPresenceCurve(
            regionId: 'tampa_bay',
            regionPolygon: _tampaBayBox(),
            // Year-round in central FL, but late-spring is peak.
            // Week 21 (late May) ≈ 0.95.
            weeklyValues: _seasonalCurve(),
          ),
        ],
      ),
      conditionProfile: const ConditionProfile(
        // Snook cold-stun threshold ≈ 60°F; heat tolerance ≈ 90°F.
        toleratedTemp: TemperatureRange(minF: 60, maxF: 90, idealF: 78),
        optimalTemp: TemperatureRange(minF: 72, maxF: 84, idealF: 78),
        // Inshore: docks, mangroves, grass-flat edges; 5–25 ft typical.
        depthPreference: DepthPreference(minFt: 5, maxFt: 25, idealFt: 12),
        // Strongly prefer moving water; falling tide is the marquee
        // for snook on grass flats and channel edges.
        tidePreference: TidePreference(
          phaseWeights: {
            TidePhase.rising: 0.85,
            TidePhase.falling: 0.95,
            TidePhase.slackHigh: 0.30,
            TidePhase.slackLow: 0.20,
          },
        ),
        solunarSensitivity: SolunarSensitivity.high,
        lunarSensitivity: LunarSensitivity.medium,
        // Front-feeders: a falling barometer ahead of a system fires
        // them up. Stable / rising are unremarkable.
        weatherSensitivity: WeatherSensitivity(
          risingPressureFactor: 1.0,
          fallingPressureFactor: 1.5,
          frontalPassageFactor: 1.4,
          cloudCoverPreference: 0.6,
        ),
        // Dawn and dusk windows.
        timeOfDayPreferences: [
          TimeOfDayPreference(startHour: 5, endHour: 7, weight: 0.85),
          TimeOfDayPreference(startHour: 19, endHour: 21, weight: 0.95),
        ],
        currentPreference:
            CurrentPreference(minKnots: 0.2, maxKnots: 3, idealKnots: 1.0),
        structurePreferences: [
          StructurePreference(type: StructureType.weedLine, weight: 0.85),
          StructurePreference(type: StructureType.channelEdge, weight: 0.7),
          StructurePreference(type: StructureType.dropOff, weight: 0.55),
        ],
      ),
      regulatoryProfile: const RegulatoryProfile(),
      confidence: ConfidenceLevel.exploratory,
    );

GeoPolygon _floridaCoastalBox() => const GeoPolygon(
      rings: [
        [
          LatLng(latitude: 24.5, longitude: -83.0),
          LatLng(latitude: 31.0, longitude: -83.0),
          LatLng(latitude: 31.0, longitude: -79.5),
          LatLng(latitude: 24.5, longitude: -79.5),
          LatLng(latitude: 24.5, longitude: -83.0),
        ],
      ],
    );

GeoPolygon _tampaBayBox() => const GeoPolygon(
      rings: [
        [
          LatLng(latitude: 27.5, longitude: -82.7),
          LatLng(latitude: 28.1, longitude: -82.7),
          LatLng(latitude: 28.1, longitude: -82.3),
          LatLng(latitude: 27.5, longitude: -82.3),
          LatLng(latitude: 27.5, longitude: -82.7),
        ],
      ],
    );

/// 52-week curve with peak in late spring / early summer (weeks 18–32),
/// shoulder spring/fall presence, weak winter. Week 21 (late May) ≈ 0.95.
List<double> _seasonalCurve() {
  return List<double>.generate(52, (i) {
    final week = i + 1;
    if (week >= 18 && week <= 32) return 0.95;
    if (week >= 14 && week <= 38) return 0.75;
    if (week >= 8 && week <= 44) return 0.5;
    return 0.3;
  });
}

// ─── Stubbed conditions for the scenario ────────────────────────────

class _StubbedConditions implements ConditionsService {
  _StubbedConditions({required this.time});

  final DateTime time;

  ConditionResult<T> _ok<T>(T value, {double confidence = 0.9}) =>
      ConditionResult<T>(
        value: value,
        unit: '',
        source: DataSource.noaaNdbc,
        sourceDetails: const SourceDetails(),
        fetchedAt: time,
        validUntil: time.add(const Duration(hours: 1)),
        confidence: confidence,
      );

  @override
  Future<ConditionResult<double>> getWaterTemp(LatLng loc, DateTime t) async =>
      _ok<double>(78); // snook optimal sweet spot

  @override
  Future<ConditionResult<TideState>> getTideState(
    LatLng loc,
    DateTime t,
  ) async =>
      _ok<TideState>(
        const TideState(
          phase: TidePhase.falling,
          toNextChange: Duration(hours: 2, minutes: 15),
          amplitudeFt: 1.6,
        ),
      );

  @override
  Future<ConditionResult<WindVector>> getWind(LatLng loc, DateTime t) async =>
      _ok<WindVector>(
        const WindVector(speedKnots: 7, directionDegrees: 230),
      );

  @override
  Future<ConditionResult<BarometricState>> getBarometric(
    LatLng loc,
    DateTime t,
  ) async =>
      _ok<BarometricState>(
        const BarometricState(
          pressureMillibars: 1011,
          trend: BarometricTrend.falling,
          rateOfChangeMillibarsPerHour: -0.6,
        ),
      );

  @override
  Future<ConditionResult<SolunarState>> getSolunar(
    LatLng loc,
    DateTime t,
  ) async =>
      _ok<SolunarState>(
        SolunarState(
          sunAltitudeDegrees: 5, // dusk
          sunAzimuthDegrees: 285,
          moonPhase: MoonPhase.waxingGibbous,
          moonIlluminationFraction: 0.7,
          // Active major window centered on the lookup time.
          majorWindow: SolunarWindow(
            start: time.subtract(const Duration(minutes: 45)),
            end: time.add(const Duration(minutes: 45)),
            strength: SolunarStrength.major,
          ),
        ),
      );

  @override
  Future<ConditionResult<double>> getDepth(LatLng loc) async =>
      _ok<double>(14); // near snook ideal of 12

  @override
  Future<ConditionResult<StructureInfo>> getStructure(LatLng loc) async =>
      // Channel edge into the bay — classic dusk snook spot.
      _ok<StructureInfo>(
        const StructureInfo(type: StructureType.channelEdge),
      );

  @override
  Future<List<CatchRecord>> getRecentCatches(
    LatLng loc,
    double radiusNm, {
    String? speciesId,
    DateTime? since,
  }) async =>
      const []; // calibration tuple deliberately doesn't depend on
  // user-history bonus — it tests the engine baseline alone.

  // Methods the calculator doesn't currently consume — throw if a
  // future change adds a dependency so we notice.
  @override
  Future<ConditionResult<CurrentVector>> getCurrent(
    LatLng loc,
    DateTime t, {
    double? depthMeters,
  }) =>
      throw UnimplementedError('not used by calculator');

  @override
  Future<ConditionResult<WaveState>> getWaves(LatLng loc, DateTime t) =>
      throw UnimplementedError('not used by calculator');
}
