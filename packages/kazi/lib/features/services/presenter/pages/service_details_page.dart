import 'package:flutter/material.dart';
import 'package:kazi/core/currency/currency_providers.dart';
import 'package:kazi/core/routes/app_pages.dart';
import 'package:kazi/core/widgets/detail_info_row.dart';
import 'package:kazi/features/onboarding/domain/models/onboarding_hint.dart';
import 'package:kazi/features/onboarding/presenter/widgets/hint_anchor.dart';
import 'package:kazi/features/services/domain/models/service.dart';
import 'package:kazi/features/services/presenter/controllers/live_service_provider.dart';
import 'package:kazi/features/services/presenter/controllers/service_landing_controller.dart';
import 'package:kazi/features/services/presenter/controllers/service_receipt_controller.dart';
import 'package:kazi/features/services/services.dart';
import 'package:kazi_core/kazi_core.dart' hide Service;

/// One service, read from the top down: what the user earns, then the facts
/// that produced it. See README.md.
class ServiceDetailsPage extends ConsumerWidget {
  const ServiceDetailsPage({super.key, required this.service});

  /// The service as it was when this page was pushed. Immutable, and handed
  /// over through go_router's `extra` — so it is a starting point, not the
  /// source of truth; see [liveServiceProvider].
  final Service service;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Follows whichever list holds this service, so marking it as received
    // below repaints the page. Falls back to the pushed copy when no list has
    // it — reachable from a deep link.
    final service =
        ref.watch(liveServiceProvider(this.service.id)) ?? this.service;

    final defaultCurrency = ref.watch(kaziDefaultCurrencyProvider);
    final serviceCurrency = service.currencyOr(defaultCurrency);
    final rateBook = ref
        .watch(dayRateBookProvider(service.effectiveRateDate))
        .asData
        ?.value;

    Future<void> onDelete(Service service) async {
      KaziNavigator.pop();
      final controller = ref.read(serviceLandingControllerProvider.notifier);
      await controller.deleteService(service).then((_) {
        if (context.mounted) KaziNavigator.navigate(AppPage.services);
      });
    }

    void onTapDelete() {
      showDialog<void>(
        context: context,
        builder: (context) => KaziDialog(
          title: KaziLocalizations.current.deleteForeverTitle(
            service.catalogItem?.name ?? KaziLocalizations.current.service,
          ),
          message: KaziLocalizations.current.deleteServiceImpact,
          confirmText: KaziLocalizations.current.deletePermanently,
          isDestructive: true,
          onCancel: KaziNavigator.pop,
          onConfirm: () => onDelete(service),
        ),
      );
    }

    return Scaffold(
      appBar: KaziAppBar(
        title: KaziLocalizations.current.service,
        actions: [
          KaziCircularButton.plain(
            onTap: () => KaziNavigator.push(
              AppPage.addServices,
              extra: ServiceArguments(service: service),
            ),
            semantics: KaziLocalizations.current.edit,
            child: const Icon(Icons.edit, size: 18),
          ),
          // Destructive and rare: it lives in the menu rather than competing
          // with the content for attention.
          KaziOverflowMenu(
            semantics: KaziLocalizations.current.actions,
            actions: [
              KaziOverflowAction(
                label: KaziLocalizations.current.delete,
                icon: Icons.delete_outline,
                isDestructive: true,
                onTap: onTapDelete,
              ),
            ],
          ),
          KaziSpacings.horizontalXs,
        ],
      ),
      body: KaziSafeArea(
        child: _ServiceDetails(
          service: service,
          currency: serviceCurrency,
          defaultCurrency: defaultCurrency,
          rateBook: rateBook,
        ),
      ),
      bottomNavigationBar: _ReceiptCta(service: service),
    );
  }
}

/// The one action this screen exists to offer, at full width where the thumb
/// already is. It says what it will do, and a paid service offers the undo.
class _ReceiptCta extends ConsumerStatefulWidget {
  const _ReceiptCta({required this.service});

  final Service service;

  @override
  ConsumerState<_ReceiptCta> createState() => _ReceiptCtaState();
}

class _ReceiptCtaState extends ConsumerState<_ReceiptCta> {
  bool _isSaving = false;

