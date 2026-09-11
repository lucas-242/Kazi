import 'package:flutter/material.dart';
import 'package:kazi/core/services/domain/time_service.dart';
import 'package:kazi/features/services/domain/models/service_view.dart';
import 'package:kazi/features/services/domain/services/service_organizer.dart';
import 'package:kazi/features/services/presenter/controllers/service_landing_controller.dart';
import 'package:kazi/features/services/presenter/controllers/service_landing_state.dart';
import 'package:kazi/features/services/presenter/widgets/period_header_card.dart';
import 'package:kazi/features/services/presenter/widgets/service_filter_chips.dart';
import 'package:kazi/features/services/presenter/widgets/service_list.dart';
import 'package:kazi/features/services/presenter/widgets/service_list_by_date.dart';
import 'package:kazi/features/services/presenter/widgets/service_navbar.dart';
import 'package:kazi/features/services/presenter/widgets/service_search_content.dart';
import 'package:kazi/features/services/presenter/widgets/service_summary_content.dart';
import 'package:kazi/features/services/presenter/widgets/service_view_switch.dart';
import 'package:kazi/injector.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;
import 'package:kazi_core/kazi_core.dart';

/// The tab as slivers: everything above the rows is one box, and the rows are
/// built as they scroll in. See README.md.
class ServiceLandingContent extends ConsumerWidget {
  const ServiceLandingContent({super.key, required this.state});

  final ServiceLandingState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serviceOrganizer = ref.watch(serviceOrganizerProvider);
    final timeService = ref.watch(timeServiceProvider);

    // Search replaces the switch and the chips as well as the header: the
    // period is ignored while searching, so leaving its chip on screen would
    // claim a narrowing that is not happening.
    if (state.isSearching) {
      return SliverMainAxisGroup(
        slivers: [
          const SliverToBoxAdapter(
            child: RepaintBoundary(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [ServiceNavbar(), KaziSpacings.verticalMd],
              ),
            ),
          ),
          ServiceSearchContent(state: state),
        ],
      );
    }

    final showsRows =
        !state.hasNothingToShow && state.view != ServiceView.summary;

    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          // A layer of its own: a box in a sliver gets no repaint boundary,
          // and the whole header would repaint on every frame of a scroll.
          child: RepaintBoundary(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const ServiceNavbar(),
                const ServiceViewSwitch(),
                KaziSpacings.verticalSm,
                const ServiceFilterChips(),
                KaziSpacings.verticalSm,
                // The chips stay above whatever this resolves to, so a filter
                // that empties the screen can always be undone from where it
                // was set.
                if (state.hasNothingToShow)
                  _NothingToShow(state: state)
                else if (state.view == ServiceView.summary)
                  ServiceSummaryContent(state: state)
                else ...[
                  PeriodHeaderCard(state: state),
                  KaziSpacings.verticalSm,
                ],
              ],
            ),
          ),
        ),
        if (showsRows)
          _ServiceList(
            state: state,
            serviceOrganizer: serviceOrganizer,
            timeService: timeService,
          ),
      ],
    );
  }
}

/// Nothing in the cut on screen. Never the brand empty state: this tab reads
/// one period, so it cannot tell an account with nothing from a quiet month,
/// and inviting someone to register their first service when they have
/// hundreds is worse than saying less.
///
/// The way out is only offered when there is something to clear.
class _NothingToShow extends ConsumerWidget {
  const _NothingToShow({required this.state});

  final ServiceLandingState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = KaziLocalizations.current;

    if (!state.hasActiveFilters) {
      return KaziNoResults(message: l10n.noServicesFound);
    }

    return KaziNoResults(
      message: l10n.noServicesForFilters,
      actionLabel: l10n.removeFilters,
      onAction: ref.read(serviceLandingControllerProvider.notifier).onClearFilters,
    );
  }
}

/// The rows, as a sliver.
class _ServiceList extends StatelessWidget {
  const _ServiceList({
    required this.state,
    required this.serviceOrganizer,
    required this.timeService,
  });

  final ServiceLandingState state;
  final ServiceOrganizer serviceOrganizer;
  final TimeService timeService;

  @override
  Widget build(BuildContext context) {
    // Everything below lists what the chips left standing, so the rows and the
    // totals in the summary always describe the same set of services.
    final services = state.visibleServices;

    if (_showLastMonthServices(timeService)) {
      return ServiceList.sliver(
        title: KaziLocalizations.current.filteringLastMonth,
        services: services,
      );
    }
    if (_showServicesAreNotInCurrentMonth(timeService)) {
      return ServiceList.sliver(
        title: KaziLocalizations.current.fromTo(
          DateFormat.yMd().format(state.startDate).normalizeDate(),
          DateFormat.yMd().format(state.endDate).normalizeDate(),
        ),
        services: services,
      );
    }

    return ServiceListByDate(
      servicesByDateList: serviceOrganizer.groupServicesByDate(
        services,
        state.selectedOrderBy,
      ),
    );
  }

  bool _showLastMonthServices(TimeService timeService) =>
      state.fastSearch == FastSearch.lastMonth ||
      timeService.isRangeInLastMonth(state.startDate, state.endDate);

  bool _showServicesAreNotInCurrentMonth(TimeService timeService) =>
      !timeService.isRangeInThisMonth(state.startDate, state.endDate);
}
