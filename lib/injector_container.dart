import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'app/services/time_service/time_service.dart';

import 'app/services/auth_service/auth_service.dart';
import 'app/services/auth_service/firebase/firebase_auth_service.dart';
import 'app/repositories/services_repository/services_repository.dart';
import 'app/repositories/services_repository/firebase/firebase_services_repository.dart';
import 'app/repositories/service_type_repository/firebase/firebase_service_type_repository.dart';
import 'app/repositories/service_type_repository/service_type_repository.dart';

final locator = GetIt.instance;

Future<void> init() async {
  locator.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);

  locator.registerSingleton<AuthService>(FirebaseAuthService());
  locator.registerSingleton<TimeService>(LocalTimeService());

  locator.registerFactory<ServicesRepository>(
    () => FirebaseServicesRepository(locator.get<FirebaseFirestore>()),
  );
  locator.registerFactory<ServiceTypeRepository>(
    () => FirebaseServiceTypeRepository(locator.get<FirebaseFirestore>()),
  );
}
