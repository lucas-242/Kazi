import 'package:kazi/app/models/enums.dart';
import 'package:kazi/app/models/service.dart';
import 'package:kazi/app/models/service_group_by_date.dart';
import 'package:kazi/app/models/service_type.dart';
import 'package:kazi/app/services/services_service/services_service.dart';
import 'package:kazi/app/services/time_service/time_service.dart';
import 'package:kazi/app/shared/extensions/extensions.dart';

class LocalServicesService extends ServicesService {
  LocalServicesService(this._timeService);

  final TimeService _timeService;
  @override
  DateTime get now => _timeService.now;

  @override
  List<Service> addServiceTypeToServices(
      List<Service> services, List<ServiceType> serviceTypes) {
    final result = <Service>[];
    for (var service in services) {
      result.add(_fillServiceWithServiceType(service, serviceTypes));
    }
    return result;
  }

  Service _fillServiceWithServiceType(
      Service service, List<ServiceType> serviceTypes) {
    return service.copyWith(
        type: serviceTypes.firstWhere((st) => st.id == service.typeId));
  }

  @override
  List<Service> orderServices(List<Service> services, OrderBy orderBy) {
    switch (orderBy) {
      case OrderBy.dateAsc:
        return _sortWithTiebreaker(
          services,
          _compareDateAsc,
          _compareAlphabetical,
          _compareValueDesc,
        );
      case OrderBy.dateDesc:
        return _sortWithTiebreaker(
          services,
          _compareDateDesc,
          _compareAlphabetical,
          _compareValueDesc,
        );
      case OrderBy.alphabetical:
        return _sortWithTiebreaker(
          services,
          _compareAlphabetical,
          _compareDateDesc,
          _compareValueDesc,
        );
      case OrderBy.valueAsc:
        return _sortWithTiebreaker(
          services,
          _compareValueAsc,
          _compareAlphabetical,
          _compareDateDesc,
        );
      case OrderBy.valueDesc:
        return _sortWithTiebreaker(
          services,
          _compareValueDesc,
          _compareAlphabetical,
          _compareDateDesc,
        );
    }
  }

  List<Service> _sortWithTiebreaker(
    List<Service> services,
    int Function(Service, Service) firstCompare,
    int Function(Service, Service) secondCompare,
    int Function(Service, Service) thirdCompare,
  ) {
    services.sort((a, b) {
      final firstResult = firstCompare(a, b);
      if (firstResult != 0) return firstResult;
      final secondResult = secondCompare(a, b);
      if (secondResult != 0) return secondResult;
      return thirdCompare(a, b);
    });

    return services;
  }

  int _compareAlphabetical(Service a, Service b) =>
      a.type!.name.compareTo(b.type!.name);
  int _compareDateAsc(Service a, Service b) => a.date.compareTo(b.date);
  int _compareDateDesc(Service a, Service b) => b.date.compareTo(a.date);
  int _compareValueAsc(Service a, Service b) => a.value.compareTo(b.value);
  int _compareValueDesc(Service a, Service b) => b.value.compareTo(a.value);

  @override
  List<ServicesGroupByDate> groupServicesByDate(List<Service> services) {
    final result = <ServicesGroupByDate>[];
    final dates = _getServicesDates(services);

    for (var date in dates) {
      final servicesOnDate = services.where((s) => s.date == date).toList();
      if (servicesOnDate.isNotEmpty) {
        result.add(ServicesGroupByDate(
          date: date,
          services: servicesOnDate,
        ));
      }
    }

    result.sort((a, b) => b.date.compareTo(a.date));
    result.first = result.first.copyWith(isExpaded: true);

    return result;
  }

  List<DateTime> _getServicesDates(List<Service> services) {
    final dates = services.map((s) => s.date).toSet().toList();
    final yesterday = now.copyWith(day: now.day - 1);

    //* Remove today and yesterday from middle of the list to add them on top
    final todayWasRemoved = dates.remove(now);
    final yesterdayWasRemoved = dates.remove(yesterday);

    dates.sort((a, b) => b.compareTo(a));

    if (todayWasRemoved) {
      dates.insert(0, now);
      if (yesterdayWasRemoved) dates.insert(1, yesterday);
    } else if (yesterdayWasRemoved) {
      dates.insert(0, yesterday);
    }

    return dates;
  }

  @override
  Map<String, DateTime> getRangeDateByFastSearch(FastSearch fastSearch) {
    DateTime startDate;
    DateTime endDate;
    switch (fastSearch) {
      case FastSearch.week:
        startDate = now.lastWeekday(DateTime.sunday);
        endDate = now.nextWeekday(DateTime.saturday);
        break;
      case FastSearch.fortnight:
        if (now.day <= 15) {
          startDate = DateTime(now.year, now.month);
          endDate = DateTime(now.year, now.month, 15);
        } else {
          startDate = DateTime(now.year, now.month, 16);
          endDate = DateTime(now.year, now.month + 1, 0);
        }
        break;
      case FastSearch.month:
        startDate = DateTime(now.year, now.month);
        endDate = DateTime(now.year, now.month + 1, 0);
        break;
      case FastSearch.lastMonth:
        startDate = DateTime(now.year, now.month - 1);
        endDate = DateTime(now.year, now.month, 0);
        break;
      default:
        startDate = now;
        endDate = now;
        break;
    }
    return {
      'startDate': startDate.firstHourOfDay,
      'endDate': endDate.lastHourOfDay,
    };
  }
}
