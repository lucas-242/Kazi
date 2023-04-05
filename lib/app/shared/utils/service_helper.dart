import 'package:my_services/app/models/enums.dart';
import 'package:my_services/app/models/service.dart';
import 'package:my_services/app/models/service_group_by_date.dart';
import 'package:my_services/app/models/service_type.dart';
import 'package:my_services/app/shared/extensions/extensions.dart';

abstract class ServiceHelper {
  static List<Service> mergeServices(
    List<Service> cachedServices,
    List<Service> newServices,
  ) {
    final setCachedServices = <Service>{}..addAll(cachedServices);
    final toAdd = newServices.where((e) {
      final isNew = !setCachedServices.contains(e);
      return isNew;
    });
    setCachedServices.addAll(toAdd);
    return setCachedServices.toList();
  }

  static List<Service> addServiceTypeToServices(
      List<Service> services, List<ServiceType> serviceTypes) {
    final result = <Service>[];
    for (var service in services) {
      result.add(_fillServiceWithServiceType(service, serviceTypes));
    }
    return result;
  }

  static Service _fillServiceWithServiceType(
      Service service, List<ServiceType> serviceTypes) {
    return service.copyWith(
        type: serviceTypes.firstWhere((st) => st.id == service.typeId));
  }

  static List<Service> filterServicesByRange(
      List<Service> services, DateTime startDate, DateTime endDate) {
    final filtered = services.where((s) {
      final serviceDate = DateTime(s.date.year, s.date.month, s.date.day);
      return (serviceDate.isAtSameMomentAs(startDate) ||
              serviceDate.isAfter(startDate)) &&
          (serviceDate.isAtSameMomentAs(endDate) ||
              serviceDate.isBefore(endDate));
    });

    return filtered.toList();
  }

  static List<Service> orderServices(List<Service> services, OrderBy orderBy) {
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

  static List<Service> _sortWithTiebreaker(
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

  static int _compareAlphabetical(Service a, Service b) =>
      a.type!.name.compareTo(b.type!.name);
  static int _compareDateAsc(Service a, Service b) => a.date.compareTo(b.date);
  static int _compareDateDesc(Service a, Service b) => b.date.compareTo(a.date);
  static int _compareValueAsc(Service a, Service b) =>
      a.value.compareTo(b.value);
  static int _compareValueDesc(Service a, Service b) =>
      b.value.compareTo(a.value);

  static List<ServicesGroupByDate> groupServicesByDate(
    List<Service> services,
    DateTime today,
  ) {
    final result = <ServicesGroupByDate>[];
    final dates = _getServicesDates(services, today);

    for (var date in dates) {
      final servicesOnDate = services.where((s) => s.date == date).toList();
      if (servicesOnDate.isNotEmpty) {
        final daysOfDifference = date.calculateDifference(today);
        final isExpanded = daysOfDifference == 0 || daysOfDifference == -1;
        result.add(ServicesGroupByDate(
          date: date,
          services: servicesOnDate,
          isExpaded: isExpanded,
        ));
      }
    }

    return result;
  }

  static List<DateTime> _getServicesDates(
    List<Service> services,
    DateTime today,
  ) {
    final dates = services.map((s) => s.date).toSet().toList();
    final yesterday = today.copyWith(day: today.day - 1);

    //* Remove today and yesterday from middle of the list to add them on top
    final todayWasRemoved = dates.remove(today);
    final yesterdayWasRemoved = dates.remove(yesterday);

    dates.sort((a, b) => b.compareTo(a));

    if (todayWasRemoved) {
      dates.insert(0, today);
      if (yesterdayWasRemoved) dates.insert(1, yesterday);
    } else if (yesterdayWasRemoved) {
      dates.insert(0, yesterday);
    }

    return dates;
  }

  static Map<String, DateTime> getRangeDateByFastSearch(
    FastSearch fastSearch,
    DateTime today,
  ) {
    DateTime startDate;
    DateTime endDate;
    switch (fastSearch) {
      case FastSearch.week:
        startDate = today.lastWeekday(DateTime.sunday);
        endDate = today.nextWeekday(DateTime.saturday);
        break;
      case FastSearch.fortnight:
        if (today.day <= 15) {
          startDate = DateTime(today.year, today.month);
          endDate = DateTime(today.year, today.month, 15);
        } else {
          startDate = DateTime(today.year, today.month, 16);
          endDate = DateTime(today.year, today.month + 1, 0);
        }
        break;
      case FastSearch.month:
        startDate = DateTime(today.year, today.month);
        endDate = DateTime(today.year, today.month + 1, 0);
        break;
      default:
        startDate = today;
        endDate = today;
        break;
    }
    return {
      'startDate': startDate.firstHourOfDay,
      'endDate': endDate.lastHourOfDay,
    };
  }
}
