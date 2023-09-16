import 'dart:io';

import 'package:kazi/app/core/constants/ad_keys.dart';
import 'package:kazi/app/models/enums/environment_value.dart';

import '../constants/app_keys.dart';

abstract interface class Environment {
  static EnvironmentValue get environmentValue =>
      EnvironmentValue.fromString(String.fromEnvironment(AppKeys.environmentKey,
          defaultValue: EnvironmentValue.dev.value))!;

  static Environment get instance => environmentValue == EnvironmentValue.dev
      ? DevEnvironment()
      : ProdEnvironment();

  String get adFinishAddActionKey;
  String get adCalendarServiceListKey;
  String get adHomeServiceListKey;
  String get kaziApiUrl;
  static String get policiesGooglePlayUrl =>
      'https://www.google.com/policies/privacy/';
  static String get policiesAdMobUrl =>
      'https://support.google.com/admob/answer/6128543?hl=en';
  static String get policiesFirebaseAnalyticsUrl =>
      'https://www.google.com/analytics/terms/';
  static String get policiesFirebaseCrashlyticsUrl =>
      'https://firebase.google.com/support/privacy/';
}

final class DevEnvironment implements Environment {
  @override
  String get adFinishAddActionKey => _checkEnvironmentAdKey(
        AdKeys.androidFinishAddActionKeyDev,
        AdKeys.iosFinishAddActionKeyDev,
      );

  @override
  String get adCalendarServiceListKey => _checkEnvironmentAdKey(
        AdKeys.androidCalendarServiceListKeyDev,
        AdKeys.iosCalendarServiceListKeyDev,
      );

  @override
  String get adHomeServiceListKey => _checkEnvironmentAdKey(
        AdKeys.androidHomeServiceListKeyDev,
        AdKeys.iosHomeServiceListKeyDev,
      );

  @override
  String get kaziApiUrl => 'http://192.168.0.232:5005/api/';
}

final class ProdEnvironment implements Environment {
  @override
  String get adFinishAddActionKey => _checkEnvironmentAdKey(
        AdKeys.androidFinishAddActionKeyProd,
        AdKeys.iosFinishAddActionKeyProd,
      );

  @override
  String get adCalendarServiceListKey => _checkEnvironmentAdKey(
      AdKeys.androidCalendarServiceListKeyProd,
      AdKeys.iosCalendarServiceListKeyProd);

  @override
  String get adHomeServiceListKey => _checkEnvironmentAdKey(
        AdKeys.androidHomeServiceListKeyProd,
        AdKeys.iosHomeServiceListKeyProd,
      );

  @override
  String get kaziApiUrl => 'https://localhost:7250/';
}

String _checkEnvironmentAdKey(String android, String ios) {
  if (Platform.isAndroid) {
    return android;
  } else if (Platform.isIOS) {
    return ios;
  }

  return '';
}
