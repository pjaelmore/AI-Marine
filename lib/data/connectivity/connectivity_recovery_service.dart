import 'dart:async';

import 'connectivity_watcher.dart';

/// Detects offline → online transitions and broadcasts a
/// "recovery needed" signal — TDD §11.5.
///
/// The service deliberately doesn't run recovery actions itself.
/// Subscribers wire what to do: the EvictionService can sweep stale
/// rows that accumulated during the outage, the conditions UI can
/// refetch its panel, future sync code (v1.5+) can drain its queue.
/// Decoupling here keeps the service stable as recovery actions
/// accumulate.
///
/// Two streams are exposed:
///   - [isOnline] mirrors the watcher's stream as a broadcast for
///     UI components that want a live offline indicator.
///   - [onRestored] emits exactly once per offline→online transition.
///     A `true` event after another `true` (e.g. wifi→mobile handoff
///     while still online) is filtered out — that's not a recovery,
///     just a connectivity-type change.
class ConnectivityRecoveryService {
  ConnectivityRecoveryService({required ConnectivityWatcher watcher})
      : _watcher = watcher,
        _onlineController = StreamController<bool>.broadcast(),
        _restoredController = StreamController<void>.broadcast();

  final ConnectivityWatcher _watcher;
  final StreamController<bool> _onlineController;
  final StreamController<void> _restoredController;

  StreamSubscription<bool>? _sub;
  bool? _lastObserved;

  /// Begins watching. Idempotent — repeated calls reuse the same
  /// subscription so a forgotten start() doesn't double-listen.
  void start() {
    if (_sub != null) return;
    _sub = _watcher.isOnline.listen(_handleChange);
  }

  Stream<bool> get isOnline => _onlineController.stream;
  Stream<void> get onRestored => _restoredController.stream;

  Future<void> dispose() async {
    await _sub?.cancel();
    _sub = null;
    await _watcher.dispose();
    await _onlineController.close();
    await _restoredController.close();
  }

  void _handleChange(bool online) {
    _onlineController.add(online);
    final previous = _lastObserved;
    _lastObserved = online;
    if (online && previous == false) {
      _restoredController.add(null);
    }
  }
}
