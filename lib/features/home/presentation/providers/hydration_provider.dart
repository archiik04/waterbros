import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/hydration_repository_impl.dart';
import '../../domain/repositories/hydration_repository.dart';

class HydrationState {
  final double currentMl;
  final double goalMl;
  final List<WaterLog> todayLogs;

  const HydrationState({
    required this.currentMl,
    required this.goalMl,
    required this.todayLogs,
  });

  HydrationState copyWith({
    double? currentMl,
    double? goalMl,
    List<WaterLog>? todayLogs,
  }) {
    return HydrationState(
      currentMl: currentMl ?? this.currentMl,
      goalMl: goalMl ?? this.goalMl,
      todayLogs: todayLogs ?? this.todayLogs,
    );
  }
}

class WaterLog {
  final String id;
  final double amountMl;
  final DateTime time;

  const WaterLog({
    required this.id,
    required this.amountMl,
    required this.time,
  });
}

class HydrationNotifier extends StateNotifier<HydrationState> {
  final HydrationRepository _repository;

  HydrationNotifier(this._repository)
      : super(const HydrationState(currentMl: 0, goalMl: 2500, todayLogs: []));

  Future<void> init() async {
    final current = await _repository.getTodayHydratedAmount();
    final goal = await _repository.getDailyGoal();
    state = HydrationState(currentMl: current, goalMl: goal, todayLogs: []);
  }

  Future<void> logWater(double amountMl) async {
    await _repository.logWater(amountMl);
    final current = await _repository.getTodayHydratedAmount();
    final newLog = WaterLog(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      amountMl: amountMl,
      time: DateTime.now(),
    );
    state = state.copyWith(
      currentMl: current,
      todayLogs: [newLog, ...state.todayLogs],
    );
  }

  void deleteLog(String id) {
    final log = state.todayLogs.firstWhere((element) => element.id == id);
    state = state.copyWith(
      currentMl: (state.currentMl - log.amountMl).clamp(0, double.infinity),
      todayLogs: state.todayLogs.where((element) => element.id != id).toList(),
    );
  }
}

final hydrationRepositoryProvider = Provider<HydrationRepository>((ref) {
  return HydrationRepositoryImpl();
});

final hydrationProvider = StateNotifierProvider<HydrationNotifier, HydrationState>((ref) {
  final repo = ref.watch(hydrationRepositoryProvider);
  final notifier = HydrationNotifier(repo);
  notifier.init();
  return notifier;
});
