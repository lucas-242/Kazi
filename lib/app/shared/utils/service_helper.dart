import 'package:my_services/app/models/enums.dart';
import 'package:my_services/app/models/service.dart';
import 'package:my_services/app/models/service_type.dart';

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
    var filtered = services.where((s) {
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
        services.sort((a, b) => a.date.compareTo(b.date));
        break;
      case OrderBy.dateDesc:
        services.sort((a, b) => b.date.compareTo(a.date));
        break;
      case OrderBy.typeAsc:
        services.sort((a, b) => a.type!.name.compareTo(b.type!.name));
        break;
      case OrderBy.typeDesc:
        services.sort((a, b) => b.type!.name.compareTo(a.type!.name));
        break;
      case OrderBy.valueAsc:
        services.sort((a, b) => a.value.compareTo(b.value));
        break;
      case OrderBy.valueDesc:
        services.sort((a, b) => b.value.compareTo(a.value));
        break;
    }
    return services;
  }
}
