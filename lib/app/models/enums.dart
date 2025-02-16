/// Represents the search possibilities for the Services lists
enum FastSearch { today, week, fortnight, month, lastMonth, custom }

/// Represents the possibilities that the ordering of the Services lists can follow
enum OrderBy { alphabetical, valueAsc, valueDesc, dateAsc, dateDesc }

/// Represents the possibilities for CustomAppBar menu options
enum CustomAppBarOptions { order, logout }

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
