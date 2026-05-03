import 'dart:ffi';
import 'dart:io';

import 'package:sqlite3/open.dart';

/// Configures the sqlite3 native library lookup for host-side tests.
///
/// drift's `NativeDatabase` opens sqlite3 via `DynamicLibrary.open('sqlite3.dll')`
/// on Windows; the runner needs that file on its library search path. The
/// Flutter / Drift app bundles sqlite3 at build time via `sqlite3_flutter_libs`,
/// but that binary isn't visible to `flutter test` running in a host Dart VM.
///
/// On Linux/macOS the system libsqlite3 is universally present, so this is a
/// no-op (drift's default lookup finds it). On Windows we look in well-known
/// install locations — currently scoop's sqlite package — and override drift's
/// loader if found. Returns `null` on success, or a human-readable skip
/// reason if no sqlite3 was located so a calling test can `skip:` itself.
String? setupSqlite3() {
  if (!Platform.isWindows) return null;

  final candidates = <String>[
    if (Platform.environment['USERPROFILE'] != null) ...[
      '${Platform.environment['USERPROFILE']}\\scoop\\apps\\sqlite\\current\\sqlite3.dll',
      '${Platform.environment['USERPROFILE']}\\scoop\\shims\\sqlite3.dll',
    ],
    'C:\\Windows\\System32\\sqlite3.dll',
  ];

  for (final path in candidates) {
    if (File(path).existsSync()) {
      open.overrideFor(
        OperatingSystem.windows,
        () => DynamicLibrary.open(path),
      );
      return null;
    }
  }

  return 'sqlite3.dll not found on Windows host. '
      'Run `scoop install sqlite` to enable local DAO integration tests; '
      'CI runs on Linux where libsqlite3 is present system-wide.';
}
