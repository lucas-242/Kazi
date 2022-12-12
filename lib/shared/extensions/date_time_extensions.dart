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

  /// Find the next [weekday]. [weekday] can 0 for Sunday, 1 for Monday, etc. up to 7 for Sunday.
  DateTime nextWeekday(int weekday) {
    final result =
        add(Duration(days: (weekday - this.weekday) % DateTime.daysPerWeek));

    return result;
  }

  /// Find the last [weekday]. [weekday] can be 0 for Sunday, 1 for Monday, etc. up to 7 for Sunday.
  DateTime lastWeekday(int weekday) =>
      DateTime(year, month, day - (this.weekday - weekday) % 7);
}
