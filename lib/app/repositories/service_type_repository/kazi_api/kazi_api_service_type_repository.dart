import 'package:kazi/app/core/connection/kazi_connection.dart';
import 'package:kazi/app/core/environment/environment.dart';
import 'package:kazi/app/models/service_type.dart';
import 'package:kazi/app/repositories/service_type_repository/service_type_repository.dart';

final class KaziApiServiceTypeRepository implements ServiceTypeRepository {
  KaziApiServiceTypeRepository(this._connection);
  final KaziConnection _connection;
  final String url = '${Environment.instance.kaziApiUrl}servicetype';

  @override
  Future<ServiceType> add(ServiceType serviceType) async {
    final response = await _connection.post(url, body: serviceType.toJson());
    _connection.handleResponse(response);

    return ServiceType.fromJson(response.json);
  }

  @override
  Future<void> delete(String id) async {
    final response = await _connection.delete('$url/$id');
    _connection.handleResponse(response);
  }

  @override
  Future<List<ServiceType>> get() async {
    final response = await _connection.get(url);
    _connection.handleResponse(response);

    return List<ServiceType>.from(
        (response.json as Iterable).map((e) => ServiceType.fromJson(e)));
  }

  @override
  Future<void> update(ServiceType serviceType) async {
    final response = await _connection.put(url, body: serviceType.toJson());
    _connection.handleResponse(response);
  }
}
