import 'package:kazi/app/models/service.dart';
import 'package:kazi/app/models/services_filter.dart';

abstract class ServicesRepository {
  Future<List<Service>> add(Service service, [int quantity = 1]);
  Future<void> delete(int id);
  Future<List<Service>> get(ServicesFilter servicesFilter);
  Future<void> update(Service service);
}
