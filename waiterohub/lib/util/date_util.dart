class DateUtils {
  static DateTime getTodaysDate() {
    final DateTime all = DateTime.now();
    final int year = all.year, month = all.month, day = all.day;
    return DateTime(year, month, day);
  }

  static DateTime getMonthDate() {
    final DateTime all = DateTime.now();
    final int year = all.year, month = all.month;
    return DateTime(year, month);
  }
}
