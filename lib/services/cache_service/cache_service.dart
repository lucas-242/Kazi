import 'package:my_services/models/service_type.dart';

import '../../models/service_provided.dart';

abstract class CacheService {
  List<ServiceType> get serviceTypes;
  set serviceTypes(List<ServiceType> serviceTypeList);

  List<ServiceProvided> get services;
  set services(List<ServiceProvided> serviceProvidedList);

  List<ServiceProvided> getServicesByMonth(DateTime dateTime);
}
