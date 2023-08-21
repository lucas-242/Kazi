import 'package:kazi/app/models/service.dart';

abstract class ServicesRepository {
  Future<List<Service>> add(Service service, [int quantity = 1]);
  Future<void> delete(int id);
  Future<List<Service>> get(DateTime startDate, [DateTime? endDate]);
  Future<void> update(Service service);
}
