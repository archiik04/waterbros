import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsState {
  final ThemeMode themeMode;
  final bool enableNotifications;
  final double dailyGoalLiters;

  const SettingsState({
    required this.themeMode,
    required this.enableNotifications,
    required this.dailyGoalLiters,
  });

  SettingsState copyWith({
    ThemeMode? themeMode,
    bool? enableNotifications,
    double? dailyGoalLiters,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      enableNotifications: enableNotifications ?? this.enableNotifications,
      dailyGoalLiters: dailyGoalLiters ?? this.dailyGoalLiters,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier()
      : super(const SettingsState(
          themeMode: ThemeMode.system,
          enableNotifications: true,
          dailyGoalLiters: 2.5,
        ));

  void toggleTheme(ThemeMode mode) {
    state = state.copyWith(themeMode: mode);
  }

  void toggleNotifications(bool enable) {
    state = state.copyWith(enableNotifications: enable);
  }

  void updateDailyGoal(double goal) {
    state = state.copyWith(dailyGoalLiters: goal);
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier();
});
