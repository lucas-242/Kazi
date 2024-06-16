abstract class AppKeys {
  /// Name of envinroment key set in the build/run
  static const String environmentKey = 'APP_ENV';

  /// Key to identify if it is necessary to display the onboarding
  static String showOnboardingStorage = 'showOnboarding';
  static String userData = 'userData';

  /// Calendar start date
  static DateTime formStartDate = DateTime(2020);

  /// Calendar end date
  static DateTime get formEndDate {
    final today = DateTime.now();
    return today.copyWith(month: today.month + 3);
  }
}
