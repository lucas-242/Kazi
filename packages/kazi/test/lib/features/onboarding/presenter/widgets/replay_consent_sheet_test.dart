import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/core/constants/storage_keys.dart';
import 'package:kazi/features/onboarding/presenter/widgets/replay_consent_sheet.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

import '../../../../../utils/fakes/fake_local_storage.dart';
import '../../../../../utils/test_helper.dart';

/// The question is asked once. Every way out of the sheet — accepting,
/// declining, or dismissing it — has to leave an answer behind, or the next
/// launch asks again.
void main() {
  TestHelper.loadAppLocalizations();

  late FakeLocalStorage storage;

  Future<void> pumpAsk(WidgetTester tester) async {
    ReplayConsentSheet.resetSessionGuard();
    storage = FakeLocalStorage();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          localStorageProvider.overrideWith((ref) async => storage),
        ],
        child: MaterialApp(
          localizationsDelegates: const [KaziLocalizations.delegate],
          supportedLocales: KaziLocalizations.delegate.supportedLocales,
          theme: KaziThemeSettings.light(),
          home: Consumer(
            builder: (context, ref, _) => TextButton(
              onPressed: () => ReplayConsentSheet.askIfNeeded(context, ref),
              child: const Text('ask'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('ask'));
    await tester.pumpAndSettle();
  }

  testWidgets('Should record the consent when it is given', (tester) async {
    await pumpAsk(tester);

    await tester.tap(find.text(KaziLocalizations.current.replayConsentAccept));
    await tester.pumpAndSettle();

    expect(storage.values[StorageKeys.sessionReplayConsent], isTrue);
  });

  testWidgets('Should record a refusal when the sheet is dismissed', (
    tester,
  ) async {
    await pumpAsk(tester);

    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    expect(
      storage.values[StorageKeys.sessionReplayConsent],
      isFalse,
      reason: 'a dismissed sheet must not come back on the next launch',
    );
  });

  testWidgets('Should not ask again once an answer is stored', (tester) async {
    await pumpAsk(tester);
    await tester.tap(find.text(KaziLocalizations.current.replayConsentDecline));
    await tester.pumpAndSettle();

    ReplayConsentSheet.resetSessionGuard();
    await tester.tap(find.text('ask'));
    await tester.pumpAndSettle();

    expect(find.byType(ReplayConsentSheet), findsNothing);
  });
}
