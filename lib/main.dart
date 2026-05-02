import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/logging/sentry_setup.dart';

Future<void> main() async {
  await initSentry(
    appRunner: () => runApp(const ProviderScope(child: AiMarineApp())),
  );
}
