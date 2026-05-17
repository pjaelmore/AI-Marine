/// One bathymetry sample parsed from an OpenTopoData GEBCO response —
/// returns `depthFt` for an ocean point or `null` for land.
class GebcoDepthSample {
  const GebcoDepthSample.water({required this.depthFt}) : isLand = false;
  const GebcoDepthSample.land()
      : depthFt = 0,
        isLand = true;

  /// Depth in feet (positive). Zero when `isLand` is true.
  final double depthFt;

  /// True when GEBCO reports a positive elevation — the query landed
  /// on land or above sea level. Callers should treat the result as
  /// "no depth data here" rather than "zero feet of water."
  final bool isLand;
}

/// Pulls the depth value out of an OpenTopoData GEBCO response body.
///
/// GEBCO 2020 returns elevation in metres relative to mean sea level:
/// negative values are below water (depth), positive values are land.
/// We convert to feet (× 3.28084) and flip the sign so callers get a
/// positive depth.
///
/// Land readings are surfaced as `GebcoDepthSample.land()` rather than
/// negative or zero so the calculator can omit them from the depth
/// modifier cleanly (the species's `depthPreference` would otherwise
/// evaluate "0 ft" against an offshore-only profile and tank scores
/// for a query that just happened to fall on a barrier island).
///
/// Throws [FormatException] when the response shape diverges
/// (missing `results`, non-OK status, missing elevation).
GebcoDepthSample parseOpenTopoDataDepth(Map<String, dynamic> body) {
  final status = body['status'];
  if (status != 'OK') {
    throw FormatException(
      'OpenTopoData status was not OK (got: $status)',
    );
  }
  final results = body['results'];
  if (results is! List || results.isEmpty) {
    throw const FormatException('OpenTopoData response had no results');
  }
  final first = results.first;
  if (first is! Map<String, dynamic>) {
    throw const FormatException(
      'OpenTopoData first result was not a JSON object',
    );
  }
  final elevation = first['elevation'];
  if (elevation == null) {
    // Sample fell outside GEBCO coverage (rare; the global compilation
    // is essentially complete). Treat as land — the caller will surface
    // a "no bathymetry" placeholder.
    return const GebcoDepthSample.land();
  }
  if (elevation is! num) {
    throw const FormatException(
      'OpenTopoData elevation was not numeric',
    );
  }
  final metres = elevation.toDouble();
  if (metres >= 0) return const GebcoDepthSample.land();
  return GebcoDepthSample.water(depthFt: -metres * 3.28084);
}
