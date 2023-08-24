import 'package:kazi/app/data/connection/kazi_connection.dart';
import 'package:kazi/app/core/environment/environment.dart';
import 'package:kazi/app/core/errors/errors.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/models/service_type.dart';
import 'package:kazi/app/data/repositories/service_type_repository/service_type_repository.dart';
import 'package:kazi/app/services/log_service/log_service.dart';

final class KaziApiServiceTypeRepository implements ServiceTypeRepository {
  KaziApiServiceTypeRepository(this._connection, this._logService);
  final KaziConnection _connection;
  final LogService _logService;
  final String url = '${Environment.instance.kaziApiUrl}servicetype';

  @override
  Future<ServiceType> add(ServiceType serviceType) async {
    try {
      final response = await _connection.post(url, body: serviceType.toJson());
      _connection.handleResponse(response);

      return ServiceType.fromJson(response.json);
    } catch (error, trace) {
      _logService.error(
        error: error,
        stackTrace: trace,
        message: AppLocalizations.current.errorToAddServiceType,
      );
      throw ExternalError(AppLocalizations.current.errorToAddServiceType);
    }
  }

  @override
  Future<void> delete(int id) async {
    try {
      final response = await _connection.delete('$url/$id');
      _connection.handleResponse(response);
    } catch (error, trace) {
      _logService.error(
        error: error,
        stackTrace: trace,
        message: AppLocalizations.current.errorToDeleteServiceType,
      );
      throw ExternalError(AppLocalizations.current.errorToDeleteServiceType);
    }
  }

  @override
  Future<List<ServiceType>> get() async {
    try {
      final response = await _connection.get(url);
      _connection.handleResponse(response);

      return List<ServiceType>.from(
          (response.json as Iterable).map((e) => ServiceType.fromJson(e)));
    } on AppError catch (error, trace) {
      _logService.error(
          error: error,
          stackTrace: trace,
          message: AppLocalizations.current.errorToGetServiceTypes);
      rethrow;
    } catch (error, trace) {
      _logService.error(
        error: error,
        stackTrace: trace,
        message: AppLocalizations.current.errorToGetServiceTypes,
      );
      throw ExternalError(AppLocalizations.current.errorToGetServiceTypes);
    }
  }

  @override
  Future<void> update(ServiceType serviceType) async {
    try {
      final response = await _connection.put(
        '$url/${serviceType.id}',
        body: serviceType.toJson(withId: true),
      );
      _connection.handleResponse(response);
    } catch (error, trace) {
      _logService.error(
        error: error,
        stackTrace: trace,
        message: AppLocalizations.current.errorToUpdateServiceType,
      );
      throw ExternalError(AppLocalizations.current.errorToUpdateServiceType);
    }
  }
}
