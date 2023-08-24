import 'package:get_it/get_it.dart';
import 'package:kazi/app/data/connection/http/http_kazi_client.dart';
import 'package:kazi/app/data/connection/http/http_kazi_connection.dart';
import 'package:kazi/app/data/connection/kazi_client.dart';
import 'package:kazi/app/data/connection/kazi_connection.dart';
import 'package:kazi/app/data/local_storage/local_storage.dart';
import 'package:kazi/app/data/repositories/service_type_repository/kazi_api/kazi_api_service_type_repository.dart';
import 'package:kazi/app/data/repositories/services_repository/kazi_api/kazi_api_services_repository.dart';
import 'package:kazi/app/services/auth_service/kazi_api/kazi_api_auth_service.dart';
import 'package:kazi/app/services/services_service/services_service.dart';
import 'package:kazi/app/services/time_service/local/local_time_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/data/repositories/service_type_repository/service_type_repository.dart';
import 'app/data/repositories/services_repository/services_repository.dart';
import 'app/services/auth_service/auth_service.dart';
import 'app/services/log_service/log_service.dart';
import 'app/services/services_service/local/local_services_service.dart';
import 'app/services/time_service/time_service.dart';

final serviceLocator = GetIt.instance;

Future<void> initInjectorContainer() async {
  await _initStorages();
  _initNetwork();
  _initRepositories();
  _initServices();
}

Future<void> _initStorages() async {
  serviceLocator.registerSingleton<LocalStorage>(
    SharedPreferencesLocalStorage(await SharedPreferences.getInstance()),
  );
}

void _initNetwork() {
  serviceLocator.registerSingleton<KaziClient>(
    HttpKaziClient(serviceLocator.get<LocalStorage>()),
  );

  serviceLocator.registerSingleton<KaziConnection>(
    HttpKaziConnection(serviceLocator.get<KaziClient>()),
  );
}

void _initRepositories() {
  serviceLocator.registerFactory<ServicesRepository>(
    () => KaziApiServicesRepository(
      serviceLocator.get<KaziConnection>(),
      serviceLocator.get<LogService>(),
    ),
  );

  serviceLocator.registerFactory<ServiceTypeRepository>(
    () => KaziApiServiceTypeRepository(
      serviceLocator.get<KaziConnection>(),
      serviceLocator.get<LogService>(),
    ),
  );
}

void _initServices() {
  serviceLocator.registerSingleton<TimeService>(LocalTimeService());
  serviceLocator.registerSingleton<LogService>(LocalLogService());

  serviceLocator.registerSingleton<AuthService>(
    KaziApiAuthService(
      connection: serviceLocator.get<KaziConnection>(),
      client: serviceLocator.get<KaziClient>(),
      localStorage: serviceLocator.get<LocalStorage>(),
      timeService: serviceLocator.get<TimeService>(),
      logService: serviceLocator.get<LogService>(),
    ),
  );

  serviceLocator.registerFactory<ServicesService>(
    () => LocalServicesService(serviceLocator.get<TimeService>()),
  );
}
