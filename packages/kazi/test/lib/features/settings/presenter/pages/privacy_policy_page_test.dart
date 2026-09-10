import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/features/settings/presenter/pages/privacy_policy_page.dart';
import 'package:kazi_core/kazi_core.dart';

import '../../../../../utils/test_helper.dart';

class _FakeUrlLauncher implements KaziUrlLauncherService {
  final List<String> launched = [];

  @override
  Future<bool> launch(String url) async {
    launched.add(url);
    return true;
  }
}

void main() {
  late _FakeUrlLauncher launcher;

  TestHelper.loadAppLocalizations();

  setUp(() => launcher = _FakeUrlLauncher());

  Future<void> pumpPage(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [kaziUrlLauncherServiceProvider.overrideWithValue(launcher)],
        child: MaterialApp(
          localizationsDelegates: const [
            KaziLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: KaziLocalizations.delegate.supportedLocales,
          theme: KaziThemeSettings.light(),
          home: const PrivacyPolicyPage(),
        ),
      ),
    );
    await tester.pump();
  }

  Future<void> tapText(WidgetTester tester, String text) async {
    await tester.ensureVisible(find.text(text));
    await tester.tap(find.text(text));
    await tester.pump();
  }

  // An `Expanded` inside `KaziSafeArea`'s scroll view once broke this page
  // with an unbounded-height flex.
  testWidgets('Should lay out inside the scrolling safe area', (tester) async {
    await pumpPage(tester);

    expect(tester.takeException(), isNull);
  });

  testWidgets('Should show the full text only once asked for', (tester) async {
    final l10n = KaziLocalizations.current;
    await pumpPage(tester);

    expect(find.text(l10n.privacySummaryStoredTitle), findsOneWidget);
    expect(find.text(l10n.privacyPoliceReplayTitle), findsNothing);

    await tapText(tester, l10n.privacyReadFullVersion);

    expect(find.text(l10n.privacyPoliceReplayTitle), findsOneWidget);
    expect(find.text(l10n.privacyReadFullVersion), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Should write to the contact address to delete the account', (
    tester,
  ) async {
    final l10n = KaziLocalizations.current;
    await pumpPage(tester);

    await tapText(tester, l10n.privacySummaryDeleteTitle);

    expect(launcher.launched, ['mailto:${l10n.contactEmail}']);
  });
}
