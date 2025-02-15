import 'package:kazi/app/services/time_service/time_service.dart';

class LocalTimeService implements TimeService {

  LocalTimeService([DateTime? currentDate])
      : _currentDate = currentDate ?? DateTime.now();
  final DateTime _currentDate;

  @override
  DateTime get now =>
      DateTime(_currentDate.year, _currentDate.month, _currentDate.day);

  @override
  bool isRangeInLastMonth(DateTime start, DateTime end) =>
      _isRangeInMonth(start, end, now.month - 1);

  @override
  bool isRangeInThisMonth(DateTime start, DateTime end) =>
      _isRangeInMonth(start, end, now.month);

  bool _isRangeInMonth(DateTime start, DateTime end, int month) {
    final monthStart = now.copyWith(day: 1, month: month);
    final monthEnd = DateTime(now.year, month + 1, 0, 23, 59, 59);

    if (start.compareTo(monthStart) >= 0 && end.compareTo(monthEnd) <= 0) {
      return true;
    }

    return false;
  }
}
