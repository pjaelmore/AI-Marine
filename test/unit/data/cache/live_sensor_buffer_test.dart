import 'package:ai_marine_engine/data/cache/hot_cache.dart' show Clock;
import 'package:ai_marine_engine/data/cache/live_sensor_buffer.dart';
import 'package:flutter_test/flutter_test.dart';

class _ManualClock implements Clock {
  _ManualClock(this._now);

  DateTime _now;

  @override
  DateTime now() => _now;

  void advance(Duration delta) {
    _now = _now.add(delta);
  }
}

void main() {
  group('LiveSensorBuffer — record + latest round-trip', () {
    test('latest returns the most recent reading within maxAge', () {
      final clock = _ManualClock(DateTime.utc(2026, 5, 22, 18));
      final buf = LiveSensorBuffer(clock: clock);
      buf.record(
        dataType: 'wind',
        value: 12.3,
        source: 'phone_anemometer',
      );
      clock.advance(const Duration(seconds: 5));
      final reading = buf.latest('wind', maxAge: const Duration(minutes: 1));
      expect(reading, isNotNull);
      expect(reading!.value, 12.3);
      expect(reading.source, 'phone_anemometer');
    });

    test('latest returns the newest of several readings of one type', () {
      final clock = _ManualClock(DateTime.utc(2026, 5, 22, 18));
      final buf = LiveSensorBuffer(clock: clock);
      buf.record(dataType: 'wind', value: 5.0, source: 's');
      clock.advance(const Duration(seconds: 1));
      buf.record(dataType: 'wind', value: 10.0, source: 's');
      clock.advance(const Duration(seconds: 1));
      buf.record(dataType: 'wind', value: 15.0, source: 's');
      expect(
        buf.latest('wind', maxAge: const Duration(seconds: 30))?.value,
        15.0,
      );
    });

    test('latest returns null when no readings of that type exist', () {
      final buf = LiveSensorBuffer();
      expect(
        buf.latest('water_temp', maxAge: const Duration(minutes: 5)),
        isNull,
      );
    });

    test('latest filters by data type — siblings do not leak', () {
      final clock = _ManualClock(DateTime.utc(2026, 5, 22, 18));
      final buf = LiveSensorBuffer(clock: clock);
      buf.record(dataType: 'wind', value: 12.0, source: 's');
      expect(
        buf.latest('water_temp', maxAge: const Duration(seconds: 30)),
        isNull,
      );
    });
  });

  group('LiveSensorBuffer — freshness window', () {
    test('latest returns null when newest reading is older than maxAge', () {
      final clock = _ManualClock(DateTime.utc(2026, 5, 22, 18));
      final buf = LiveSensorBuffer(clock: clock);
      buf.record(dataType: 'wind', value: 12.0, source: 's');
      clock.advance(const Duration(minutes: 10));
      // Caller wants a freshness window of 30s — the reading is stale.
      expect(
        buf.latest('wind', maxAge: const Duration(seconds: 30)),
        isNull,
      );
    });

    test('an exact-age reading is treated as fresh (boundary inclusive)', () {
      final clock = _ManualClock(DateTime.utc(2026, 5, 22, 18));
      final buf = LiveSensorBuffer(clock: clock);
      buf.record(dataType: 'wind', value: 12.0, source: 's');
      clock.advance(const Duration(seconds: 30));
      final reading = buf.latest('wind', maxAge: const Duration(seconds: 30));
      expect(
        reading,
        isNotNull,
        reason: '`difference > maxAge` excludes equals — keep boundary',
      );
    });
  });

  group('LiveSensorBuffer — ring-buffer overflow', () {
    test('dropping the oldest when capacity is exceeded', () {
      final clock = _ManualClock(DateTime.utc(2026, 5, 22, 18));
      final buf = LiveSensorBuffer(perTypeCapacity: 3, clock: clock);
      for (var i = 0; i < 5; i++) {
        buf.record(dataType: 'wind', value: i, source: 's');
        clock.advance(const Duration(seconds: 1));
      }
      // Capacity 3 → only the last three values (2, 3, 4) survive.
      expect(buf.sizeOf('wind'), 3);
      final readings = buf.recent('wind', window: const Duration(hours: 1));
      expect(readings.map((r) => r.value).toList(), <Object?>[2, 3, 4]);
    });
  });

  group('LiveSensorBuffer — recent window', () {
    test('recent returns only readings within the window, oldest first', () {
      final clock = _ManualClock(DateTime.utc(2026, 5, 22, 18));
      final buf = LiveSensorBuffer(clock: clock);
      buf.record(dataType: 'pressure', value: 1015.0, source: 's');
      clock.advance(const Duration(minutes: 10));
      buf.record(dataType: 'pressure', value: 1014.0, source: 's');
      clock.advance(const Duration(minutes: 10));
      buf.record(dataType: 'pressure', value: 1013.0, source: 's');

      // Now is 20 min after first reading, 10 min after second, 0 after third.
      final last15 =
          buf.recent('pressure', window: const Duration(minutes: 15));
      expect(last15.map((r) => r.value).toList(), <Object?>[1014.0, 1013.0]);
    });

    test('recent returns empty when nothing has been recorded', () {
      final buf = LiveSensorBuffer();
      expect(buf.recent('wind', window: const Duration(hours: 1)), isEmpty);
    });
  });

  group('LiveSensorBuffer — clear', () {
    test('clear empties every per-type buffer', () {
      final buf = LiveSensorBuffer();
      buf.record(dataType: 'wind', value: 12.0, source: 's');
      buf.record(dataType: 'pressure', value: 1015.0, source: 's');
      buf.clear();
      expect(buf.sizeOf('wind'), 0);
      expect(buf.sizeOf('pressure'), 0);
      expect(
        buf.latest('wind', maxAge: const Duration(minutes: 5)),
        isNull,
      );
    });
  });
}
