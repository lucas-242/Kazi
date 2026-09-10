import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kazi/core/currency/currency_providers.dart';
import 'package:kazi/core/routes/app_pages.dart';
import 'package:kazi/core/utils/base_state.dart';
import 'package:kazi/core/widgets/detail_info_row.dart';
import 'package:kazi/features/services/domain/models/catalog_item.dart';
import 'package:kazi/features/services/presenter/controllers/catalog_controller.dart';
import 'package:kazi/features/services/presenter/controllers/catalog_state.dart';
import 'package:kazi/features/services/presenter/controllers/service_landing_controller.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

class CatalogItemDetailsPage extends ConsumerWidget {
  const CatalogItemDetailsPage({super.key, required this.catalogItem});

  /// The item as it was when this page was pushed. A starting point, not the
  /// source of truth: the catalogue list below is what an edit updates.
  final CatalogItem catalogItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<CatalogState>(catalogControllerProvider, (previous, current) {
      if (previous?.status != current.status &&
          current.status == BaseStateStatus.error) {
        KaziSnackbar.show(context, current.callbackMessage);
      }
    });

    final controller = ref.read(catalogControllerProvider.notifier);
    final items = ref.watch(catalogControllerProvider).catalogItems;
    final item = items.firstWhere(
      (candidate) => candidate.id == catalogItem.id,
      orElse: () => catalogItem,
    );

    final currency = SupportedCurrency.fromCode(
      item.currency,
      fallback: ref.watch(kaziDefaultCurrencyProvider),
    );

    void onTapEdit() {
      controller.changeCatalogItem(item);
      KaziNavigator.push(AppPage.addCatalogItem);
    }

    // Archiving is reversible and touches no number, so it asks for no
    // confirmation — the snackbar's Undo is the whole safety net.
    Future<void> onTapArchive() async {
      await controller.archiveCatalogItem(item);

      final isArchived = ref
          .read(catalogControllerProvider)
          .catalogItems
          .any((candidate) => candidate.id == item.id && candidate.isArchived);
      if (!isArchived) return;

      KaziNavigator.pop();
      if (!context.mounted) return;
      KaziUndoSnackbar.show(
        context,
        message: KaziLocalizations.current.archivedSnackbar(item.name),
        onUndo: () => controller.restoreCatalogItem(item),
      );
    }

    return Scaffold(
      appBar: KaziAppBar(
        title: item.name,
        actions: [
          KaziCircularButton.plain(
            onTap: onTapEdit,
            semantics: KaziLocalizations.current.edit,
            child: const Icon(Icons.edit, size: 18),
          ),
          // Archiving lives in the menu; deleting does not appear here at all —
          // it exists only behind the archive screen. See core/archiving.md.
          KaziOverflowMenu(
            semantics: KaziLocalizations.current.actions,
            actions: [
              KaziOverflowAction(
                label: KaziLocalizations.current.archive,
                icon: Icons.archive_outlined,
                isDestructive: true,
                onTap: onTapArchive,
              ),
            ],
          ),
          KaziSpacings.horizontalXs,
        ],
      ),
      body: KaziSafeArea(
        child: _CatalogItemDetails(catalogItem: item, currency: currency),
      ),
    );
  }
}

/// What the user keeps on one of these, then what the item has done — and the
/// warning that editing it changes nothing already registered.
class _CatalogItemDetails extends ConsumerWidget {
  const _CatalogItemDetails({
    required this.catalogItem,
    required this.currency,
  });

  final CatalogItem catalogItem;
  final SupportedCurrency currency;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counters = catalogItem.counters;
    final defaultCurrency = ref.watch(kaziDefaultCurrencyProvider);
    final rateBook =
        ref
            .watch(dayRateBookProvider(ExchangeRates.dateKeyOf(DateTime.now())))
            .asData
            ?.value ??
        const RateBook.empty();

    final generated = counters.generatedIn(
      defaultCurrency,
      rateBook: rateBook,
      legacyCurrency: defaultCurrency,
      dateKey: ExchangeRates.dateKeyOf(DateTime.now()),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _KeepsPanel(catalogItem: catalogItem, currency: currency),
        KaziSpacings.verticalSm,
        if (!counters.isMissing) ...[
          DetailInfoRow(
            icon: Icons.format_list_bulleted,
            label: KaziLocalizations.current.usedIn,
            value: KaziLocalizations.current.servicesCount(counters.count),
            onTap: counters.count == 0
                ? null
                : () {
                    unawaited(
                      ref
                          .read(serviceLandingControllerProvider.notifier)
                          .openCatalogItemHistory(catalogItem.id),
                    );
                    KaziNavigator.navigate(AppPage.services);
                  },
          ),
          DetailInfoRow(
            icon: Icons.trending_up,
            label: KaziLocalizations.current.generatedSoFar,
            value: NumberFormatUtils.formatCurrencyIn(
              generated.amount,
              defaultCurrency,
            ),
          ),
        ],
        DetailInfoRow(
          icon: Icons.payments_outlined,
          label: KaziLocalizations.current.currency,
          value: '${currency.isoCode} (${currency.symbol})',
        ),
        DetailInfoRow.trailing(
          icon: Icons.palette_outlined,
          label: KaziLocalizations.current.color,
          trailing: KaziColorDot(color: catalogItem.colorAs, size: 18),
        ),
        if (counters.count > 0) ...[
          KaziSpacings.verticalSm,
          KaziNote(KaziLocalizations.current.priceChangeNote(counters.count)),
        ],
      ],
    );
  }
}

/// The share of one of these the user takes home — the answer this screen is
/// opened for, so it leads.
class _KeepsPanel extends StatelessWidget {
  const _KeepsPanel({required this.catalogItem, required this.currency});

  final CatalogItem catalogItem;
  final SupportedCurrency currency;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    // An item with no commission configured keeps the whole value.
    final commission = catalogItem.effectiveCommissionPercent ?? 100;
    final value = catalogItem.defaultValue ?? 0;

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
            KaziLocalizations.current.youKeep.toUpperCase(),
            style: KaziTextStyles.tag.copyWith(color: colors.money.onSurface),
          ),
          KaziSpacings.verticalXs,
          // Scaled rather than wrapped: a truncated amount is worse than a
          // smaller one.
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              NumberFormatUtils.formatCurrencyIn(
                value * commission / 100,
                currency,
              ),
              style: KaziTextStyles.amount.copyWith(
                color: colors.money.onSurface,
              ),
            ),
          ),
          KaziSpacings.verticalXxs,
          Text(
            KaziLocalizations.current.commissionOfGross(
              NumberFormatUtils.formatPercent(commission),
              NumberFormatUtils.formatCurrencyIn(value, currency),
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
