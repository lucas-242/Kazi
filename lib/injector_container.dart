import 'package:get_it/get_it.dart';
import 'package:kazi/app/core/connection/http/http_kazi_client.dart';
import 'package:kazi/app/core/connection/http/http_kazi_connection.dart';
import 'package:kazi/app/core/connection/kazi_client.dart';
import 'package:kazi/app/core/connection/kazi_connection.dart';
import 'package:kazi/app/data/local_storage/local_storage.dart';
import 'package:kazi/app/repositories/service_type_repository/kazi_api/kazi_api_service_type_repository.dart';
import 'package:kazi/app/repositories/services_repository/kazi_api/kazi_api_services_repository.dart';
import 'package:kazi/app/services/auth_service/kazi_api/kazi_api_auth_service.dart';
import 'package:kazi/app/services/services_service/services_service.dart';
import 'package:kazi/app/services/time_service/local/local_time_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/repositories/service_type_repository/service_type_repository.dart';
import 'app/repositories/services_repository/services_repository.dart';
import 'app/services/auth_service/auth_service.dart';
import 'app/services/log_service/log_service.dart';
import 'app/services/services_service/local/local_services_service.dart';
import 'app/services/time_service/time_service.dart';

final serviceLocator = GetIt.instance;

Future<void> initInjectorContainer() async {
  await _initStorages();
  await _initNetwork();
  await _initRepositories();
  await _initServices();
}

Future<void> _initStorages() async {
  serviceLocator.registerSingleton<LocalStorage>(
    SharedPreferencesLocalStorage(await SharedPreferences.getInstance()),
  );
}

Future<void> _initNetwork() async {
  serviceLocator.registerSingleton<KaziClient>(
    HttpKaziClient(serviceLocator.get<LocalStorage>()),
  );

  serviceLocator.registerSingleton<KaziConnection>(
    HttpKaziConnection(serviceLocator.get<KaziClient>()),
  );
}

Future<void> _initRepositories() async {
  serviceLocator.registerFactory<ServicesRepository>(
    () => KaziApiServicesRepository(serviceLocator.get<KaziConnection>()),
  );

  serviceLocator.registerFactory<ServiceTypeRepository>(
    () => KaziApiServiceTypeRepository(serviceLocator.get<KaziConnection>()),
  );
}

Future<void> _initServices() async {
  serviceLocator.registerSingleton<TimeService>(LocalTimeService());
  serviceLocator.registerSingleton<LogService>(LocalLogService());

  serviceLocator.registerSingleton<AuthService>(
    KaziApiAuthService(
      connection: serviceLocator.get<KaziConnection>(),
      localStorage: serviceLocator.get<LocalStorage>(),
      timeService: serviceLocator.get<TimeService>(),
      logService: serviceLocator.get<LogService>(),
    ),
  );

  serviceLocator.registerFactory<ServicesService>(
    () => LocalServicesService(serviceLocator.get<TimeService>()),
  );
}
