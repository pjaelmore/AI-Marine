import 'dart:math' as math;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'lat_lng.freezed.dart';
part 'lat_lng.g.dart';

/// Earth's mean radius in nautical miles (U.S. Hydrographic Office).
const double _earthRadiusNm = 3440.065;

/// Nautical miles per degree of latitude. One arcminute of latitude is one
/// nautical mile by definition; 60 arcminutes per degree.
const double _nmPerLatDegree = 60.0;

/// WGS-84 geographic coordinate. Latitude in [-90, 90], longitude in
/// [-180, 180]; out-of-range values are not rejected at construction so
/// callers can carry sentinel or post-validation values, but [isValid]
/// reports the canonical range check.
@freezed
class LatLng with _$LatLng {
  const LatLng._();

  const factory LatLng({
    required double latitude,
    required double longitude,
  }) = _LatLng;

  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);

  /// Whether this coordinate is within the canonical WGS-84 ranges.
  bool get isValid =>
      latitude >= -90 &&
      latitude <= 90 &&
      longitude >= -180 &&
      longitude <= 180;

  /// Great-circle distance to [other] in nautical miles, computed via the
  /// haversine formula on a spherical Earth.
  ///
  /// Spherical-Earth assumption introduces ≤ ~0.5% error relative to true
  /// WGS-84 ellipsoidal distance — acceptable for v1 fishing-recommendation
  /// distances, which are dominated by horizon-scale travel rather than
  /// sub-mile precision.
  double distanceTo(LatLng other) {
    final lat1 = _toRadians(latitude);
    final lat2 = _toRadians(other.latitude);
    final dLat = lat2 - lat1;
    final dLon = _toRadians(other.longitude - longitude);

    final a = math.pow(math.sin(dLat / 2), 2) +
        math.cos(lat1) * math.cos(lat2) * math.pow(math.sin(dLon / 2), 2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return _earthRadiusNm * c;
  }
}

/// Axis-aligned WGS-84 bounding box. Does not handle the antimeridian
/// (±180° longitude wrap) — v1 species ranges are all within the western
/// Atlantic / Gulf and never cross it.
@freezed
class LatLngBounds with _$LatLngBounds {
  const LatLngBounds._();

  const factory LatLngBounds({
    required LatLng southwest,
    required LatLng northeast,
  }) = _LatLngBounds;

  factory LatLngBounds.fromJson(Map<String, dynamic> json) =>
      _$LatLngBoundsFromJson(json);

  /// Square bbox of half-diagonal [radiusNm] centred on [center]. The
  /// trip planner uses this to derive a default trip area around the
  /// user-picked boat ramp. North/south extent is a fixed 1°/60 nm
  /// arc; east/west extent shrinks with cos(lat) so the box stays
  /// roughly square at the given latitude rather than visually
  /// stretched.
  factory LatLngBounds.fromCenter({
    required LatLng center,
    required double radiusNm,
  }) {
    final dLat = radiusNm / _nmPerLatDegree;
    final cosLat = math.cos(_toRadians(center.latitude)).abs();
    // Floor the cosine so a centre exactly at a pole doesn't divide
    // by zero; any latitude inside FL coverage stays well above this.
    final dLon = radiusNm / (_nmPerLatDegree * math.max(cosLat, 0.01));
    return LatLngBounds(
      southwest: LatLng(
        latitude: center.latitude - dLat,
        longitude: center.longitude - dLon,
      ),
      northeast: LatLng(
        latitude: center.latitude + dLat,
        longitude: center.longitude + dLon,
      ),
    );
  }

  /// Whether [point] falls within this rectangle, inclusive of edges.
  bool contains(LatLng point) =>
      point.latitude >= southwest.latitude &&
      point.latitude <= northeast.latitude &&
      point.longitude >= southwest.longitude &&
      point.longitude <= northeast.longitude;

  /// Geometric centre (arithmetic mean of corners).
  LatLng get center => LatLng(
        latitude: (southwest.latitude + northeast.latitude) / 2,
        longitude: (southwest.longitude + northeast.longitude) / 2,
      );

