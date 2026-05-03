import '../../core/types/condition_result.dart';
import '../../core/types/lat_lng.dart';

/// Common interface for every external-data adapter — TDD §5.1.
///
/// Concrete adapters wrap one NOAA endpoint (NDBC buoys, Tides & Currents,
/// NWS marine forecast, etc.) or a local computation (solunar). The
/// Conditions Service composes them through [SourceRegistry] so the engine
/// never talks to a specific endpoint directly.
abstract class SourceAdapter<T> {
  /// Identifier matching the [DataSource] enum value this adapter serves.
  /// The Conditions Service uses this on the resulting [ConditionResult] so
  /// the UI's mode indicator (TDD §10.2.4) can attribute the value.
  DataSource get sourceId;

  /// Whether this adapter can plausibly serve a value for the given query.
  ///
  /// Implementations typically check geographic coverage (does a bundled
  /// station list have a station within the threshold radius?) and time
  /// validity (is the requested time in the supported window?). The
  /// registry skips adapters that return false without invoking [fetch].
  bool canServe(LatLng location, DateTime time);

  /// Fetch and parse a value. May throw [SourceException] on retriable
  /// or terminal failures; the registry catches those and falls through
  /// to the next adapter or returns `unavailable`. Successful returns
  /// always carry a fully-populated [ConditionResult] with provenance.
  Future<ConditionResult<T>> fetch(LatLng location, DateTime time);

  /// How long values from this source remain considered fresh by the
  /// cache layer. Live-API sources are short; deterministic ones (tide
  /// predictions) can be much longer.
  Duration get defaultTtl;
}

/// Adapter-side failure that the registry should treat as "try the next
/// candidate." [TDD §5.7](§5.7) shows the registry catching this; §5.8
/// classifies the underlying causes (network timeouts, 5xx responses,
/// malformed payloads).
class SourceException implements Exception {
  const SourceException(this.message, {this.source, this.cause});

  /// Human-readable cause; surfaces to Sentry via the registry, not the UI.
  final String message;

  /// Which adapter produced this — helps triage in Sentry's source filter.
  final DataSource? source;

  /// Underlying error if any (e.g. a `DioException`, `FormatException`).
  final Object? cause;

  @override
  String toString() {
    final src = source == null ? '' : ' [${source!.name}]';
    return 'SourceException$src: $message${cause == null ? '' : ' (cause: $cause)'}';
  }
}
