import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kazi_core/kazi_core.dart';

void main() {
  group('KaziSafeArea isLoading', () {
    late int appBarTaps;
    late int bodyTaps;

    setUp(() {
      appBarTaps = 0;
      bodyTaps = 0;
    });

    Future<void> pumpSafeArea(
      WidgetTester tester, {
      required bool isLoading,
    }) async {
      await tester.pumpWidget(
        MaterialApp(
          // The loading overlay writes a localized label, so the delegate has
          // to be in the tree for `KaziSafeArea(isLoading: true)` to build.
          localizationsDelegates: const [KaziLocalizations.delegate],
          supportedLocales: KaziLocalizations.delegate.supportedLocales,
          home: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => appBarTaps++,
                ),
              ],
            ),
            body: KaziSafeArea(
              isLoading: isLoading,
              isScrollView: false,
              child: GestureDetector(
                onTap: () => bodyTaps++,
                child: const SizedBox.expand(child: Text('conteúdo')),
              ),
            ),
          ),
        ),
      );

      // The delegate resolves asynchronously, and `Localizations` renders an
      // empty subtree until it does.
      await tester.pump();
    }

    testWidgets('Should block taps on the body and on the app bar', (
      tester,
    ) async {
      await pumpSafeArea(tester, isLoading: true);
      await tester.pump();

      await tester.tap(find.byIcon(Icons.add), warnIfMissed: false);
      await tester.tap(find.text('conteúdo'), warnIfMissed: false);
      await tester.pump();

      expect(appBarTaps, 0);
      expect(bodyTaps, 0);
    });

    testWidgets('Should keep the content visible behind the overlay', (
      tester,
    ) async {
      await pumpSafeArea(tester, isLoading: true);
      await tester.pump();

      expect(find.text('conteúdo'), findsOneWidget);
    });

    testWidgets('Should not block anything when it is not loading', (
      tester,
    ) async {
      await pumpSafeArea(tester, isLoading: false);
      await tester.pump();

      await tester.tap(find.byIcon(Icons.add));
      await tester.tap(find.text('conteúdo'));
      await tester.pump();

      expect(appBarTaps, 1);
      expect(bodyTaps, 1);
    });
  });

  group('KaziSafeArea slivers', () {
    Widget app(Widget body) => MaterialApp(home: Scaffold(body: body));

    testWidgets('Should build only the rows that reach the screen', (
      tester,
    ) async {
      await tester.pumpWidget(
        app(
          KaziSafeArea(
            slivers: [
              SliverList.builder(
                itemCount: 1000,
                itemBuilder: (_, index) =>
                    SizedBox(height: 50, child: Text('row $index')),
              ),
            ],
          ),
        ),
      );

      expect(find.text('row 0'), findsOneWidget);
      expect(find.text('row 999'), findsNothing);
    });

    testWidgets('Should pad the slivers exactly as it pads a child', (
      tester,
    ) async {
      await tester.pumpWidget(app(const KaziSafeArea(child: Text('first'))));
      final asChild = tester.getTopLeft(find.text('first'));

      await tester.pumpWidget(
        app(
          const KaziSafeArea(
            slivers: [SliverToBoxAdapter(child: Text('first'))],
          ),
        ),
      );

      expect(tester.getTopLeft(find.text('first')), asChild);
    });
  });
}
