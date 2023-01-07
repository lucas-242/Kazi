import 'package:my_services/app/shared/environment/environment_keys.dart';

enum EnvironmentValue {
  dev('dev'),
  prod('prod');

  final String value;
  const EnvironmentValue(this.value);

  static EnvironmentValue? fromString(String value) {
    for (EnvironmentValue environment in EnvironmentValue.values) {
      if (environment.value == value) {
        return environment;
      }
    }

    return null;
  }
}

abstract class Environment {
  static EnvironmentValue get environmentValue =>
      EnvironmentValue.fromString(
          const String.fromEnvironment(EnvironmentKeys.env)) ??
      EnvironmentValue.dev;

  static Environment get instance => environmentValue == EnvironmentValue.dev
      ? DevEnvironment()
      : ProdEnvironment();

  String get banner1AdKey;
  String get banner2AdKey;
}

class DevEnvironment extends Environment {
  @override
  String get banner1AdKey => 'abcde';

  @override
  String get banner2AdKey => 'fghij';
}

class ProdEnvironment extends Environment {
  @override
  String get banner1AdKey => 'prodKey1';

  @override
  String get banner2AdKey => 'prodKey2';
}
