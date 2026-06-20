class Helpers {
  static String formatLiters(double liters) {
    return '${liters.toStringAsFixed(1)}L';
  }

  static String formatMl(double ml) {
    return '${ml.toStringAsFixed(0)}ml';
  }

  static String formatTimeOfDay(DateTime dateTime) {
    final hour = dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:$minute $period';
  }
}
