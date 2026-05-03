import 'package:ai_marine_engine/data/cache/hot_cache.dart';
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
  group('HotCache — basic CRUD', () {
    test('put + get round-trips a value', () {
      final cache = HotCache();
      cache.put('temp:42.36,-70.55', 62.5);
      expect(cache.get('temp:42.36,-70.55'), 62.5);
    });

    test('get on a missing key returns null', () {
      final cache = HotCache();
      expect(cache.get('nope'), isNull);
    });

    test('put with a null value still registers the key', () {
      final cache = HotCache();
      cache.put('marker', null);
      expect(cache.get('marker'), isNull);
      // size proves the key is present even though value is null.
      expect(cache.size, 1);
    });

    test('size reports current entry count', () {
      final cache = HotCache()
        ..put('a', 1)
        ..put('b', 2);
      expect(cache.size, 2);
    });

    test('clear empties every entry and resets the idle timer', () {
      final cache = HotCache()
        ..put('a', 1)
        ..put('b', 2);
      cache.clear();
      expect(cache.size, 0);
      expect(cache.get('a'), isNull);
    });
  });

  group('HotCache — idle-timeout eviction', () {
    test('idle clear fires after the configured window has elapsed', () {
      final clock = _ManualClock(DateTime.utc(2026, 5, 22, 18));
      final cache = HotCache(
        idleTimeout: const Duration(minutes: 30),
        clock: clock,
      );
      cache.put('a', 1);

      // 31 minutes pass without any access — the next operation should
      // observe the idle clear.
      clock.advance(const Duration(minutes: 31));
      expect(cache.get('a'), isNull);
      expect(cache.size, 0);
    });

    test('a put inside the window resets the idle timer', () {
      final clock = _ManualClock(DateTime.utc(2026, 5, 22, 18));
      final cache = HotCache(
        idleTimeout: const Duration(minutes: 30),
        clock: clock,
      );
      cache.put('a', 1);

      clock.advance(const Duration(minutes: 25));
      cache.put('b', 2); // resets the timer

      clock.advance(const Duration(minutes: 25));
      // We're 50 min past the original put but only 25 min past the most
      // recent access; entries should still be present.
      expect(cache.get('a'), 1);
      expect(cache.get('b'), 2);
    });

    test('a get inside the window resets the idle timer', () {
      final clock = _ManualClock(DateTime.utc(2026, 5, 22, 18));
      final cache = HotCache(
        idleTimeout: const Duration(minutes: 30),
        clock: clock,
      );
      cache.put('a', 1);

      clock.advance(const Duration(minutes: 25));
      cache.get('a'); // resets the timer

      clock.advance(const Duration(minutes: 25));
      expect(cache.get('a'), 1);
    });

    test('a never-touched cache does not error on time advance', () {
      final clock = _ManualClock(DateTime.utc(2026, 5, 22, 18));
      final cache = HotCache(clock: clock);
      clock.advance(const Duration(hours: 24));
      expect(cache.get('whatever'), isNull);
      expect(cache.size, 0);
    });
  });

  group('HotCache.getAs<T>', () {
    test('returns the value when it matches T', () {
      final cache = HotCache()..put('temp', 62.5);
      expect(cache.getAs<double>('temp'), 62.5);
    });

    test('returns null on type mismatch instead of throwing', () {
      final cache = HotCache()..put('temp', 'not a number');
      expect(cache.getAs<double>('temp'), isNull);
    });

    test('returns null for a missing key', () {
      final cache = HotCache();
      expect(cache.getAs<int>('absent'), isNull);
    });
  });
}
