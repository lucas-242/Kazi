import 'package:kazi/app/core/environment/environment.dart';
import 'package:kazi/app/core/errors/errors.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/data/connection/kazi_connection.dart';
import 'package:kazi/app/models/service.dart';
import 'package:kazi/app/models/services_filter.dart';
import 'package:kazi/app/services/log_service/log_service.dart';

import '../services_repository.dart';

class KaziApiServicesRepository extends ServicesRepository {
  KaziApiServicesRepository(this._connection, this._logService);
  final KaziConnection _connection;
  final LogService _logService;
  final String url = '${Environment.instance.kaziApiUrl}service';

  @override
  Future<List<Service>> add(Service service, [int quantity = 1]) async {
    try {
      final response = await _connection.post(
        url,
        parameters: {'quantity': quantity},
        body: service.toJson(),
      );
      response.handleStatus();

      return List<Service>.from(
          (response.json as Iterable).map((e) => Service.fromJson(e)));
    } catch (error, trace) {
      _logService.error(
        error: error,
        stackTrace: trace,
        message: AppLocalizations.current.errorToAddService,
      );
      throw ExternalError(AppLocalizations.current.errorToAddService);
    }
  }

  @override
  Future<void> delete(int id) async {
    try {
      final response = await _connection.delete('$url/$id');
      response.handleStatus();
    } catch (error, trace) {
      _logService.error(
        error: error,
        stackTrace: trace,
        message: AppLocalizations.current.errorToDeleteService,
      );
      throw ExternalError(AppLocalizations.current.errorToDeleteService);
    }
  }

  @override
  Future<void> update(Service service) async {
    try {
      final response = await _connection.put(
        '$url/${service.id}',
        body: service.toJson(withId: true),
      );
      response.handleStatus();
    } catch (error, trace) {
      _logService.error(
        error: error,
        stackTrace: trace,
        message: AppLocalizations.current.errorToUpdateService,
      );
      throw ExternalError(AppLocalizations.current.errorToUpdateService);
    }
  }

  @override
  Future<List<Service>> get(ServicesFilter servicesFilter) async {
    try {
      final response =
          await _connection.get(url, parameters: servicesFilter.toJson());
      response.handleStatus();
      if (response.body.isEmpty) {
        return [];
      }

      return List<Service>.from(
          (response.json as Iterable).map((e) => Service.fromJson(e)));
    } catch (error, trace) {
      _logService.error(
        error: error,
        stackTrace: trace,
        message: AppLocalizations.current.errorToGetServices,
      );
      throw ExternalError(AppLocalizations.current.errorToGetServices);
    }
  }

  // @override
  // Future<List<ServicesGroupByDate>> get(DateTime startDate,
  //     [DateTime? endDate]) async {
  //   try {
  //     final response = await _connection.post('$url/grouped', parameters: {
  //       'ScheduledToStartAt': startDate,
  //       'ScheduledToEndAt': endDate,
  //     });
  //     response.handleStatus();
  //     return List<ServicesGroupByDate>.from((response.json as Iterable)
  //         .map((e) => ServicesGroupByDate.fromJson(e)));
  //   } catch (error, trace) {
  //     _logService.error(
  //       error: error,
  //       stackTrace: trace,
  //       message: AppLocalizations.current.errorToGetServices,
  //     );
  //     throw ExternalError(AppLocalizations.current.errorToGetServices);
  //   }
  // }
}
