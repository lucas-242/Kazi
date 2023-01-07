import 'package:my_services/app/shared/extensions/date_time_extensions.dart';

abstract class GlobalSettings {
  static DateTime formStartDate = DateTime(2022);

  static DateTime get formEndDate {
    final today = DateTime.now();
    return today.copyWith(month: today.month + 2);
  }
}
