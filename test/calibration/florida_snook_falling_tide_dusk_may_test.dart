import 'package:ai_marine_engine/core/types/catch_record.dart';
import 'package:ai_marine_engine/core/types/condition_result.dart';
import 'package:ai_marine_engine/core/types/conditions.dart';
import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/data/species/species_database.dart';
import 'package:ai_marine_engine/services/calculator/probability_calculator.dart';
import 'package:ai_marine_engine/services/conditions/conditions_service.dart';
import 'package:flutter_test/flutter_test.dart';

/// **Calibration tuple #1 — snook, falling tide, dusk, May, Tampa Bay.**
///
/// First entry in the calibration suite (TDD §6 / Implementation Guide
/// §3.5). The CI gate from `.github/workflows/ci.yml` line 13 was
/// blocked on "no tuples yet" — Phase 5 unblocked it inline-synthetic;
/// **this slice rewires it to load the real `assets/species/common-
/// snook.json` data file.** From here on, any code or species-data
/// change that drifts this score out of the expected band fails CI
/// alongside the unit suite. That's the whole point of calibration:
/// the test pins authoritative species data against a known scenario,
/// and protects against silent drift in either the engine or the data.
///
/// **Scenario (unchanged from inline-synthetic version):**
///   - Tampa Bay shipping channel mouth, 2026-05-22 23:00 UTC (≈ dusk
///     EDT). Water 78°F, falling tide, light SW wind 7 kt, falling
///     barometer at 1011 mb, active major solunar window, depth 14 ft,
///     channel-edge structure, no recent catches.
///
/// **Expected score:** 7.0 ≤ finalScore ≤ 10.0. Tight enough that a
/// regression knocking it below 7 (or somehow inflating it past the 10
/// cap) breaks the build; loose enough that calibration tweaks within
/// sane bounds don't false-positive.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'snook on a falling tide at dusk in Tampa Bay scores in [7.0, 10.0]',
    () async {
      final time = DateTime.utc(2026, 5, 22, 23); // 19:00 EDT
      const tampaBayChannel = LatLng(latitude: 27.94, longitude: -82.45);

      final db = SpeciesDatabase.create();
      final snook = await db.load('common-snook');

      final svc = _StubbedConditions(time: time);
      final calc = ProbabilityCalculator(conditions: svc);
      final result = await calc.scoreLocation(
        species: snook,
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
          majorWindow: SolunarWindow(
            start: time.subtract(const Duration(minutes: 45)),
            end: time.add(const Duration(minutes: 45)),
            strength: SolunarStrength.major,
          ),
        ),
      );

  @override
  Future<ConditionResult<double>> getDepth(LatLng loc) async =>
      _ok<double>(14); // near snook ideal of ~8 ft

  @override
  Future<ConditionResult<StructureInfo>> getStructure(LatLng loc) async =>
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
