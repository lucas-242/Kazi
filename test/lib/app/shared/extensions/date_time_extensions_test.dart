import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/app/shared/extensions/extensions.dart';

void main() {
  test('Should copyWith', () {
    final date = DateTime(2023, DateTime.january, 07);
    final result = date.copyWith(day: 09, minute: 14);

    expect(result.year, 2023);
    expect(result.month, DateTime.january);
    expect(result.day, 09);
    expect(result.hour, 0);
    expect(result.minute, 14);
    expect(result.second, 0);
    expect(result.millisecond, 0);
    expect(result.microsecond, 0);
  });

  test('Should return first hour of day', () {
    final date = DateTime(2023, DateTime.january, 07, 6, 14, 15, 9, 25);
    final result = date.firstHourOfDay;

    expect(result.year, 2023);
    expect(result.month, DateTime.january);
    expect(result.day, 07);
    expect(result.hour, 0);
    expect(result.minute, 0);
    expect(result.second, 0);
    expect(result.millisecond, 0);
    expect(result.microsecond, 0);
  });

  test('Should return last hour of day', () {
    final date = DateTime(2023, DateTime.january, 07, 6, 14, 15, 9, 25);
    final result = date.lastHourOfDay;

    expect(result.year, 2023);
    expect(result.month, DateTime.january);
    expect(result.day, 07);
    expect(result.hour, 23);
    expect(result.minute, 59);
    expect(result.second, 59);
    expect(result.millisecond, 0);
    expect(result.microsecond, 0);
  });

  test('Should find next weekday', () {
    final date = DateTime(2022, DateTime.december, 25);
    final result = date.nextWeekday(DateTime.wednesday);

    expect(result.weekday, DateTime.wednesday);
    expect(result.day, 28);
    expect(result.month, DateTime.december);
    expect(result.year, 2022);
  });

  test('Should find last weekday', () {
    final date = DateTime(2022, DateTime.december, 25);
    final result = date.lastWeekday(DateTime.wednesday);

    expect(result.weekday, DateTime.wednesday);
    expect(result.day, 21);
    expect(result.month, DateTime.december);
    expect(result.year, 2022);
  });
}
