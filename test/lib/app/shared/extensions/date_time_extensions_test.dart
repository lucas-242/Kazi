import 'package:flutter_test/flutter_test.dart';
import 'package:my_services/app/shared/extensions/extensions.dart';

void main() {
  test('Should find next weekday', () {
    final date = DateTime(2022, DateTime.december, 25);
    final result = date.nextWeekday(DateTime.wednesday);

    expect(result.weekday, DateTime.wednesday);
    expect(result.day, 28);
    expect(result.month, DateTime.december);
    expect(result.year, 2022);
  });

  test('Should find last weekday', () {
    final date = DateTime(2022, DateTime.december, 25);
    final result = date.lastWeekday(DateTime.wednesday);

    expect(result.weekday, DateTime.wednesday);
    expect(result.day, 21);
    expect(result.month, DateTime.december);
    expect(result.year, 2022);
  });
}
