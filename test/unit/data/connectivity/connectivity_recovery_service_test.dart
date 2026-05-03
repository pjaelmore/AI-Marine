import 'dart:async';

import 'package:ai_marine_engine/data/connectivity/connectivity_recovery_service.dart';
import 'package:ai_marine_engine/data/connectivity/connectivity_watcher.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeWatcher implements ConnectivityWatcher {
  final _ctrl = StreamController<bool>.broadcast();
  bool _checkResult = false;
  bool disposed = false;

  void emit(bool online) => _ctrl.add(online);

  void seedCheckResult(bool online) => _checkResult = online;

  @override
  Stream<bool> get isOnline => _ctrl.stream;

  @override
  Future<bool> checkNow() async => _checkResult;

  @override
  Future<void> dispose() async {
    disposed = true;
    await _ctrl.close();
  }
}

void main() {
  group('ConnectivityRecoveryService', () {
    test('forwards every state change to isOnline as a broadcast stream',
        () async {
      final watcher = _FakeWatcher();
      final svc = ConnectivityRecoveryService(watcher: watcher)..start();
      addTearDown(svc.dispose);

      final received = <bool>[];
      svc.isOnline.listen(received.add);

      watcher.emit(false);
      watcher.emit(true);
      watcher.emit(false);
      await Future<void>.delayed(Duration.zero);

      expect(received, [false, true, false]);
    });

    test('onRestored fires exactly once per offline→online transition',
        () async {
      final watcher = _FakeWatcher();
      final svc = ConnectivityRecoveryService(watcher: watcher)..start();
      addTearDown(svc.dispose);

      var restoredCount = 0;
      svc.onRestored.listen((_) => restoredCount++);

      watcher.emit(false);
      watcher.emit(true); // restoration #1
      watcher.emit(false);
      watcher.emit(true); // restoration #2
      await Future<void>.delayed(Duration.zero);

      expect(restoredCount, 2);
    });

    test(
      'consecutive online events do not fire onRestored '
      '(wifi→mobile handoff is not a recovery)',
      () async {
        final watcher = _FakeWatcher();
        final svc = ConnectivityRecoveryService(watcher: watcher)..start();
        addTearDown(svc.dispose);

        var restoredCount = 0;
        svc.onRestored.listen((_) => restoredCount++);

        watcher.emit(false);
        watcher.emit(true); // counts
        watcher.emit(true); // already online — no event
        watcher.emit(true); // still online — no event
        await Future<void>.delayed(Duration.zero);

        expect(restoredCount, 1);
      },
    );

    test(
      'an initial true does not fire onRestored '
      '(no prior offline observation)',
      () async {
        // App launched while online — no recovery needed even though
        // the very first event is true.
        final watcher = _FakeWatcher();
        final svc = ConnectivityRecoveryService(watcher: watcher)..start();
        addTearDown(svc.dispose);

        var restoredCount = 0;
        svc.onRestored.listen((_) => restoredCount++);

        watcher.emit(true);
        await Future<void>.delayed(Duration.zero);

        expect(restoredCount, 0);
      },
    );

    test('start() is idempotent — repeated calls do not double-subscribe',
        () async {
      final watcher = _FakeWatcher();
      final svc = ConnectivityRecoveryService(watcher: watcher)
        ..start()
        ..start()
        ..start();
      addTearDown(svc.dispose);

      final received = <bool>[];
      svc.isOnline.listen(received.add);

      watcher.emit(true);
      await Future<void>.delayed(Duration.zero);

      expect(received, [true]);
    });

    test('dispose cancels the subscription and disposes the watcher', () async {
      final watcher = _FakeWatcher();
      final svc = ConnectivityRecoveryService(watcher: watcher)..start();

      await svc.dispose();
      expect(watcher.disposed, isTrue);
    });
  });
}
