import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Theme Mode'),
            subtitle: Text(settings.themeMode.toString().split('.').last.toUpperCase()),
            trailing: DropdownButton<ThemeMode>(
              value: settings.themeMode,
              onChanged: (ThemeMode? value) {
                if (value != null) {
                  ref.read(settingsProvider.notifier).toggleTheme(value);
                }
              },
              items: ThemeMode.values.map((ThemeMode mode) {
                return DropdownMenuItem<ThemeMode>(
                  value: mode,
                  child: Text(mode.toString().split('.').last.toUpperCase()),
                );
              }).toList(),
            ),
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('Daily Hydration Reminders'),
            subtitle: const Text('Get notified when it is time to drink water'),
            value: settings.enableNotifications,
            onChanged: (bool value) {
              ref.read(settingsProvider.notifier).toggleNotifications(value);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Daily Hydration Goal'),
            subtitle: Text('${settings.dailyGoalLiters.toStringAsFixed(1)} Liters'),
            trailing: SizedBox(
              width: 150,
              child: Slider(
                value: settings.dailyGoalLiters,
                min: 1.0,
                max: 5.0,
                divisions: 8,
                label: '${settings.dailyGoalLiters.toStringAsFixed(1)}L',
                onChanged: (double value) {
                  ref.read(settingsProvider.notifier).updateDailyGoal(value);
                },
              ),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Sign Out', style: TextStyle(color: Colors.red)),
            onTap: () {
              ref.read(authProvider.notifier).logout();
              // Auth redirects will trigger automatically thanks to Router redirect guard.
            },
          ),
        ],
      ),
    );
  }
}
