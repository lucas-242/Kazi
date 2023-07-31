import 'dart:io';

import 'package:kazi/app/models/enums.dart';
import 'package:kazi/app/shared/constants/ad_keys.dart';

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
  String get kaziApiUrl => 'https://localhost:7250/';
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
