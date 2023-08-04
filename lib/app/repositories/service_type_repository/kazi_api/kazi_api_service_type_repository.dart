import 'package:kazi/app/core/environment/environment.dart';
import 'package:kazi/app/models/service_type.dart';
import 'package:kazi/app/repositories/service_type_repository/service_type_repository.dart';
import 'package:kazi/app/services/api_service/api_service.dart';

final class KaziApiServiceTypeRepository implements ServiceTypeRepository {
  KaziApiServiceTypeRepository(this._apiService);
  final ApiService _apiService;
  final String url = '${Environment.instance.kaziApiUrl}servicetype';

  @override
  Future<ServiceType> add(ServiceType serviceType) async {
    final response = await _apiService.post(url, body: serviceType.toJson());
    _apiService.handleResponse(response);

    return ServiceType.fromJson(response.json);
  }

  @override
  Future<void> delete(String id) async {
    final response = await _apiService.delete('$url/$id');
    _apiService.handleResponse(response);
  }

  @override
  Future<List<ServiceType>> get() async {
    final response = await _apiService.get(url);
    _apiService.handleResponse(response);

    return List<ServiceType>.from(
        (response.json as Iterable).map((e) => ServiceType.fromJson(e)));
  }

  @override
  Future<void> update(ServiceType serviceType) async {
    final response = await _apiService.put(url, body: serviceType.toJson());
    _apiService.handleResponse(response);
  }
}
