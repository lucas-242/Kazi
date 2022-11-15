import 'package:my_services/models/service_type.dart';

abstract class CacheService {
  List<ServiceType> get serviceTypeList;
  set serviceTypeList(List<ServiceType> serviceTypeList);
}
