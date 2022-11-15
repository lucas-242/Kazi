import 'package:my_services/models/service_type.dart';
import 'package:my_services/services/cache_service/cache_service.dart';

class CacheServiceLocal extends CacheService {
  List<ServiceType> _serviceTypeList = [];

  @override
  List<ServiceType> get serviceTypeList => _serviceTypeList;

  @override
  set serviceTypeList(List<ServiceType> serviceTypeList) {
    _serviceTypeList = serviceTypeList;
  }
}
