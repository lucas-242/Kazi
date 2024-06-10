import 'package:kazi/app/core/environment/environment.dart';
import 'package:kazi/app/core/errors/errors.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/utils/log_utils.dart';
import 'package:kazi/app/data/connection/kazi_connection.dart';
import 'package:kazi/app/data/repositories/service_type_repository/service_type_repository.dart';
import 'package:kazi/app/models/service_type.dart';

final class KaziApiServiceTypeRepository implements ServiceTypeRepository {
  KaziApiServiceTypeRepository(this._connection);
  final KaziConnection _connection;
  final String url = '${Environment.instance.kaziApiUrl}servicetype';

  @override
  Future<ServiceType> add(ServiceType serviceType) async {
    try {
      final response = await _connection.post(url, body: serviceType.toJson());
      response.handleStatus();

      return ServiceType.fromJson(response.json);
    } catch (error, trace) {
      Log.error(error, trace, AppLocalizations.current.errorToAddServiceType);
      throw ExternalError(AppLocalizations.current.errorToAddServiceType);
    }
  }

  @override
  Future<void> delete(int id) async {
    try {
      final response = await _connection.delete('$url/$id');
      response.handleStatus();
    } catch (error, trace) {
      Log.error(
          error, trace, AppLocalizations.current.errorToDeleteServiceType);
      throw ExternalError(AppLocalizations.current.errorToDeleteServiceType);
    }
  }

  @override
  Future<List<ServiceType>> get() async {
    try {
      final response = await _connection.get(url);
      response.handleStatus();

      return List<ServiceType>.from(
          (response.json as Iterable).map((e) => ServiceType.fromJson(e)));
    } on AppError catch (error, trace) {
      Log.error(error, trace, AppLocalizations.current.errorToGetServiceTypes);
      rethrow;
    } catch (error, trace) {
      Log.error(error, trace, AppLocalizations.current.errorToGetServiceTypes);
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
      response.handleStatus();
    } catch (error, trace) {
      Log.error(
          error, trace, AppLocalizations.current.errorToUpdateServiceType);
      throw ExternalError(AppLocalizations.current.errorToUpdateServiceType);
    }
  }
}
