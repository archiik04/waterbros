import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/router/router.dart';
import '../core/theme/theme.dart';
import '../features/settings/presentation/providers/settings_provider.dart';

class WaterBrosApp extends ConsumerWidget {
  const WaterBrosApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final settings = ref.watch(settingsProvider);

    return MaterialApp.router(
      title: 'WaterBros',
      theme: WaterBrosTheme.lightTheme,
      darkTheme: WaterBrosTheme.darkTheme,
      themeMode: settings.themeMode,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
