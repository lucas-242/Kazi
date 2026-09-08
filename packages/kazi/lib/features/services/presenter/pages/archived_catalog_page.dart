import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kazi/core/currency/currency_providers.dart';
import 'package:kazi/core/routes/app_pages.dart';
import 'package:kazi/core/utils/base_state.dart';
import 'package:kazi/core/widgets/archived_delete_row.dart';
import 'package:kazi/core/widgets/archived_record_tile.dart';
import 'package:kazi/features/services/domain/models/catalog_item.dart';
import 'package:kazi/features/services/presenter/controllers/archived_catalog_controller.dart';
import 'package:kazi/features/services/presenter/controllers/archived_catalog_state.dart';
import 'package:kazi/features/services/presenter/controllers/catalog_controller.dart';
import 'package:kazi/features/services/presenter/controllers/service_landing_controller.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

class ArchivedCatalogPage extends ConsumerStatefulWidget {
  const ArchivedCatalogPage({super.key});

  @override
  ConsumerState<ArchivedCatalogPage> createState() =>
      _ArchivedCatalogPageState();
}

class _ArchivedCatalogPageState extends ConsumerState<ArchivedCatalogPage> {
  bool _leaving = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(archivedCatalogControllerProvider.notifier).onInit(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final counts = ref.watch(archivedCatalogControllerProvider);
    final items = ref.watch(catalogControllerProvider).archivedCatalogItems;

    // Emptying the screen leaves nothing to come back to: leave rather than
    // show an empty archive. Guarded, because build runs again before the
    // microtask lands and a second pop would take the caller's screen with it.
    if (items.isEmpty &&
        counts.status != BaseStateStatus.loading &&
        !_leaving) {
      _leaving = true;
      Future.microtask(KaziNavigator.pop);
    }

    return Scaffold(
      appBar: KaziAppBar(title: KaziLocalizations.current.archivedCatalogItems),
      body: KaziSafeArea(
        isLoading: counts.status == BaseStateStatus.loading,
        // The list is the catalogue's archive and the counts are this
        // controller's, so a refresh has to bring both back.
        onRefresh: () async {
          await ref.read(catalogControllerProvider.notifier).getCatalogItems();
          await ref.read(archivedCatalogControllerProvider.notifier).onInit();
        },
        child: switch (counts.status) {
          BaseStateStatus.loading => const KaziSkeletonList(count: 3),
          BaseStateStatus.error => KaziError(
            message: counts.callbackMessage,
            onRetry: () =>
                ref.read(archivedCatalogControllerProvider.notifier).onInit(),
          ),
          _ => _ArchivedCatalog(items: items, counts: counts),
        },
      ),
    );
  }
}

/// What was put away, then — kept apart, under its own heading — what may be
/// erased. Restoring and deleting never share a row: one is routine and
/// reversible, the other is the only thing in the app that is neither.
class _ArchivedCatalog extends StatelessWidget {
  const _ArchivedCatalog({required this.items, required this.counts});

  final List<CatalogItem> items;
  final ArchivedCatalogState counts;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KaziNote(KaziLocalizations.current.archivedCatalogNote),
        KaziSpacings.verticalMd,
        for (final item in items) ...[
          _RestoreRow(catalogItem: item, linkedServices: counts.countFor(item.id)),
          KaziSpacings.verticalXs,
        ],
        KaziSpacings.verticalMd,
        Text(
          KaziLocalizations.current.deletePermanently.toUpperCase(),
          style: KaziTextStyles.tag.copyWith(color: context.colors.textMuted),
        ),
        KaziSpacings.verticalXs,
        for (final item in items) ...[
          _DeleteRow(catalogItem: item, linkedServices: counts.countFor(item.id)),
          KaziSpacings.verticalXs,
        ],
        KaziSpacings.verticalLg,
      ],
    );
  }
}

class _RestoreRow extends ConsumerWidget {
  const _RestoreRow({required this.catalogItem, required this.linkedServices});

  final CatalogItem catalogItem;
  final int? linkedServices;

  /// "12 services · Archived on 03/08/2026", less whichever half is unknown.
  String _subtitle() {
    final used = linkedServices == null
        ? null
        : linkedServices == 0
        ? KaziLocalizations.current.noServices
        : KaziLocalizations.current.servicesCount(linkedServices!);
    final archivedAt = catalogItem.archivedAt;
    final when = archivedAt == null
        ? null
        : KaziLocalizations.current.archivedOn(archivedAt.format());

    return [used, when].nonNulls.join(' · ');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ArchivedRecordTile(
      name: catalogItem.name,
      subtitle: _subtitle(),
      color: catalogItem.colorAs,
      onRestore: () => ref
          .read(catalogControllerProvider.notifier)
          .restoreCatalogItem(catalogItem),
    );
  }
}

class _DeleteRow extends ConsumerWidget {
  const _DeleteRow({required this.catalogItem, required this.linkedServices});

  final CatalogItem catalogItem;

  /// Null while the count has not arrived. Not knowing is not the same as
  /// knowing it is free, so it is treated as blocked until it does.
  final int? linkedServices;

  bool get _deletable => linkedServices == 0;

  /// Says why it cannot go, with the number that makes the reason concrete, and
  /// offers the way to check. Deleting an item still in use would leave its old
  /// services rendering a nameless placeholder — see core/archiving.md.
  void _explainBlocked(BuildContext context, WidgetRef ref) {
    final count = linkedServices ?? 0;
    final currency = ref.read(kaziDefaultCurrencyProvider);
    final rateBook =
        ref
            .read(dayRateBookProvider(ExchangeRates.dateKeyOf(DateTime.now())))
            .asData
            ?.value ??
        const RateBook.empty();
    final generated = catalogItem.counters.generatedIn(
      currency,
      rateBook: rateBook,
      legacyCurrency: currency,
      dateKey: ExchangeRates.dateKeyOf(DateTime.now()),
    );

    showDialog<void>(
      context: context,
      builder: (_) => KaziDialog(
        icon: Icons.error_outline,
        title: KaziLocalizations.current.cantDeleteTitle(catalogItem.name),
        message:
            '${KaziLocalizations.current.cantDeleteBody(count, NumberFormatUtils.formatCurrencyIn(generated.amount, currency))}'
            '\n\n${KaziLocalizations.current.cantDeleteReassurance}',
        cancelText: KaziLocalizations.current.understood,
        confirmText: KaziLocalizations.current.seeTheServices(count),
        onCancel: KaziNavigator.pop,
        onConfirm: () {
          KaziNavigator.pop();
          unawaited(
            ref
                .read(serviceLandingControllerProvider.notifier)
                .openServices(catalogItemId: catalogItem.id),
          );
          KaziNavigator.navigate(AppPage.services);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ArchivedDeleteRow(
      name: catalogItem.name,
      note: _deletable
          ? KaziLocalizations.current.freeToDelete
          : KaziLocalizations.current.usedInServices(linkedServices ?? 0),
      deletable: _deletable,
      onTap: () => _deletable
          ? confirmPermanentDelete(
              context,
              name: catalogItem.name,
              message: KaziLocalizations.current.deleteNoServicesImpact,
              onDelete: () => ref
                  .read(archivedCatalogControllerProvider.notifier)
                  .deleteCatalogItem(catalogItem),
            )
          : _explainBlocked(context, ref),
    );
  }
}
