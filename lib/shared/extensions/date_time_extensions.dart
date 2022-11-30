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

  DateTime next(int day) {
    final result = add(Duration(days: (day - weekday) % DateTime.daysPerWeek));

    return result;
  }

  /// The [weekday] may be 0 for Sunday, 1 for Monday, etc. up to 7 for Sunday.
  DateTime mostRecentWeekday(int weekday) =>
      DateTime(year, month, day - (this.weekday - weekday) % 7);
}
