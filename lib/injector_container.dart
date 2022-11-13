import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

import '/services/auth_service/auth_service.dart';
import '/services/auth_service/firebase/auth_service_firebase_impl.dart';

final locator = GetIt.instance;

Future<void> init() async {
  locator.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);

  locator.registerLazySingleton<AuthService>(() => AuthServiceFirebaseImpl());
}
