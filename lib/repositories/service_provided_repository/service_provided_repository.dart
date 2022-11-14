import 'package:my_services/models/service_provided.dart';

abstract class ServiceProvidedRepository {
  Future<void> add(ServiceProvided service);
  Future<void> delete(String id);
  Future<List<ServiceProvided>> get(String userId, {DateTime? dateTime});
  Future<void> update(ServiceProvided service);
}
