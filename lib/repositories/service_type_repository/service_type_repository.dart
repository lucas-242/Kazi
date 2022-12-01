import 'package:my_services/models/service_type.dart';

abstract class ServiceTypeRepository {
  Future<ServiceType> add(ServiceType service);
  Future<void> delete(String id);
  Future<List<ServiceType>> get(String userId);
  Future<void> update(ServiceType service);
}