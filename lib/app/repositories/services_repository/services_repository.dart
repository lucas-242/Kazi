import 'package:kazi/app/models/service.dart';

abstract class ServicesRepository {
  Future<List<Service>> add(Service service, [int quantity = 1]);
  Future<void> delete(String id);
  Future<List<Service>> get(String userId, DateTime startDate,
      [DateTime? endDate,]);
  Future<void> update(Service service);
  Future<int> count(String userId, [String? typeId]);
}
