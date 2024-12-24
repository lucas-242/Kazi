import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:kazi/app/services/crashlytics_service/crashlytics_service.dart';

final class FirebaseCrashlyticsService implements CrashlyticsService {
  FirebaseCrashlyticsService(this._crashlytics);

  final FirebaseCrashlytics _crashlytics;

  @override
  Future<void> init() async {
    await _crashlytics.setCrashlyticsCollectionEnabled(true);

    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  @override
  void log(Object exception, StackTrace stackTrace) =>
      _crashlytics.recordError(exception, stackTrace);
}
