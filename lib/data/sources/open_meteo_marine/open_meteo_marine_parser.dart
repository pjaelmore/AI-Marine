/// One temperature sample picked from an Open-Meteo Marine response —
/// the closest hourly bucket to a target time, paired with the
/// bucket's own timestamp so the caller can attribute the reading
/// honestly ("Observed 19:00 UTC", not "right now").
class OpenMeteoSstSample {
  const OpenMeteoSstSample({required this.tempC, required this.observedAt});
  final double tempC;
  final DateTime observedAt;
}

/// Pulls the closest hourly SST sample to [target] out of an
/// Open-Meteo Marine API response body — TDD §5.x.
///
/// The Marine API response carries arrays of equal length for
/// `hourly.time` and `hourly.sea_surface_temperature`. We choose the
/// hour bucket whose centre is nearest to [target] (the API quantises
/// to whole hours; for "right now" at HH:30 either neighbour is fine)
/// and return both the temperature and the bucket's timestamp.
///
/// Temperature is in **°C** — caller converts to °F to match the
/// calculator's contract. Throws [FormatException] if the response
/// shape diverges (missing keys, mismatched array lengths, all-null
/// values).
OpenMeteoSstSample parseOpenMeteoSeaSurfaceTemp(
  Map<String, dynamic> body,
  DateTime target,
) {
  final hourly = body['hourly'];
  if (hourly is! Map<String, dynamic>) {
    throw const FormatException('Open-Meteo response missing `hourly` block');
  }
  final times = hourly['time'];
  final temps = hourly['sea_surface_temperature'];
  if (times is! List || temps is! List) {
    throw const FormatException(
      'Open-Meteo `hourly.time` or `sea_surface_temperature` is not an array',
    );
  }
  if (times.length != temps.length) {
    throw const FormatException(
      'Open-Meteo time/temp arrays have different lengths',
    );
  }
  if (times.isEmpty) {
    throw const FormatException('Open-Meteo response carried no samples');
  }

  // Walk the array once and pick the index minimising |t - target|
  // while skipping nulls. Open-Meteo returns null for hours past the
  // forecast horizon and (rarely) for QC'd-out samples.
  var bestIdx = -1;
  var bestDelta = Duration.zero;
  DateTime? bestTime;
  for (var i = 0; i < times.length; i++) {
    final tempRaw = temps[i];
    if (tempRaw == null) continue;
    final t =
        DateTime.tryParse('${times[i]}Z') ?? DateTime.tryParse('${times[i]}');
    if (t == null) continue;
    final delta = t.difference(target).abs();
    if (bestIdx < 0 || delta < bestDelta) {
      bestIdx = i;
      bestDelta = delta;
      bestTime = t;
    }
  }
  if (bestIdx < 0 || bestTime == null) {
    throw const FormatException(
      'Open-Meteo response had no non-null SST samples',
    );
  }
  final temp = temps[bestIdx];
  if (temp is! num) {
    throw const FormatException(
      'Open-Meteo sea_surface_temperature was not numeric',
    );
  }
  return OpenMeteoSstSample(tempC: temp.toDouble(), observedAt: bestTime);
}
