import 'package:kazi/app/models/service_type.dart';

abstract class ServiceTypeRepository {
  Future<ServiceType> add(ServiceType serviceType);
  Future<void> delete(String id);
  Future<List<ServiceType>> get(String userId);
  Future<void> update(ServiceType serviceType);
}
