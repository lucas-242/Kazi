import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kazi/app/data/local_storage/local_storage.dart';
import 'package:kazi/app/services/services_service/services_service.dart';
import 'package:kazi/app/services/time_service/local/local_time_service.dart';
import 'package:kazi/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/repositories/service_type_repository/firebase/firebase_service_type_repository.dart';
import 'app/repositories/service_type_repository/service_type_repository.dart';
import 'app/repositories/services_repository/firebase/firebase_services_repository.dart';
import 'app/repositories/services_repository/services_repository.dart';
import 'app/services/auth_service/auth_service.dart';
import 'app/services/auth_service/firebase/firebase_auth_service.dart';
import 'app/services/services_service/local/local_services_service.dart';
import 'app/services/time_service/time_service.dart';

final serviceLocator = GetIt.instance;

abstract class InjectorContainer {
  static Future<void> init() async {
    await _initGoogle();
    await _initStorages();
    _initServices();
    _initRepositories();
  }

  static Future<void> _initGoogle() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    await MobileAds.instance.initialize();

    serviceLocator
        .registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  }

  static Future<void> _initStorages() async {
    serviceLocator.registerSingleton<LocalStorage>(
      SharedPreferencesStorage(await SharedPreferences.getInstance()),
    );
  }

  static Future<void> _initServices() async {
    serviceLocator.registerSingleton<AuthService>(FirebaseAuthService());
    serviceLocator.registerSingleton<TimeService>(LocalTimeService());
    serviceLocator.registerFactory<ServicesService>(
      () => LocalServicesService(serviceLocator.get<TimeService>()),
    );
  }

  static void _initRepositories() {
    serviceLocator.registerFactory<ServicesRepository>(
      () => FirebaseServicesRepository(serviceLocator.get<FirebaseFirestore>()),
    );
    serviceLocator.registerFactory<ServiceTypeRepository>(
      () => FirebaseServiceTypeRepository(
          serviceLocator.get<FirebaseFirestore>()),
    );
  }
}
