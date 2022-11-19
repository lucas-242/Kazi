import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:my_services/services/cache_service/cache_service.dart';
import 'package:my_services/services/cache_service/local/cache_service_local.dart';

import '/services/auth_service/auth_service.dart';
import '/services/auth_service/firebase/auth_service_firebase_impl.dart';
import '/repositories/service_provided_repository/service_provided_repository.dart';
import 'repositories/service_provided_repository/firebase/service_repository_firebase_impl.dart';
import 'repositories/service_type_repository/firebase/service_type_repository_firebase_impl.dart';
import 'repositories/service_type_repository/service_type_repository.dart';

final locator = GetIt.instance;

Future<void> init() async {
  locator.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);

  locator.registerSingleton<AuthService>(AuthServiceFirebaseImpl());
  locator.registerLazySingleton<CacheService>(() => CacheServiceLocal());

  locator.registerFactory<ServiceProvidedRepository>(
    () =>
        ServiceProvidedRepositoryFirebaseImpl(locator.get<FirebaseFirestore>()),
  );
  locator.registerFactory<ServiceTypeRepository>(
    () => ServiceTypeRepositoryFirebaseImpl(locator.get<FirebaseFirestore>()),
  );
}
