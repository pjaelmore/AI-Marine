/// Pluggable clock so tests can fast-forward the idle timer without
/// sleeping. The default [SystemClock] reads `DateTime.now().toUtc()`.
abstract class Clock {
  DateTime now();
}

class SystemClock implements Clock {
  const SystemClock();
  @override
  DateTime now() => DateTime.now().toUtc();
}

/// Tier 1 of the four-layer cache (TDD §2.1.4): an in-process map kept
/// for the duration of an active session.
///
/// The hot cache holds whatever the conditions service most recently
/// served — its job is to absorb redundant reads from the calculator's
/// score-grid loop, where every cell at the same time bucket asks for
/// the same water temp / tide phase / wind. Entries are typed `Object?`
/// so a single instance can serve all data shapes; callers retrieve via
/// [getAs] for a type-checked unwrap.
///
/// Eviction is whole-cache on idle: if no `get` or `put` happens within
/// [idleTimeout], the next access (or an explicit [clear]) flushes the
/// entire map. This matches the framework spec's "30 minutes idle" rule
/// (Phase 4 DoD §3.5) and the "app background" rule, which the app
/// shell wires up by calling [clear] from a lifecycle observer.
class HotCache {
  HotCache({
    Duration idleTimeout = const Duration(minutes: 30),
    Clock clock = const SystemClock(),
  })  : _idleTimeout = idleTimeout,
        _clock = clock;

  final Duration _idleTimeout;
  final Clock _clock;
  final Map<String, Object?> _entries = <String, Object?>{};

  /// Wall-clock timestamp of the most recent `put` or `get`. `null` when
  /// the cache has never been touched or was just cleared.
  DateTime? _lastAccessed;

  /// Inserts or replaces [value] at [key], stamping the access time.
  void put(String key, Object? value) {
    _maybeClearOnIdle();
    _entries[key] = value;
    _lastAccessed = _clock.now();
  }

  /// Returns the value at [key] (which may legitimately be `null`),
  /// updating the access time on a hit. A miss returns `null` and does
  /// not move the access time, so a string of misses against a stale
  /// cache will eventually trigger the idle clear on the first hit.
  Object? get(String key) {
    _maybeClearOnIdle();
    final present = _entries.containsKey(key);
    if (!present) return null;
    _lastAccessed = _clock.now();
    return _entries[key];
  }

  /// Type-checked unwrap. Returns `null` when the entry is missing or
  /// when its value is not a [T] — so a stale entry of the wrong type
  /// (after a refactor or schema bump) gracefully misses rather than
  /// crashing the caller.
  T? getAs<T>(String key) {
    final value = get(key);
    if (value is T) return value;
    return null;
  }

  /// Clears every entry. Called by the app shell on background, or
  /// implicitly when [_idleTimeout] elapses since the last access.
  void clear() {
    _entries.clear();
    _lastAccessed = null;
  }

  /// Number of currently-stored entries — useful in tests.
  int get size => _entries.length;

  void _maybeClearOnIdle() {
    final last = _lastAccessed;
    if (last == null) return;
    if (_clock.now().difference(last) > _idleTimeout) {
      clear();
    }
  }
}
