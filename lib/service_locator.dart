import 'package:get_it/get_it.dart';
import 'package:kazi/app/core/auth/kazi_api/kazi_api_auth.dart';
import 'package:kazi/app/data/connection/http/http_kazi_client.dart';
import 'package:kazi/app/data/connection/http/http_kazi_connection.dart';
import 'package:kazi/app/data/connection/kazi_client.dart';
import 'package:kazi/app/data/connection/kazi_connection.dart';
import 'package:kazi/app/data/local_storage/local_storage.dart';
import 'package:kazi/app/data/repositories/auth_repository/auth_repository.dart';
import 'package:kazi/app/data/repositories/auth_repository/kazi_api/kazi_api_auth_repository.dart';
import 'package:kazi/app/data/repositories/service_type_repository/kazi_api/kazi_api_service_type_repository.dart';
import 'package:kazi/app/data/repositories/services_repository/kazi_api/kazi_api_services_repository.dart';
import 'package:kazi/app/services/services_service/services_service.dart';
import 'package:kazi/app/services/time_service/local/local_time_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/core/auth/auth.dart';
import 'app/data/repositories/service_type_repository/service_type_repository.dart';
import 'app/data/repositories/services_repository/services_repository.dart';
import 'app/services/services_service/local/local_services_service.dart';
import 'app/services/time_service/time_service.dart';

abstract class ServiceLocator {
  static final _instance = GetIt.instance;

  static T get<T extends Object>() => _instance.get<T>();

  static Future<void> init() async {
    await _initStorages();
    _initNetwork();
    _initRepositories();
    _initServices();
  }

  static Future<void> _initStorages() async {
    _instance.registerSingleton<LocalStorage>(
      SharedPreferencesLocalStorage(await SharedPreferences.getInstance()),
    );
  }

  static void _initNetwork() {
    _instance.registerSingleton<KaziClient>(
      HttpKaziClient(_instance.get<LocalStorage>()),
    );

    _instance.registerSingleton<KaziConnection>(
      HttpKaziConnection(_instance.get<KaziClient>()),
    );
  }

  static void _initRepositories() {
    _instance.registerFactory<AuthRepository>(
      () => KaziApiAuthRepository(connection: _instance.get<KaziConnection>()),
    );

    _instance.registerFactory<ServicesRepository>(
      () => KaziApiServicesRepository(_instance.get<KaziConnection>()),
    );

    _instance.registerFactory<ServiceTypeRepository>(
      () => KaziApiServiceTypeRepository(_instance.get<KaziConnection>()),
    );
  }

  static void _initServices() {
    _instance.registerSingleton<TimeService>(LocalTimeService());

    _instance.registerSingleton<Auth>(
      KaziApiAuth(
        authRepository: _instance.get<AuthRepository>(),
        client: _instance.get<KaziClient>(),
        localStorage: _instance.get<LocalStorage>(),
        timeService: _instance.get<TimeService>(),
      ),
    );

    _instance.registerFactory<ServicesService>(
      () => LocalServicesService(_instance.get<TimeService>()),
    );
  }
}
