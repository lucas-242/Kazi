import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/core/utils/number_format_utils.dart';
import 'package:mockito/mockito.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late Locale locale;
  late BuildContext context;

  setUp(() {
    context = MockBuildContext();
  });

  test('Should format int to pt_BR', () {
    locale = const Locale('pt', 'BR');
    const number = 22;
    final result = NumberFormatUtils.formatCurrency(context, number, locale);

    expect(result, equals('R\$\u{00A0}22,00'));
  });

  test('Should format double to pt_BR', () {
    locale = const Locale('pt', 'BR');
    const number = 17452.57;
    final result = NumberFormatUtils.formatCurrency(context, number, locale);

    expect(result, equals('R\$\u{00A0}17.452,57'));
  });

  test('Should format int to en_US', () {
    locale = const Locale('en', 'US');
    const number = 789;
    final result = NumberFormatUtils.formatCurrency(context, number, locale);

    expect(result, equalsIgnoringWhitespace('\$789.00'));
  });

  test('Should format double to en_US', () {
    locale = const Locale('en', 'US');
    const number = 7899945.357;
    final result = NumberFormatUtils.formatCurrency(context, number, locale);

    expect(result, equalsIgnoringWhitespace('\$7,899,945.36'));
  });
}
