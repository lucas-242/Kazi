import 'package:kazi/app/core/connection/kazi_connection.dart';
import 'package:kazi/app/core/environment/environment.dart';
import 'package:kazi/app/models/service.dart';

import '../services_repository.dart';

class KaziApiServicesRepository extends ServicesRepository {
  KaziApiServicesRepository(this._connection);
  final KaziConnection _connection;
  final String url = '${Environment.instance.kaziApiUrl}servicetype';

  @override
  Future<List<Service>> add(Service service, [int quantity = 1]) async {
    final response = await _connection.post(url, body: service.toJson());
    _connection.handleResponse(response);

    // return Service.fromJson(response.json);
    return [];
  }

  @override
  Future<void> delete(String id) async {
    final response = await _connection.delete('$url/$id');
    _connection.handleResponse(response);
  }

  @override
  Future<void> update(Service service) async {
    final response =
        await _connection.put('$url/${service.id}', body: service.toJson());
    _connection.handleResponse(response);
  }

  @override
  Future<List<Service>> get(DateTime startDate, [DateTime? endDate]) async {
    final response = await _connection.post(url, parameters: {
      'startDate': startDate.toString(),
      'endDate': endDate.toString(),
    });
    _connection.handleResponse(response);
    return List<Service>.from(
        (response.json as Iterable).map((e) => Service.fromJson(e)));
  }
}
