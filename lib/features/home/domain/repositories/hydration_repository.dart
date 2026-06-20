abstract class HydrationRepository {
  Future<double> getDailyGoal();
  Future<double> getTodayHydratedAmount();
  Future<void> logWater(double amountMl);
  Future<void> deleteLog(String logId);
}
