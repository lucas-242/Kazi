import 'package:flutter/material.dart';
import 'package:kazi/core/routes/app_pages.dart';
import 'package:kazi/core/widgets/archived_record_tile.dart';
import 'package:kazi/features/services/domain/models/catalog_filter.dart';
import 'package:kazi/features/services/presenter/controllers/catalog_controller.dart';
import 'package:kazi/features/services/presenter/controllers/catalog_state.dart';
import 'package:kazi/features/services/presenter/widgets/catalog_item_card.dart';
import 'package:kazi/features/services/presenter/widgets/catalog_nav_bar.dart';
import 'package:kazi/features/services/services.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

class CatalogContent extends ConsumerWidget {
  const CatalogContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(catalogControllerProvider);
    final items = state.visibleCatalogItems;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CatalogNavBar(),
        KaziSpacings.verticalMd,
        // A term is its own cut. Leaving the chips under it would offer a
        // second one over a list the person is already narrowing by hand.
        if (!state.isSearching) ...[
          _FilterChips(state: state),
          KaziSpacings.verticalMd,
        ],
        if (state.isSearchEmpty && state.archivedMatching.isNotEmpty)
          _ArchivedMatches(state: state)
        else if (state.isSearchEmpty)
          _SearchEmpty(state: state)
        else if (state.isFilteredEmpty)
          _FilteredEmpty(state: state)
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (context, index) => KaziSpacings.verticalXs,
            itemBuilder: (context, index) => CatalogItemCard(
              catalogItem: items[index],
              onTap: (catalogItem) => KaziNavigator.push(
                AppPage.catalogItemDetails,
                extra: CatalogItemArguments(catalogItem: catalogItem),
              ),
            ),
          ),
        KaziSpacings.verticalLg,
      ],
    );
  }
}

class _FilterChips extends ConsumerWidget {
  const _FilterChips({required this.state});

  final CatalogState state;

  String _label(CatalogFilter filter) => switch (filter) {
    CatalogFilter.all => KaziLocalizations.current.catalogAll,
    CatalogFilter.mostUsed => KaziLocalizations.current.catalogMostUsed,
    CatalogFilter.withoutCommission =>
      KaziLocalizations.current.catalogWithoutCommission,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(catalogControllerProvider.notifier);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: KaziInsets.xs,
        children: [
          for (final filter in CatalogFilter.values)
            KaziChip(
              label: _label(filter),
              isSelected: state.filter == filter,
              onTap: () => controller.onChangeFilter(filter),
            ),
        ],
      ),
    );
  }
}

/// The chips hid every item. Never the empty state — removing the chip would
/// bring rows back, so what is missing is the cut, not the catalogue.
class _FilteredEmpty extends ConsumerWidget {
  const _FilteredEmpty({required this.state});

  final CatalogState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return KaziNoResults(
      message: KaziLocalizations.current.noResults,
      actionLabel: KaziLocalizations.current.removeFilters,
      onAction: () => ref
          .read(catalogControllerProvider.notifier)
          .onChangeFilter(CatalogFilter.all),
    );
  }
}

/// The term matched nothing active and nothing archived either: it is repeated
/// back, with the way to create what was looked for.
class _SearchEmpty extends ConsumerWidget {
  const _SearchEmpty({required this.state});

  final CatalogState state;

  void _createTyped(WidgetRef ref) {
    ref.read(catalogControllerProvider.notifier).changeCatalogItemName(
      state.query,
    );
    KaziNavigator.push(AppPage.addCatalogItem);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return KaziNoResults(
      icon: Icons.search,
      message: KaziLocalizations.current.nothingFoundFor(state.query),
      description: KaziLocalizations.current.nothingFoundInCatalog,
      actionLabel: KaziLocalizations.current.createInCatalog(state.query),
      onAction: () => _createTyped(ref),
    );
  }
}

/// The term found nothing active, but it did find something put away.
///
/// Nothing was found is then the wrong thing to say, and offering to create
/// what already exists archived is how the catalogue grows a duplicate — so the
/// archived rows are the whole answer, offering the one thing that resolves it.
class _ArchivedMatches extends ConsumerWidget {
  const _ArchivedMatches({required this.state});

  final CatalogState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          KaziLocalizations.current.archivedSectionLabel.toUpperCase(),
          style: KaziTextStyles.tag.copyWith(color: context.colors.textMuted),
        ),
        KaziSpacings.verticalXs,
        // The archive screen's own row, so an item found here reads exactly as
        // it does there — and offers the same one thing.
        for (final item in state.archivedMatching) ...[
          ArchivedRecordTile(
            name: item.name,
            subtitle: KaziLocalizations.current.usesCount(item.counters.count),
            color: item.colorAs,
            onRestore: () => ref
                .read(catalogControllerProvider.notifier)
                .restoreCatalogItem(item),
          ),
          KaziSpacings.verticalXs,
        ],
      ],
    );
  }
}
