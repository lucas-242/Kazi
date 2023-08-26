import 'package:kazi/app/models/service_type.dart';

abstract interface class ServiceTypeRepository {
  Future<ServiceType> add(ServiceType serviceType);
  Future<void> delete(int id);
  Future<List<ServiceType>> get();
  Future<void> update(ServiceType serviceType);
}