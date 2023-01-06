import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'app/services/log_service/log_service.dart';
import 'app/services/time_service/time_service.dart';

import 'app/services/auth_service/auth_service.dart';
import 'app/services/auth_service/firebase/firebase_auth_service.dart';
import 'app/repositories/services_repository/services_repository.dart';
import 'app/repositories/services_repository/firebase/firebase_services_repository.dart';
import 'app/repositories/service_type_repository/firebase/firebase_service_type_repository.dart';
import 'app/repositories/service_type_repository/service_type_repository.dart';

final injector = GetIt.instance;

Future<void> initInjectorContainer() async {
  injector.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);

  injector.registerSingleton<AuthService>(FirebaseAuthService());
  injector.registerSingleton<TimeService>(LocalTimeService());
  injector.registerSingleton<LogService>(LocalLogService());

  injector.registerFactory<ServicesRepository>(
    () => FirebaseServicesRepository(injector.get<FirebaseFirestore>()),
  );
  injector.registerFactory<ServiceTypeRepository>(
    () => FirebaseServiceTypeRepository(injector.get<FirebaseFirestore>()),
  );
}
