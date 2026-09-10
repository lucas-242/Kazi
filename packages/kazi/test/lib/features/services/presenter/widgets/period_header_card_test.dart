import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/core/utils/base_state.dart';
import 'package:kazi/features/services/domain/models/receipt_filter.dart';
import 'package:kazi/features/services/domain/models/service.dart';
import 'package:kazi/features/services/presenter/controllers/service_landing_state.dart';
import 'package:kazi/features/services/presenter/widgets/period_header_card.dart';
import 'package:kazi_core/kazi_core.dart' hide Service;

/// The header is the one place the three words appear together, so it is where
/// a wrong label or a stale total is most expensive.
void main() {
  final day = DateTime(2026, 8, 20);

  Service service({
    required String id,
    double value = 100,
    DateTime? receivedAt,
  }) => Service(
    id: id,
    value: value,
    commissionPercent: 40,
    currency: 'USD',
    rateDate: '2026-08-20',
    receivedAt: receivedAt,
    date: day,
    userId: 'user-1',
  );

  ServiceLandingState stateWith(
    List<Service> services, {
    ReceiptFilter receiptFilter = ReceiptFilter.all,
  }) => ServiceLandingState(
    status: BaseStateStatus.success,
    services: services,
    startDate: day,
    endDate: day,
    receiptFilter: receiptFilter,
  );

  Future<void> pump(WidgetTester tester, ServiceLandingState state) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: KaziThemeSettings.light(),
          // The global delegates carry the date symbols the period label needs
          // to name its month.
          localizationsDelegates: const [
            KaziLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: KaziLocalizations.delegate.supportedLocales,
          locale: const Locale('en'),
          home: Scaffold(body: PeriodHeaderCard(state: state)),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();
  }

  final paid = service(id: 'paid', receivedAt: DateTime(2026, 9, 5));
  final owed = service(id: 'owed', value: 50);

  testWidgets('Should offer the bulk action naming how many are pending', (
    tester,
  ) async {
    await pump(tester, stateWith([paid, owed]));

    expect(find.textContaining('Mark the 1 pending'), findsOneWidget);
  });

  // Zero pending, line absent: an action with nothing to act on is noise.
  testWidgets('Should drop the bulk action when nothing is owed', (
    tester,
  ) async {
    await pump(tester, stateWith([paid]));

    expect(find.textContaining('pending as received'), findsNothing);
  });

  testWidgets('Should report the earnings of the rows a filter left standing', (
    tester,
  ) async {
    // 40 + 20 under no filter; 20 once only the pending row is listed.
    await pump(tester, stateWith([paid, owed]));
    expect(find.text(r'$60.00'), findsOneWidget);

    await pump(
      tester,
      stateWith([paid, owed], receiptFilter: ReceiptFilter.pending),
    );
    expect(find.text(r'$20.00'), findsOneWidget);
  });

  // Already received + pending = your earnings, on screen, in that order.
  testWidgets('Should split the earnings once something has been paid', (
    tester,
  ) async {
    await pump(tester, stateWith([paid, owed]));

    expect(
      find.textContaining(r'of $150.00 generated'),
      findsOneWidget,
    );
    expect(find.textContaining(r'$40.00 already received'), findsOneWidget);
    expect(find.textContaining(r'$20.00 pending'), findsOneWidget);
  });

  // A permanent "0 already received" reads as a problem rather than absence.
  testWidgets('Should drop the split when nothing has been paid', (
    tester,
  ) async {
    await pump(tester, stateWith([owed]));

    expect(find.textContaining('already received'), findsNothing);
  });

  // 60 earned out of 150 generated.
  testWidgets('Should say what share of the gross the earnings are', (
    tester,
  ) async {
    await pump(tester, stateWith([paid, owed]));

    expect(find.textContaining(r'40% of $150.00 generated'), findsOneWidget);
  });
}
