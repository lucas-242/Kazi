enum EnvironmentValue {
  dev('dev'),
  prod('prod');

  const EnvironmentValue(this.value);

  final String value;

  static EnvironmentValue? fromString(String value) {
    for (EnvironmentValue environment in EnvironmentValue.values) {
      if (environment.value == value) {
        return environment;
      }
    }

    return null;
  }
}
