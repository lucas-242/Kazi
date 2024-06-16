import 'package:kazi_core/kazi_core.dart';

abstract interface class ServiceTypeRepository {
  Future<ServiceType> add(ServiceType serviceType);
  Future<void> delete(int id);
  Future<List<ServiceType>> get();
  Future<void> update(ServiceType serviceType);
}
