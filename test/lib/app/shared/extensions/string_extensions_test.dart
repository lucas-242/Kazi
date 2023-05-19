import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/app/shared/extensions/extensions.dart';

void main() {
  test('Should return normalized date for 1/3/2023', () {
    const date = '1/3/2023';
    final result = date.normalizeDate();

    expect(result, '01/03/2023');
  });

  test('Should return normalized date for 2023/1/03', () {
    const date = '2023/1/03';
    final result = date.normalizeDate();

    expect(result, '2023/01/03');
  });

  test('Should return normalized date for 3/01/2023', () {
    const date = '3/01/2023';
    final result = date.normalizeDate();

    expect(result, '03/01/2023');
  });

  test('Should return normalized date 11-25-2023', () {
    const date = '11-25-2023';
    final result = date.normalizeDate();

    expect(result, '11/25/2023');
  });

  test('Should capitalize compound word', () {
    const string = 'Test this string';
    final result = string.capitalize();

    expect(result, equals('Test This String'));
  });

  test('Should capitalize simple word', () {
    const string = 'test';
    final result = string.capitalize();

    expect(result, equals('Test'));
  });

  test('Should capitalize a letter', () {
    const string = 'a';
    final result = string.capitalize();

    expect(result, equals('A'));
  });
}
