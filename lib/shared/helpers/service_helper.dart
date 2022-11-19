import '../../models/service_provided.dart';
import '../../models/service_type.dart';

abstract class ServiceHelper {
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
}