  /// Vertical extent in nautical miles. One degree of latitude is ~60 nm
  /// at every latitude on the WGS-84 sphere.
  double get heightNm =>
      (northeast.latitude - southwest.latitude) * _nmPerLatDegree;

  /// Horizontal extent in nautical miles, evaluated at the centre latitude.
  /// One degree of longitude shrinks with cos(latitude).
  double get widthNm =>
      (northeast.longitude - southwest.longitude) *
      _nmPerLatDegree *
      math.cos(_toRadians(center.latitude));
}

/// Polygon for representing species ranges, jurisdictions, and regions.
/// The first ring is the outer boundary; subsequent rings are holes.
///
/// Coordinates are WGS-84 decimal degrees treated as a 2-D cartesian plane
/// for containment math. This is accurate enough for regional polygons
/// (single-jurisdiction scale) but breaks down near the poles or for
/// polygons that wrap the antimeridian — neither applies to v1 coverage.
@freezed
class GeoPolygon with _$GeoPolygon {
  const GeoPolygon._();

  const factory GeoPolygon({
    required List<List<LatLng>> rings,
  }) = _GeoPolygon;

  factory GeoPolygon.fromJson(Map<String, dynamic> json) =>
      _$GeoPolygonFromJson(json);

  /// Whether [point] lies inside the polygon. Uses the even-odd ray-casting
  /// rule across all rings combined, so points inside a hole return false
  /// and points inside the outer ring but outside every hole return true —
  /// concave outer rings are handled correctly. Points lying exactly on
  /// any edge are treated as inside.
  bool contains(LatLng point) {
    if (rings.isEmpty) return false;
    for (final ring in rings) {
      if (_pointOnRing(point, ring)) return true;
    }
    var crossings = 0;
    for (final ring in rings) {
      crossings += _rayCrossings(point, ring);
    }
    return crossings.isOdd;
  }
}

double _toRadians(double degrees) => degrees * math.pi / 180.0;

bool _pointOnRing(LatLng p, List<LatLng> ring) {
  if (ring.length < 2) return false;
  for (var i = 0; i < ring.length; i++) {
    final a = ring[i];
    final b = ring[(i + 1) % ring.length];
    if (_pointOnSegment(p, a, b)) return true;
  }
  return false;
}

bool _pointOnSegment(LatLng p, LatLng a, LatLng b) {
  // Collinearity (cross product near zero) plus axis-aligned bounding box.
  // Epsilons in degree-units; 1e-12 is well above floating-point noise for
  // continental-scale magnitudes (~100°) and well below human-meaningful
  // resolution (~1e-7 deg ≈ 1 cm).
  const eps = 1e-12;
  final cross = (p.longitude - a.longitude) * (b.latitude - a.latitude) -
      (p.latitude - a.latitude) * (b.longitude - a.longitude);
  if (cross.abs() > eps) return false;
  final minLat = math.min(a.latitude, b.latitude);
  final maxLat = math.max(a.latitude, b.latitude);
  final minLon = math.min(a.longitude, b.longitude);
  final maxLon = math.max(a.longitude, b.longitude);
  return p.latitude >= minLat - eps &&
      p.latitude <= maxLat + eps &&
      p.longitude >= minLon - eps &&
      p.longitude <= maxLon + eps;
}

int _rayCrossings(LatLng p, List<LatLng> ring) {
  if (ring.length < 3) return 0;
  // Eastward (positive-longitude) ray from p; count edges that cross it.
  var crossings = 0;
  for (var i = 0; i < ring.length; i++) {
    final a = ring[i];
    final b = ring[(i + 1) % ring.length];
    final aAbove = a.latitude > p.latitude;
    final bAbove = b.latitude > p.latitude;
    if (aAbove == bAbove) continue;
    final t = (p.latitude - a.latitude) / (b.latitude - a.latitude);
    final xIntercept = a.longitude + t * (b.longitude - a.longitude);
    if (xIntercept > p.longitude) crossings++;
  }
  return crossings;
}
