import 'package:freezed_annotation/freezed_annotation.dart';

import 'lat_lng.dart';

part 'conditions.freezed.dart';
part 'conditions.g.dart';

// ── TideState — TDD §3.2 ────────────────────────────────────────────────
enum TidePhase { rising, falling, slackHigh, slackLow }

@freezed
class TideState with _$TideState {
  const factory TideState({
    required TidePhase phase,
    required Duration toNextChange,
    double? amplitudeFt,
  }) = _TideState;

  factory TideState.fromJson(Map<String, dynamic> json) =>
      _$TideStateFromJson(json);
}

// ── CurrentVector — TDD §3.2 ────────────────────────────────────────────
@freezed
class CurrentVector with _$CurrentVector {
  /// [directionDegrees] is true bearing (0..360), the direction the current
  /// is moving toward.
  const factory CurrentVector({
    required double speedKnots,
    required double directionDegrees,
  }) = _CurrentVector;

  factory CurrentVector.fromJson(Map<String, dynamic> json) =>
      _$CurrentVectorFromJson(json);
}

// ── WindVector — TDD §3.2 ───────────────────────────────────────────────
@freezed
class WindVector with _$WindVector {
  /// [directionDegrees] is the meteorological convention — the direction
  /// the wind is coming *from*, true bearing in 0..360.
  const factory WindVector({
    required double speedKnots,
    required double directionDegrees,
    double? gustsKnots,
  }) = _WindVector;

  factory WindVector.fromJson(Map<String, dynamic> json) =>
      _$WindVectorFromJson(json);
}

// ── WaveState — TDD §3.2 ────────────────────────────────────────────────
@freezed
class WaveState with _$WaveState {
  const factory WaveState({
    required double significantHeightFt,
    double? dominantPeriodSec,
  }) = _WaveState;

  factory WaveState.fromJson(Map<String, dynamic> json) =>
      _$WaveStateFromJson(json);
}

// ── SolunarState — TDD §3.2 ─────────────────────────────────────────────
enum MoonPhase {
  newMoon,
  waxingCrescent,
  firstQuarter,
  waxingGibbous,
  fullMoon,
  waningGibbous,
  lastQuarter,
  waningCrescent,
}

enum SolunarStrength { major, minor }

@freezed
class SolunarWindow with _$SolunarWindow {
  const SolunarWindow._();

  const factory SolunarWindow({
    required DateTime start,
    required DateTime end,
    required SolunarStrength strength,
  }) = _SolunarWindow;

  factory SolunarWindow.fromJson(Map<String, dynamic> json) =>
      _$SolunarWindowFromJson(json);

  /// Whether this window is currently active.
  ///
  /// Implemented as a thin wrapper over [isActiveAt] so callers can pass a
  /// fixed time in tests; the no-arg getter uses wall-clock UTC.
  bool get isActive => isActiveAt(DateTime.now().toUtc());

  bool isActiveAt(DateTime now) => !now.isBefore(start) && !now.isAfter(end);
}

@freezed
class SolunarState with _$SolunarState {
  const factory SolunarState({
    required double sunAltitudeDegrees,
    required double sunAzimuthDegrees,
    required MoonPhase moonPhase,
    required double moonIlluminationFraction,
    SolunarWindow? majorWindow,
    SolunarWindow? minorWindow,
  }) = _SolunarState;

  factory SolunarState.fromJson(Map<String, dynamic> json) =>
      _$SolunarStateFromJson(json);
}

// ── StructureInfo — TDD §3.2 ────────────────────────────────────────────
enum StructureType {
  flatBottom,
  sandFlat,
  channel,
  channelEdge,
  ledge,
  dropOff,
  reef,
  wreck,
  weedLine,
  shoal,
  ripCurrent,
  unknown,
}

/// A named geographic feature — buoy, channel marker, named reef, etc.
///
/// TDD §3.2 references `List<NamedFeature>` from `StructureInfo` but does
/// not define the class itself. v1 keeps the shape minimal: a label and
/// where the feature is, with an optional caller-supplied distance. A
/// richer feature taxonomy (kind enum, source provenance) can be added
/// when the species-data ingestion in Phase 3 actually populates these.
@freezed
class NamedFeature with _$NamedFeature {
  const factory NamedFeature({
    required String name,
    required LatLng location,
    double? distanceM,
  }) = _NamedFeature;

  factory NamedFeature.fromJson(Map<String, dynamic> json) =>
      _$NamedFeatureFromJson(json);
}

@freezed
class StructureInfo with _$StructureInfo {
  const factory StructureInfo({
    required StructureType type,
    @Default(<NamedFeature>[]) List<NamedFeature> nearbyFeatures,
    double? distanceToContourTransitionM,
  }) = _StructureInfo;

  factory StructureInfo.fromJson(Map<String, dynamic> json) =>
      _$StructureInfoFromJson(json);
}

// ── BarometricState — TDD §3.2 ──────────────────────────────────────────
enum BarometricTrend { rising, falling, stable }

@freezed
class BarometricState with _$BarometricState {
  const factory BarometricState({
    required double pressureMillibars,
    required BarometricTrend trend,
    required double rateOfChangeMillibarsPerHour,
  }) = _BarometricState;

  factory BarometricState.fromJson(Map<String, dynamic> json) =>
      _$BarometricStateFromJson(json);
}
