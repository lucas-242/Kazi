import 'package:flutter_test/flutter_test.dart';
import 'package:my_services/services/time_service/time_service.dart';

void main() {
  late TimeService timeService;

  setUp(() {
    timeService = LocalTimeService();
  });

  test('Should return current DateTime', () {
    final now = DateTime.now();
    expect(timeService.now.year, equals(now.year));
    expect(timeService.now.month, equals(now.month));
    expect(timeService.now.day, equals(now.day));
    expect(timeService.now.hour, equals(now.hour));
    expect(timeService.now.minute, equals(now.minute));
  });

  test('Should return fixed DateTime', () {
    final date = DateTime(2022, 12, 26);
    timeService = LocalTimeService(date);
    expect(timeService.now, date);
  });

  test('Should return DateTime without time', () {
    timeService = LocalTimeService(DateTime(2022, 12, 26, 11, 39, 46));
    expect(timeService.nowWithoutTime, DateTime(2022, 12, 26));
  });
}
