import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/app/services/time_service/local/local_time_service.dart';
import 'package:kazi/app/services/time_service/time_service.dart';

void main() {
  late TimeService timeService;

  setUp(() {
    timeService = LocalTimeService();
  });

  test('Should return DateTime without time', () {
    timeService = LocalTimeService(DateTime(2022, 12, 26, 11, 39, 46));
    expect(timeService.now, DateTime(2022, 12, 26));
  });

  test('Should return fixed DateTime', () {
    final date = DateTime(2022, 12, 26);
    timeService = LocalTimeService(date);
    expect(timeService.now, date);
  });

  group('Should check if date range is between Last Month', () {
    test('Should return true', () {
      timeService = LocalTimeService(DateTime(2023, 04, 29, 11, 39, 46));
      final startDate = DateTime(2023, 03, 08, 00, 59, 59);
      final endDate = DateTime(2023, 03, 30, 23, 59, 59);
      final result = timeService.isRangeInLastMonth(startDate, endDate);
      expect(result, true);
    });

    test('Should return false', () {
      timeService = LocalTimeService(DateTime(2023, 04, 29, 11, 39, 46));
      final startDate = DateTime(2023, 02, 28, 23, 59, 59);
      final endDate = DateTime(2023, 03, 30, 23, 59, 59);
      final result = timeService.isRangeInLastMonth(startDate, endDate);
      expect(result, false);
    });
  });

  group('Should check if date range is between the current Month', () {
    test('Should return true', () {
      timeService = LocalTimeService(DateTime(2023, 04, 29, 11, 39, 46));
      final startDate = DateTime(2023, 04, 08, 00, 59, 59);
      final endDate = DateTime(2023, 04, 30, 23, 59, 59);
      final result = timeService.isRangeInThisMonth(startDate, endDate);
      expect(result, true);
    });

    test('Should return false', () {
      timeService = LocalTimeService(DateTime(2023, 04, 29, 11, 39, 46));
      final startDate = DateTime(2023, 03, 28, 23, 59, 59);
      final endDate = DateTime(2023, 04, 30, 23, 59, 59);
      final result = timeService.isRangeInThisMonth(startDate, endDate);
      expect(result, false);
    });
  });
}
