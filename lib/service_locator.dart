import 'package:get_it/get_it.dart';
import 'package:kazi/domain/connection/kazi_client.dart';
import 'package:kazi/domain/connection/kazi_connection.dart';
import 'package:kazi/domain/repositories/auth_repository.dart';
import 'package:kazi/domain/repositories/service_type_repository.dart';
import 'package:kazi/domain/repositories/services_repository.dart';
import 'package:kazi/domain/services/auth_service.dart';
import 'package:kazi/domain/services/local_storage.dart';
import 'package:kazi/domain/services/services_service.dart';
import 'package:kazi/domain/services/time_service.dart';
import 'package:kazi/infra/connection/http_kazi_client.dart';
import 'package:kazi/infra/connection/http_kazi_connection.dart';
import 'package:kazi/infra/repositories/kazi_api_auth_repository.dart';
import 'package:kazi/infra/repositories/kazi_api_service_type_repository.dart';
import 'package:kazi/infra/repositories/kazi_api_services_repository.dart';
import 'package:kazi/infra/services/kazi_api_auth_service.dart';
import 'package:kazi/infra/services/local_services_service.dart';
import 'package:kazi/infra/services/local_time_service.dart';
import 'package:kazi/infra/services/shared_preferences_local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    _instance.registerSingleton<AuthService>(
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
