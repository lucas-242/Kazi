import 'package:my_services/models/service_provided.dart';
import 'package:my_services/models/service_type.dart';
import 'package:my_services/services/cache_service/cache_service.dart';

class CacheServiceLocal extends CacheService {
  List<ServiceType> _serviceTypes = [];
  List<ServiceProvided> _services = [];

  @override
  List<ServiceType> get serviceTypes => _serviceTypes;

  @override
  set serviceTypes(List<ServiceType> serviceTypeList) {
    _serviceTypes = serviceTypeList;
  }

  @override
  List<ServiceProvided> get services => _services;

  @override
  set services(List<ServiceProvided> newServices) {
    _services = newServices;
  }
}
