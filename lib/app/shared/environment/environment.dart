import 'dart:io';

import 'package:kazi/app/models/enums.dart';
import 'package:kazi/app/shared/constants/ad_keys.dart';

import '../constants/app_keys.dart';

abstract class Environment {
  static EnvironmentValue get environmentValue => EnvironmentValue.fromString(
      const String.fromEnvironment(AppKeys.environmentKey))!;

  static Environment get instance => environmentValue == EnvironmentValue.dev
      ? DevEnvironment()
      : ProdEnvironment();

  String get adFinishAddActionKey;
  String get adCalendarServiceListKey;
  String get adHomeServiceListKey;
}

class DevEnvironment extends Environment {
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
}

class ProdEnvironment extends Environment {
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
}

String _checkEnvironmentAdKey(String android, String ios) {
  if (Platform.isAndroid) {
    return android;
  } else if (Platform.isIOS) {
    return ios;
  }

  return '';
}
