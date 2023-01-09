import 'dart:io';

import '../../models/enums.dart';
import '../constants/global_keys.dart';
import '../constants/ad_keys.dart';

abstract class Environment {
  static EnvironmentValue get environmentValue =>
      EnvironmentValue.fromString(
          const String.fromEnvironment(GlobalKeys.environmentKey)) ??
      EnvironmentValue.dev;

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
  String get adCalendarServiceListKey =>
      AdKeys.androidCalendarServiceListKeyDev;

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
  String get adCalendarServiceListKey =>
      AdKeys.androidCalendarServiceListKeyProd;

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
