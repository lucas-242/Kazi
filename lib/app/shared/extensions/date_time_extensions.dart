extension DateTimeExtension on DateTime {
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }

  DateTime get firstHourOfDay =>
      copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);

  DateTime get lastHourOfDay => copyWith(
      hour: 23, minute: 59, second: 59, millisecond: 0, microsecond: 0);

  /// Find the next [weekday]. [weekday] can 0 for Sunday, 1 for Monday, etc. up to 7 for Sunday.
  DateTime nextWeekday(int weekday) {
    final result =
        add(Duration(days: (weekday - this.weekday) % DateTime.daysPerWeek));

    return result;
  }

  /// Find the last [weekday]. [weekday] can be 0 for Sunday, 1 for Monday, etc. up to 7 for Sunday.
  DateTime lastWeekday(int weekday) =>
      DateTime(year, month, day - (this.weekday - weekday) % 7);

  /// Returns the difference (in full days) between the provided [date]
  int calculateDifference(DateTime date) => DateTime(year, month, day)
      .difference(DateTime(date.year, date.month, date.day))
      .inDays;
}
