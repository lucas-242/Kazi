import '../../models/service_provided.dart';
import '../../models/service_type.dart';

abstract class ServiceHelper {
  static List<ServiceProvided> mergeServices(
    List<ServiceProvided> cachedServices,
    List<ServiceProvided> newServices,
  ) {
    final setCachedServices = <ServiceProvided>{}..addAll(cachedServices);
    final toAdd = newServices.where((e) {
      final isNew = !setCachedServices.contains(e);
      return isNew;
    });
    setCachedServices.addAll(toAdd);
    return setCachedServices.toList();
  }

  static List<ServiceProvided> _orderByType(List<ServiceProvided> services) {
    services.sort((a, b) => a.type!.name.compareTo(a.type!.name));
    return services;
  }

  static List<ServiceProvided> addServiceTypeToServices(
      List<ServiceProvided> services, List<ServiceType> serviceTypes) {
    final result = <ServiceProvided>[];
    for (var service in services) {
      result.add(_fillServiceWithServiceType(service, serviceTypes));
    }
    return result;
  }

  static ServiceProvided _fillServiceWithServiceType(
      ServiceProvided service, List<ServiceType> serviceTypes) {
    return service.copyWith(
        type: serviceTypes.firstWhere((st) => st.id == service.typeId));
  }

  static List<ServiceProvided> filterServicesByDate(
      List<ServiceProvided> services, int year, int month,
      [int? day]) {
    var filtered =
        services.where((s) => s.date.year == year && s.date.month == month);

    if (day != null) {
      filtered = filtered.where((s) => s.date.day == day);
    }

    return filtered.toList();
  }
}
