import 'package:connectivity_plus/connectivity_plus.dart';

/// Pluggable connectivity source so the recovery service can be unit-
/// tested without `connectivity_plus`'s platform-channel calls (they
/// fail under flutter_test). Production wires
/// [ConnectivityPlusWatcher]; tests pass a fake with a controllable
/// stream.
abstract class ConnectivityWatcher {
  /// Emits the current online/offline state on every change.
  Stream<bool> get isOnline;

  /// One-shot probe — useful at startup before any change has been
  /// observed.
  Future<bool> checkNow();

  Future<void> dispose();
}

/// Concrete watcher backed by the `connectivity_plus` package. Treats
/// any non-`none` connectivity (wifi, mobile, ethernet, vpn) as
/// online; bluetooth-only is reported as offline since it can't reach
/// NOAA endpoints.
///
/// Not unit-tested by design — the wrapper is thin delegation to the
/// package. Integration coverage lands when the UI consumes it in
/// Phase 6.
class ConnectivityPlusWatcher implements ConnectivityWatcher {
  ConnectivityPlusWatcher() : _impl = Connectivity();

  final Connectivity _impl;

  @override
  Stream<bool> get isOnline => _impl.onConnectivityChanged.map(_isOnline);

  @override
  Future<bool> checkNow() async => _isOnline(await _impl.checkConnectivity());

  @override
  Future<void> dispose() async {}

  static bool _isOnline(List<ConnectivityResult> results) {
    return results.any(
      (r) =>
          r == ConnectivityResult.wifi ||
          r == ConnectivityResult.mobile ||
          r == ConnectivityResult.ethernet ||
          r == ConnectivityResult.vpn,
    );
  }
}
