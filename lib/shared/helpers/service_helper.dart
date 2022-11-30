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

  static List<ServiceProvided> filterServicesByRange(
      List<ServiceProvided> services, DateTime startDate, DateTime endDate) {
    var filtered = services.where((s) {
      final serviceDate = DateTime(s.date.year, s.date.month, s.date.day);
      return (serviceDate.isAtSameMomentAs(startDate) ||
              serviceDate.isAfter(startDate)) &&
          (serviceDate.isAtSameMomentAs(endDate) ||
              serviceDate.isBefore(endDate));
    });

    return filtered.toList();
  }
}
