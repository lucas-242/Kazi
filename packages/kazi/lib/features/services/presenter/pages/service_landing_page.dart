import 'package:flutter/material.dart';
import 'package:kazi/core/utils/base_state.dart';
import 'package:kazi/features/services/presenter/controllers/service_landing_controller.dart';
import 'package:kazi/features/services/presenter/widgets/service_landing_content.dart';
import 'package:kazi/features/services/presenter/widgets/service_filter_chips.dart';
import 'package:kazi/features/services/presenter/widgets/service_navbar.dart';
import 'package:kazi/features/services/presenter/widgets/service_view_switch.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;
import 'package:kazi_core/kazi_core.dart';

class ServiceLandingPage extends ConsumerStatefulWidget {
  const ServiceLandingPage({super.key});

  @override
  ConsumerState<ServiceLandingPage> createState() => _ServiceLandingPageState();
}

class _ServiceLandingPageState extends ConsumerState<ServiceLandingPage> {
  @override
  void initState() {
    super.initState();
    final controller = ref.read(serviceLandingControllerProvider.notifier);
    Future.microtask(controller.onInit);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(serviceLandingControllerProvider);
    final controller = ref.read(serviceLandingControllerProvider.notifier);

    return Scaffold(
      body: KaziSafeArea(
        onRefresh: controller.onRefresh,
        slivers: [
          switch (state.status) {
            // The bar, the switch and the chips stay live above every one of
            // these: loading is per surface, and a filter that emptied the
            // screen has to be undoable from where it was set.
            BaseStateStatus.loading when state.services.isEmpty =>
              const _Surface(child: KaziSkeletonList()),
            BaseStateStatus.error => _Surface(
              child: KaziError(
                message: KaziLocalizations.current.errorToGetServices,
                onRetry: controller.onRefresh,
              ),
            ),
            // `noData` falls through with everything else: a period that came
            // back empty is a cut, not an account, and `ServiceLandingContent`
            // says so without taking the chips away.
            _ => ServiceLandingContent(state: state),
          },
        ],
      ),
    );
  }
}

/// The chrome that outlives whatever is loading or failing under it: the
/// header, the List/Summary switch and the chips. Only the area below them is
/// ever replaced.
class _Surface extends StatelessWidget {
  const _Surface({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const ServiceNavbar(),
          const ServiceViewSwitch(),
          KaziSpacings.verticalSm,
          const ServiceFilterChips(),
          KaziSpacings.verticalMd,
          child,
        ],
      ),
    );
  }
}
