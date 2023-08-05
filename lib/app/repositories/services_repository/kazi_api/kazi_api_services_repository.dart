import 'package:kazi/app/core/environment/environment.dart';
import 'package:kazi/app/models/service.dart';
import 'package:kazi/app/services/api_service/api_service.dart';

import '../services_repository.dart';

class KaziApiServicesRepository extends ServicesRepository {
  KaziApiServicesRepository(this._apiService);
  final ApiService _apiService;
  final String url = '${Environment.instance.kaziApiUrl}servicetype';

  @override
  Future<List<Service>> add(Service service, [int quantity = 1]) async {
    final response = await _apiService.post(url, body: service.toJson());
    _apiService.handleResponse(response);

    // return Service.fromJson(response.json);
    return [];
  }

  @override
  Future<void> delete(String id) async {
    final response = await _apiService.delete('$url/$id');
    _apiService.handleResponse(response);
  }

  @override
  Future<void> update(Service service) async {
    final response =
        await _apiService.put('$url/${service.id}', body: service.toJson());
    _apiService.handleResponse(response);
  }

  @override
  Future<List<Service>> get(DateTime startDate, [DateTime? endDate]) async {
    final response = await _apiService.post(url, parameters: {
      'startDate': startDate.toString(),
      'endDate': endDate.toString(),
    });
    _apiService.handleResponse(response);
    return List<Service>.from(
        (response.json as Iterable).map((e) => Service.fromJson(e)));
  }
}
