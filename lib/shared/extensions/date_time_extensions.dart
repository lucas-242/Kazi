extension DateTimeExtension on DateTime {
  DateTime next(int day) {
    final result = add(Duration(days: (day - weekday) % DateTime.daysPerWeek));

    return result;
  }

  /// The [weekday] may be 0 for Sunday, 1 for Monday, etc. up to 7 for Sunday.
  DateTime mostRecentWeekday(int weekday) =>
      DateTime(year, month, day - (this.weekday - weekday) % 7);
}
