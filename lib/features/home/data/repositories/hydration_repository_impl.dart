import '../../domain/repositories/hydration_repository.dart';

class HydrationRepositoryImpl implements HydrationRepository {
  double _todayAmount = 0.0;
  final double _dailyGoal = 2500.0; // 2.5L in ml

  @override
  Future<double> getDailyGoal() async {
    return _dailyGoal;
  }

  @override
  Future<double> getTodayHydratedAmount() async {
    return _todayAmount;
  }

  @override
  Future<void> logWater(double amountMl) async {
    _todayAmount += amountMl;
  }

  @override
  Future<void> deleteLog(String logId) async {
    // Stub
  }
}
