import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kazi_core/kazi_core.dart';

/// The gallery is the design system's own documentation, so it breaking
/// silently is worse than a screen breaking: it is where the next person looks
/// to decide which token to use.
void main() {
  Future<void> pumpGallery(WidgetTester tester, Size size) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(
        theme: KaziThemeSettings.light(),
        // The state components render localized labels ("tentar de novo"), so
        // the gallery needs the delegate the app always gives it.
        localizationsDelegates: const [KaziLocalizations.delegate],
        supportedLocales: KaziLocalizations.delegate.supportedLocales,
        home: const KaziThemeGalleryPage(),
      ),
    );
    // Never `pumpAndSettle`: the skeleton pulses forever, so nothing settles.
    // Two frames — one to load the delegate, one to draw with it.
    await tester.pump();
    await tester.pump();
  }

  testWidgets('renders both brightnesses side by side when wide',
      (tester) async {
    await pumpGallery(tester, const Size(1200, 900));

    expect(tester.takeException(), isNull);
    // Both panels are live at once — that is the whole point of the page.
    expect(find.text('LIGHT'), findsOneWidget);
    expect(find.text('DARK'), findsOneWidget);
    expect(find.byType(Row), findsWidgets);
  });

  testWidgets('stacks the two panels on a phone', (tester) async {
    await pumpGallery(tester, const Size(390, 844));

    expect(tester.takeException(), isNull);
    expect(find.text('LIGHT'), findsOneWidget);
    expect(find.text('DARK'), findsOneWidget);
  });

  testWidgets('scrolls as a single page', (tester) async {
    await pumpGallery(tester, const Size(390, 844));

    expect(find.byType(Scrollable), findsOneWidget);
  });

  testWidgets('names every token it draws', (tester) async {
    await pumpGallery(tester, const Size(1200, 2400));

    // A swatch with no label is useless, so spot-check the ones a screen is
    // most likely to be looking for.
    for (final token in <String>[
      'background',
      'textMuted',
      'brand.fill / onFill',
      'success.surface + .surfaceBorder',
      'danger.fill',
    ]) {
      expect(find.text(token), findsWidgets, reason: token);
    }
  });
}
