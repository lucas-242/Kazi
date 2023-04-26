import 'package:flutter_test/flutter_test.dart';
import 'package:my_services/app/models/enums.dart';
import 'package:my_services/app/services/time_service/time_service.dart';
import 'package:my_services/app/shared/extensions/extensions.dart';
import 'package:my_services/app/shared/utils/service_helper.dart';

void main() {
  late TimeService timeService;
  group('Get range date by FastSearch', () {
    setUp(() {
      timeService = LocalTimeService(DateTime(2023));
    });

    Map<String, DateTime> getExpected(DateTime startDate, DateTime endDate) => {
          'startDate': startDate,
          'endDate': endDate,
        };

    test('Should get range for Last Month', () {
      final result = ServiceHelper.getRangeDateByFastSearch(
          FastSearch.lastMonth, timeService.now);

      expect(result,
          getExpected(DateTime(2022, 12), DateTime(2022, 12, 31, 23, 59, 59)));
    });

    test('Should get range for Month', () {
      final result = ServiceHelper.getRangeDateByFastSearch(
          FastSearch.month, timeService.now);

      expect(
        result,
        getExpected(
          timeService.now,
          timeService.now.copyWith(day: 31, hour: 23, minute: 59, second: 59),
        ),
      );
    });

    test('Should get range for First Fortnight', () {
      final result = ServiceHelper.getRangeDateByFastSearch(
          FastSearch.fortnight, timeService.now);

      expect(
        result,
        getExpected(
          timeService.now,
          timeService.now.copyWith(day: 15, hour: 23, minute: 59, second: 59),
        ),
      );
    });

    test('Should get range for Last Fortnight', () {
      final result = ServiceHelper.getRangeDateByFastSearch(
          FastSearch.fortnight, timeService.now.copyWith(day: 17));

      expect(
        result,
        getExpected(
          timeService.now.copyWith(day: 16),
          timeService.now.copyWith(day: 31, hour: 23, minute: 59, second: 59),
        ),
      );
    });

    test('Should get range for Week', () {
      final result = ServiceHelper.getRangeDateByFastSearch(
          FastSearch.week, timeService.now);

      expect(
        result,
        getExpected(
          timeService.now.lastWeekday(DateTime.sunday),
          timeService.now
              .copyWith(hour: 23, minute: 59, second: 59)
              .nextWeekday(DateTime.saturday),
        ),
      );
    });

    test('Should get range for Today', () {
      final result = ServiceHelper.getRangeDateByFastSearch(
          FastSearch.today, timeService.now);

      expect(
        result,
        getExpected(
          timeService.now,
          timeService.now.copyWith(hour: 23, minute: 59, second: 59),
        ),
      );
    });
  });
}