  Future<void> _onTap() async {
    setState(() => _isSaving = true);
    try {
      await ref.read(serviceReceiptControllerProvider.notifier).setReceived([
        widget.service,
      ], received: !widget.service.isReceived);
    } on AppError catch (exception) {
      if (mounted) KaziSnackbar.show(context, exception.message);
    } catch (_) {
      if (mounted) {
        KaziSnackbar.show(context, KaziLocalizations.current.errorUnknowError);
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isReceived = widget.service.isReceived;

    return KaziFormFooter(
      label: isReceived
          ? KaziLocalizations.current.unmarkAsReceived
          : KaziLocalizations.current.markAsReceived,
      isOutlined: isReceived,
      // Ignored while the write is in flight: a second tap would toggle the
      // stamp back.
      onTap: _isSaving ? null : _onTap,
      child: (button) => HintAnchor(
        hint: OnboardingHint.markReceived,
        // Nothing to explain about marking a service received when it already
        // is.
        enabled: !isReceived,
        radius: KaziRadii.sm,
        child: button,
      ),
    );
  }
}

class _ServiceDetails extends StatelessWidget {
  const _ServiceDetails({
    required this.service,
    required this.currency,
    required this.defaultCurrency,
    required this.rateBook,
  });

  final Service service;
  final SupportedCurrency currency;
  final SupportedCurrency defaultCurrency;
  final RateBook? rateBook;

  /// The same amount restated in the user's default currency, or null when the
  /// service is already in it and there is nothing to restate.
  ///
  /// Null is also what a missing rate yields; it never falls back to the raw
  /// amount, which would label a foreign figure with the default currency.
  String? _inDefaultCurrency(double amount) {
    final book = rateBook;
    if (currency == defaultCurrency || book == null) return null;

    final converted = service.convert(
      amount,
      to: defaultCurrency,
      fallback: defaultCurrency,
      rateBook: book,
    );

    return converted == null
        ? null
        : '≈ ${NumberFormatUtils.formatCurrencyIn(converted, defaultCurrency)}';
  }

  /// "09/08/2026 · 14:00" — the time only when the service carries one. A
  /// service registered for a date alone sits at midnight, and printing
  /// "00:00" would invent a precision the record does not have.
  String get _date {
    final date = DateFormat.yMd().format(service.date).normalizeDate();
    final hasTime = service.date.hour != 0 || service.date.minute != 0;

    return hasTime
        ? '$date · ${DateFormat.Hm().format(service.date)}'
        : date;
  }

  String get _status => service.receivedAt == null
      ? KaziLocalizations.current.statusPending
      : KaziLocalizations.current.receivedOn(
          DateFormat.yMd().format(service.receivedAt!).normalizeDate(),
        );

  @override
  Widget build(BuildContext context) {
    final clientName = service.clientName ?? '';
    final description = service.description ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _EarningsPanel(
          service: service,
          currency: currency,
          converted: _inDefaultCurrency(service.commissionValue),
        ),
        KaziSpacings.verticalSm,
        DetailInfoRow(
          label: KaziLocalizations.current.serviceType,
          value: service.catalogItem?.name ?? '',
          categoryColor: service.catalogItem?.colorAs,
        ),
        if (clientName.isNotEmpty)
          DetailInfoRow(
            label: KaziLocalizations.current.client,
            value: clientName,
          ),
        DetailInfoRow(label: KaziLocalizations.current.date, value: _date),
        DetailInfoRow(
          label: KaziLocalizations.current.situation,
          value: _status,
        ),
        if (description.isNotEmpty)
          DetailInfoRow(
            label: KaziLocalizations.current.observation,
            value: description,
          ),
        KaziSpacings.verticalSm,
      ],
    );
  }
}

/// What the user keeps, first and largest — the answer to the question that
/// opened this screen. The gross is context, and follows.
class _EarningsPanel extends StatelessWidget {
  const _EarningsPanel({
    required this.service,
    required this.currency,
    required this.converted,
  });

  final Service service;
  final SupportedCurrency currency;
  final String? converted;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(KaziInsets.md),
      decoration: BoxDecoration(
        color: colors.money.surface,
        borderRadius: KaziRadii.mdBorder,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            // Upper-cased at the call site: Flutter has no text-transform.
            KaziLocalizations.current.yourEarnings.toUpperCase(),
            style: KaziTextStyles.tag.copyWith(color: colors.money.label),
          ),
          KaziSpacings.verticalXs,
          // Scaled rather than wrapped: a truncated amount is worse than a
          // smaller one.
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              NumberFormatUtils.formatCurrencyIn(
                service.commissionValue,
                currency,
              ),
              style: KaziTextStyles.amount.copyWith(
                color: colors.money.onSurface,
              ),
            ),
          ),
          if (converted case final String amount) ...[
            KaziSpacings.verticalXxs,
            Text(
              amount,
              style: KaziTextStyles.labelSmall.copyWith(
                color: colors.money.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ],
          KaziSpacings.verticalXxs,
          Text(
            // Reads `effectiveCommissionPercent`, so a service registered
            // before commissions existed shows the 100% it was paid at rather
            // than a blank.
            KaziLocalizations.current.commissionOfGross(
              NumberFormatUtils.formatPercent(
                service.effectiveCommissionPercent,
              ),
              NumberFormatUtils.formatCurrencyIn(service.value, currency),
            ),
            style: KaziTextStyles.labelSmall.copyWith(
              color: colors.money.accent,
            ),
          ),
        ],
      ),
    );
  }
}
