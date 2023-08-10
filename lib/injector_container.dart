import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:kazi/app/data/local_storage/local_storage.dart';
import 'package:kazi/app/repositories/service_type_repository/kazi_api/kazi_api_service_type_repository.dart';
import 'package:kazi/app/repositories/services_repository/kazi_api/kazi_api_services_repository.dart';
import 'package:kazi/app/services/api_service/api_service.dart';
import 'package:kazi/app/services/api_service/http/http_api_service.dart';
import 'package:kazi/app/services/api_service/http/kazi_client.dart';
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
  _initExternal();
  _initStorages();
  _initServices();
  _initRepositories();
}

Future<void> _initExternal() async {
  serviceLocator
      .registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
}

Future<void> _initStorages() async {
  serviceLocator.registerSingleton<LocalStorage>(
    SharedPreferencesLocalStorage(await SharedPreferences.getInstance()),
  );
}

Future<void> _initServices() async {
  serviceLocator.registerSingleton<TimeService>(LocalTimeService());
  serviceLocator.registerSingleton<LogService>(LocalLogService());

  serviceLocator.registerFactory<KaziClient>(
    () => KaziClient(serviceLocator.get<LocalStorage>()),
  );
  serviceLocator.registerSingleton<ApiService>(
    HttpApiService(serviceLocator.get<KaziClient>()),
  );

  serviceLocator.registerSingleton<AuthService>(
    KaziApiAuthService(
      apiService: serviceLocator.get<ApiService>(),
      localStorage: serviceLocator.get<LocalStorage>(),
      timeService: serviceLocator.get<TimeService>(),
    ),
  );

  serviceLocator.registerFactory<ServicesService>(
    () => LocalServicesService(serviceLocator.get<TimeService>()),
  );
}

Future<void> _initRepositories() async {
  serviceLocator.registerFactory<ServicesRepository>(
    () => KaziApiServicesRepository(serviceLocator.get<ApiService>()),
  );

  serviceLocator.registerFactory<ServiceTypeRepository>(
    () => KaziApiServiceTypeRepository(serviceLocator.get<ApiService>()),
  );
}
