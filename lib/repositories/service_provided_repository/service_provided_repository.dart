import 'package:my_services/models/service_provided.dart';

abstract class ServiceProvidedRepository {
  Future<ServiceProvided> add(ServiceProvided service);
  Future<void> delete(String id);
  Future<List<ServiceProvided>> get(
    String userId, [
    DateTime? startDate,
    DateTime? endDate,
  ]);
  Future<void> update(ServiceProvided service);
  Future<int> count(String userId, [String? typeId]);
}
