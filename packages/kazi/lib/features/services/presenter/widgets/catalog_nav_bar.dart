import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kazi/core/routes/app_pages.dart';
import 'package:kazi/core/widgets/sub_nav_bar.dart';
import 'package:kazi/features/services/presenter/controllers/catalog_controller.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

/// The catalogue's header, the same one in every state of the screen — the
/// count, the two ways in and the archive do not depend on whether the list
/// below them managed to load.
///
/// Becomes the search field while a search is open, so the term takes the row
/// it is narrowing rather than pushing it down.
class CatalogNavBar extends ConsumerWidget {
  const CatalogNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(catalogControllerProvider);
    if (state.isSearching) return const _SearchBar();

    final controller = ref.read(catalogControllerProvider.notifier);
    final count = state.activeCatalogItems.length;

    return SubNavBar(
      title: KaziLocalizations.current.catalogItems,
      showDivider: false,
      pills: [
        if (count > 0) ...[
          Semantics(
            label: KaziLocalizations.current.catalogItems,
            child: Text(
              count.toString(),
              style: KaziTextStyles.tag.copyWith(
                color: context.colors.textMuted,
              ),
            ),
          ),
          KaziSpacings.horizontalXs,
          KaziCircularButton.plain(
            onTap: controller.onOpenSearch,
            semantics: KaziLocalizations.current.search,
            child: const Icon(Icons.search, size: 18),
          ),
        ],
        KaziCircularButton.plain(
          onTap: () => KaziNavigator.push(AppPage.addCatalogItem),
          semantics: KaziLocalizations.current.add,
          child: const Icon(Icons.add, size: 18),
        ),
        KaziOverflowMenu(
          semantics: KaziLocalizations.current.actions,
          actions: [
            if (state.archivedCount > 0)
              KaziOverflowAction(
                label: KaziLocalizations.current.viewArchived(
                  state.archivedCount,
                ),
                icon: Icons.inventory_2_outlined,
                onTap: () => KaziNavigator.push(AppPage.archivedCatalogItems),
              ),
          ],
        ),
      ],
    );
  }
}

class _SearchBar extends ConsumerStatefulWidget {
  const _SearchBar();

  @override
  ConsumerState<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<_SearchBar> {
  static const _debounce = Duration(milliseconds: 400);

  final _controller = TextEditingController();
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _timer?.cancel();
    _timer = Timer(_debounce, () {
      ref.read(catalogControllerProvider.notifier).onSearch(value);
    });
  }

  void _clear() {
    _timer?.cancel();
    _controller.clear();
    ref.read(catalogControllerProvider.notifier).onSearch('');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        KaziBackButton(
          onTap: () {
            _timer?.cancel();
            ref.read(catalogControllerProvider.notifier).onCloseSearch();
          },
        ),
        KaziSpacings.horizontalXs,
        Expanded(
          child: TextField(
            controller: _controller,
            autofocus: true,
            textInputAction: TextInputAction.search,
            onChanged: _onChanged,
            decoration: InputDecoration(
              isDense: true,
              hintText: KaziLocalizations.current.searchByName,
              prefixIcon: const Icon(Icons.search, size: 18),
            ),
          ),
        ),
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _controller,
          builder: (context, value, _) => value.text.isEmpty
              ? const SizedBox.shrink()
              : KaziCircularButton.plain(
                  onTap: _clear,
                  semantics: KaziLocalizations.current.clear,
                  child: const Icon(Icons.close, size: 18),
                ),
        ),
      ],
    );
  }
}
