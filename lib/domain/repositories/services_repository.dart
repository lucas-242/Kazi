import 'package:kazi_core/kazi_core.dart';

abstract interface class ServicesRepository {
  Future<List<Service>> add(Service service, [int quantity = 1]);
  Future<void> delete(int id);
  Future<List<Service>> get(ServicesFilter servicesFilter);
  Future<void> update(Service service);
}
