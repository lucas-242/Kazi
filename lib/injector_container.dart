import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:my_services/app/data/local_storage/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/repositories/service_type_repository/firebase/firebase_service_type_repository.dart';
import 'app/repositories/service_type_repository/service_type_repository.dart';
import 'app/repositories/services_repository/firebase/firebase_services_repository.dart';
import 'app/repositories/services_repository/services_repository.dart';
import 'app/services/auth_service/auth_service.dart';
import 'app/services/auth_service/firebase/firebase_auth_service.dart';
import 'app/services/log_service/log_service.dart';
import 'app/services/time_service/time_service.dart';

final serviceLocator = GetIt.instance;

Future<void> initInjectorContainer() async {
  serviceLocator
      .registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);

  serviceLocator.registerSingleton<AuthService>(FirebaseAuthService());
  serviceLocator.registerSingleton<TimeService>(LocalTimeService());
  serviceLocator.registerSingleton<LogService>(LocalLogService());

  serviceLocator.registerSingleton<LocalStorage>(
    SharedPreferencesStorage(await SharedPreferences.getInstance()),
  );

  serviceLocator.registerFactory<ServicesRepository>(
    () => FirebaseServicesRepository(serviceLocator.get<FirebaseFirestore>()),
  );
  serviceLocator.registerFactory<ServiceTypeRepository>(
    () =>
        FirebaseServiceTypeRepository(serviceLocator.get<FirebaseFirestore>()),
  );
}
