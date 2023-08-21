abstract class TimeService {
  DateTime get now;
  DateTime get nowWithTime;
  bool isRangeInLastMonth(DateTime start, DateTime end);
  bool isRangeInThisMonth(DateTime start, DateTime end);
}
