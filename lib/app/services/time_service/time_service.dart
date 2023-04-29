abstract class TimeService {
  DateTime get now;
  bool isRangeInLastMonth(DateTime start, DateTime end);
  bool isRangeInThisMonth(DateTime start, DateTime end);
}
