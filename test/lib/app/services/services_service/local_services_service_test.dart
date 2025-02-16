import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/app/models/enums.dart';
import 'package:kazi/app/models/service.dart';
import 'package:kazi/app/models/service_group_by_date.dart';
import 'package:kazi/app/services/services_service/local/local_services_service.dart';
import 'package:kazi/app/services/services_service/services_service.dart';
import 'package:kazi/app/services/time_service/local/local_time_service.dart';
import 'package:kazi/app/services/time_service/time_service.dart';
import 'package:kazi/app/shared/extensions/extensions.dart';

import '../../../../mocks/mocks.dart';

void main() {
  late TimeService timeService;
  late ServicesService servicesService;

  setUp(() {
    timeService = LocalTimeService(DateTime(2023));
    servicesService = LocalServicesService(timeService);
  });

  group('Get range date by FastSearch', () {
    Map<String, DateTime> getExpected(DateTime startDate, DateTime endDate) => {
          'startDate': startDate,
          'endDate': endDate,
        };

    test('Should get range for Last Month', () {
      final result =
          servicesService.getRangeDateByFastSearch(FastSearch.lastMonth);

      expect(result,
          getExpected(DateTime(2022, 12), DateTime(2022, 12, 31, 23, 59, 59)),);
    });

    test('Should get range for Month', () {
      final result = servicesService.getRangeDateByFastSearch(FastSearch.month);

      expect(
        result,
        getExpected(
          servicesService.now,
          servicesService.now
              .copyWith(day: 31, hour: 23, minute: 59, second: 59),
        ),
      );
    });

    test('Should get range for First Fortnight', () {
      final result =
          servicesService.getRangeDateByFastSearch(FastSearch.fortnight);

      expect(
        result,
        getExpected(
          servicesService.now,
          servicesService.now
              .copyWith(day: 15, hour: 23, minute: 59, second: 59),
        ),
      );
    });

    test('Should get range for Last Fortnight', () {
      //HERE servicesService.now.copyWith(day: 17)
      servicesService = LocalServicesService(
          LocalTimeService(servicesService.now.copyWith(day: 17)),);
      final result =
          servicesService.getRangeDateByFastSearch(FastSearch.fortnight);

      expect(
        result,
        getExpected(
          servicesService.now.copyWith(day: 16),
          servicesService.now
              .copyWith(day: 31, hour: 23, minute: 59, second: 59),
        ),
      );
    });

    test('Should get range for Week', () {
      final result = servicesService.getRangeDateByFastSearch(FastSearch.week);

      expect(
        result,
        getExpected(
          servicesService.now.lastWeekday(DateTime.sunday),
          servicesService.now
              .copyWith(hour: 23, minute: 59, second: 59)
              .nextWeekday(DateTime.saturday),
        ),
      );
    });

    test('Should get range for Today', () {
      final result = servicesService.getRangeDateByFastSearch(FastSearch.today);

      expect(
        result,
        getExpected(
          servicesService.now,
          servicesService.now.copyWith(hour: 23, minute: 59, second: 59),
        ),
      );
    });
  });

  group('Get Services by Date', () {
    late List<Service> services;
    late List<ServicesGroupByDate> expected;

    setUpAll(() {
      services = [
        serviceMock.copyWith(date: DateTime(2022, 12, 7)),
        serviceMock.copyWith(date: DateTime(2022, 12, 13)),
        serviceMock.copyWith(date: DateTime(2023)),
        serviceMock.copyWith(date: DateTime(2022, 12, 31)),
        serviceMock.copyWith(date: DateTime(2022, 12, 7)),
        serviceMock.copyWith(date: DateTime(2023)),
        serviceMock.copyWith(date: DateTime(2022, 12, 13)),
      ];

      expected = [
        ServicesGroupByDate(
          isExpanded: true,
          date: DateTime(2023),
          services: [
            serviceMock.copyWith(date: DateTime(2023)),
            serviceMock.copyWith(date: DateTime(2023)),
          ],
        ),
        ServicesGroupByDate(
          date: DateTime(2022, 12, 31),
          services: [
            serviceMock.copyWith(date: DateTime(2022, 12, 31)),
          ],
        ),
        ServicesGroupByDate(
          date: DateTime(2022, 12, 13),
          services: [
            serviceMock.copyWith(date: DateTime(2022, 12, 13)),
            serviceMock.copyWith(date: DateTime(2022, 12, 13)),
          ],
        ),
        ServicesGroupByDate(
          date: DateTime(2022, 12, 7),
          services: [
            serviceMock.copyWith(date: DateTime(2022, 12, 7)),
            serviceMock.copyWith(date: DateTime(2022, 12, 7)),
          ],
        ),
      ];
    });

    test(
      'Should group services by date ordered by date Desc',
      () {
        final result =
            servicesService.groupServicesByDate(services, OrderBy.dateDesc);

        expect(result, expected);
      },
    );

    test('Should group services by date ordered by date Asc', () {
      expected = expected.reversed.toList();
      expected.last = expected.last.copyWith(isExpanded: false);
      expected.first = expected.first.copyWith(isExpanded: true);

      final result =
          servicesService.groupServicesByDate(services, OrderBy.dateAsc);

      expect(result, expected);
    });
  });
}
