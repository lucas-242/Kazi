import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kazi/core/widgets/sub_nav_bar.dart';
import 'package:kazi/features/onboarding/domain/models/onboarding_hint.dart';
import 'package:kazi/features/onboarding/presenter/widgets/hint_anchor.dart';
import 'package:kazi/features/services/presenter/controllers/service_landing_controller.dart';
import 'package:kazi/features/services/presenter/pages/service_filters_page.dart';
import 'package:kazi/features/services/presenter/widgets/order_by_bottom_sheet.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;
import 'package:kazi_core/kazi_core.dart';

class ServiceNavbar extends ConsumerWidget {
  const ServiceNavbar({super.key});

  /// Below this many records the list is short enough to read whole, and a
  /// hint about filtering it would be advice nobody needs yet.
  static const int _hintMinimumServices = 5;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serviceState = ref.watch(serviceLandingControllerProvider);
    final serviceController = ref.read(
      serviceLandingControllerProvider.notifier,
    );

    // Search is a mode of this screen: the header becomes the field, and comes
    // back when it closes. It is never a route, so the back gesture still
    // leaves the tab rather than leaving the search.
    if (serviceState.isSearching) return const _SearchBar();

    return SubNavBar(
      title: KaziLocalizations.current.services.capitalize(),
      showBack: false,
      pills: [
        KaziCircularButton.plain(
          onTap: serviceController.onOpenSearch,
          semantics: KaziLocalizations.current.search,
          child: const Icon(Icons.search, size: 18),
        ),
        KaziCircularButton.plain(
          onTap: () => KaziNavigator.showBottomSheet<void>(
            context: context,
            useRootNavigator: true,
            isScrollControlled: true,
            builder: (context) => OrderByBottomSheet(
              selectedOption: serviceState.selectedOrderBy,
              onPressed: (orderBy) {
                KaziNavigator.pop();
                serviceController.onChangeOrderBy(orderBy);
              },
            ),
          ),
          child: const Icon(Icons.swap_vert, size: 18),
        ),
        HintAnchor(
          hint: OnboardingHint.filters,
          enabled: serviceState.services.length >= _hintMinimumServices,
          child: KaziCircularButton.plain(
            showCircularIndicator: serviceState.hasActiveFilters,
            onTap: () => KaziNavigator.showBottomSheet<void>(
              context: context,
              useRootNavigator: true,
              isScrollControlled: true,
              builder: (context) => const FiltersBottomSheet(),
            ),
            child: const Icon(Icons.filter_alt_outlined, size: 18),
          ),
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
  /// Long enough that a name is typed rather than spelled out, short enough
  /// that the results feel attached to the keys.
  static const _debounce = Duration(milliseconds: 400);

  final _controller = TextEditingController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller.text = ref.read(serviceLandingControllerProvider).searchTerm;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String term) {
    _timer?.cancel();
    _timer = Timer(_debounce, () {
      ref
          .read(serviceLandingControllerProvider.notifier)
          .onSearchTermChanged(term);
    });
  }

  void _close() {
    _timer?.cancel();
    ref.read(serviceLandingControllerProvider.notifier).onCloseSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        KaziCircularButton.plain(
          onTap: _close,
          semantics: KaziLocalizations.current.back,
          child: const Icon(Icons.arrow_back, size: 18),
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
              hintText: KaziLocalizations.current.searchServicesHint,
              prefixIcon: const Icon(Icons.search, size: 18),
              suffixIcon: _controller.text.isEmpty
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.close, size: 18),
                      onPressed: () {
                        _controller.clear();
                        _onChanged('');
                        setState(() {});
                      },
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
