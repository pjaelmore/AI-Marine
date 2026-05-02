import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// Initialises Sentry per TDD §11.4.
///
/// The DSN is supplied at build time via `--dart-define=SENTRY_DSN=...`. When
/// the DSN is empty (the default for local development), the Sentry SDK
/// silently no-ops — `init` still runs, hooks are still installed, but no
/// events leave the device. This means the same code path is exercised in
/// dev and prod, and forgetting the dart-define won't crash the app.
///
/// All events flow through [stripPotentialPii] in `beforeSend` so that
/// diagnostic context attached by adapters (lat/lon, source IDs) cannot leak
/// user-identifying precision off the device.
///
/// Run [appRunner] inside Sentry's zone so unhandled async errors are
/// captured automatically.
Future<void> initSentry({required FutureOr<void> Function() appRunner}) {
  return SentryFlutter.init(
    (options) {
      options.dsn = const String.fromEnvironment('SENTRY_DSN');
      options.tracesSampleRate = 0.1;
      options.environment =
          kReleaseMode ? 'release' : (kProfileMode ? 'profile' : 'debug');
      options.beforeSend = _beforeSend;
    },
    appRunner: appRunner,
  );
}

FutureOr<SentryEvent?> _beforeSend(SentryEvent event, Hint hint) {
  // TDD §11.4 specifies sanitising via `event.extra`. Sentry SDK 8.x
  // deprecates `extra` in favour of structured `contexts`; migration is
  // tracked as a follow-up so the spec and call-sites move together.
  // ignore: deprecated_member_use
  final extra = event.extra;
  if (extra == null || extra.isEmpty) return event;
  // ignore: deprecated_member_use
  return event.copyWith(extra: stripPotentialPii(extra));
}

/// Identifier-shaped keys whose values are dropped outright before send.
const Set<String> _piiDropKeys = {
  'email',
  'useremail',
  'userid',
  'user_id',
  'username',
  'name',
  'deviceid',
  'device_id',
  'notes',
  'comment',
  'comments',
  'freetext',
  'free_text',
};

/// Coordinate-shaped keys whose numeric values are rounded to 0.1° (~11 km)
/// so location context remains useful for diagnosis without identifying a
/// specific dock, ramp, or fishing spot.
const Set<String> _piiCoordKeys = {
  'lat',
  'latitude',
  'lon',
  'lng',
  'longitude',
};

/// Sanitises a Sentry `extra` map.
///
/// Identifier-shaped keys (see [_piiDropKeys]) are removed. Coordinate-shaped
/// keys (see [_piiCoordKeys]) have numeric values rounded to 0.1° and
/// non-numeric values dropped. Everything else passes through unchanged.
@visibleForTesting
Map<String, dynamic> stripPotentialPii(Map<String, dynamic> extra) {
  final out = <String, dynamic>{};
  extra.forEach((key, value) {
    final lower = key.toLowerCase();
    if (_piiDropKeys.contains(lower)) return;
    if (_piiCoordKeys.contains(lower)) {
      if (value is num) {
        out[key] = (value * 10).round() / 10;
      }
      return;
    }
    out[key] = value;
  });
  return out;
}

/// Sends a test event to Sentry so the reporting pipeline can be verified
/// end-to-end after first install. Debug builds only — production callers
/// see no event sent and no exception thrown.
///
/// Used during Phase 1 setup (Implementation Guide §2.2.2 task 4).
Future<void> triggerSentryTestEvent() async {
  if (!kDebugMode) return;
  await Sentry.captureException(
    Exception('AI Marine Engine — Sentry pipeline test event'),
    stackTrace: StackTrace.current,
  );
}
