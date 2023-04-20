import 'package:my_services/app/shared/extensions/date_time_extensions.dart';

abstract class GlobalKeys {
  /// Name of envinroment key set in the build/run
  static const String environmentKey = 'APP_ENV';

  /// Key to identify if it is necessary to display the onboarding
  static String showOnboardingStorage = 'showOnboarding';

  //TODO: Remove these dates from GlobalKeys
  static DateTime formStartDate = DateTime(2022);

  static DateTime get formEndDate {
    final today = DateTime.now();
    return today.copyWith(month: today.month + 2);
  }
}