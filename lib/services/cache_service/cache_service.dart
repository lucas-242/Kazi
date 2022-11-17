import 'package:my_services/models/service_type.dart';

import '../../models/service_provided.dart';

abstract class CacheService {
  List<ServiceType> get serviceTypeList;
  set serviceTypeList(List<ServiceType> serviceTypeList);

  List<ServiceProvided> get serviceProvidedList;
  set serviceProvidedList(List<ServiceProvided> serviceProvidedList);
}
