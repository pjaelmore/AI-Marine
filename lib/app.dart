import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ui/chart/chart_view_screen.dart';
import 'ui/design/theme.dart';

class AiMarineApp extends ConsumerWidget {
  const AiMarineApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'AI Marine Engine',
      theme: buildMarineTheme(),
      home: const ChartViewScreen(),
    );
  }
}
