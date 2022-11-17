import 'package:my_services/models/service_provided.dart';
import 'package:my_services/models/service_type.dart';
import 'package:my_services/services/cache_service/cache_service.dart';

class CacheServiceLocal extends CacheService {
  List<ServiceType> _serviceTypeList = [];
  List<ServiceProvided> _serviceProvidedList = [];

  @override
  List<ServiceType> get serviceTypeList => _serviceTypeList;

  @override
  set serviceTypeList(List<ServiceType> serviceTypeList) {
    _serviceTypeList = serviceTypeList;
  }

  @override
  List<ServiceProvided> get serviceProvidedList => _serviceProvidedList;

  @override
  set serviceProvidedList(List<ServiceProvided> serviceProvidedList) {
    _serviceProvidedList = serviceProvidedList;
  }
}
