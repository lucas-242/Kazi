abstract class TimeService {
  DateTime get now;
  DateTime get nowWithoutTime;
}

class LocalTimeService implements TimeService {
  final DateTime _currentDate;

  LocalTimeService([DateTime? currentDate])
      : _currentDate = currentDate ?? DateTime.now();

  @override
  DateTime get now => _currentDate;

  @override
  DateTime get nowWithoutTime =>
      DateTime(_currentDate.year, _currentDate.month, _currentDate.day);
}
