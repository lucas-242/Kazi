import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kazi_core/kazi_core.dart';

/// The four states are one design decision each, and three of them are easy to
/// break by copying the wrong one. These are the guards.
void main() {
  Future<void> pump(WidgetTester tester, Widget child) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: KaziThemeSettings.light(),
        localizationsDelegates: const [KaziLocalizations.delegate],
        supportedLocales: KaziLocalizations.delegate.supportedLocales,
        home: Scaffold(body: child),
      ),
    );
    await tester.pump();
    await tester.pump();
  }

  group('KaziEmpty', () {
    testWidgets('carries the brand mark, which is what says "account"', (
      tester,
    ) async {
      await pump(tester, const KaziEmpty(message: 'Sem clientes'));

      expect(find.byType(KaziSvg), findsOneWidget);
      expect(find.text('Sem clientes'), findsOneWidget);
    });

    testWidgets('renders the description and the action when given', (
      tester,
    ) async {
      await pump(
        tester,
        KaziEmpty(
          message: 'Sem clientes',
          description: 'Eles nascem conforme você registra serviços.',
          action: KaziElevatedButton.label(
            onTap: () {},
            label: 'Cadastrar cliente',
          ),
        ),
      );

      expect(
        find.text('Eles nascem conforme você registra serviços.'),
        findsOneWidget,
      );
      expect(find.text('Cadastrar cliente'), findsOneWidget);
    });
  });

  group('KaziNoResults', () {
    // The one rule worth a test: the yellow block here would read as an empty
    // account and send the person looking for data they do have.
    testWidgets('never draws the brand mark', (tester) async {
      await pump(
        tester,
        const KaziNoResults(message: 'Nada encontrado para “gel”'),
      );

      expect(find.byType(KaziSvg), findsNothing);
      expect(find.text('Nada encontrado para “gel”'), findsOneWidget);
    });
  });

  group('KaziError', () {
    testWidgets('says the data is safe before anything else', (tester) async {
      await pump(tester, const KaziError(message: 'Não carregou'));

      expect(
        find.text(KaziLocalizations.current.errorDataIsSafe),
        findsOneWidget,
      );
    });

    testWidgets('offers the retry only when there is one', (tester) async {
      await pump(tester, const KaziError(message: 'Não carregou'));
      expect(find.byType(KaziElevatedButton), findsNothing);

      var retried = 0;
      await pump(
        tester,
        KaziError(message: 'Não carregou', onRetry: () => retried++),
      );
      await tester.tap(find.byType(KaziElevatedButton));

      expect(retried, 1);
    });
  });

  group('KaziSkeletonList', () {
    // The loading surface swallows the tap instead of letting it through to
    // whatever it covers. Everything outside the surface stays live.
    testWidgets('does not let a tap through to what it covers', (tester) async {
      var tappedBehind = 0;

      await pump(
        tester,
        Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => tappedBehind++,
              ),
            ),
            const KaziSkeletonList(count: 2),
          ],
        ),
      );
      await tester.tapAt(tester.getCenter(find.byType(KaziSkeletonList)));

      expect(tappedBehind, 0);
    });
  });
}
