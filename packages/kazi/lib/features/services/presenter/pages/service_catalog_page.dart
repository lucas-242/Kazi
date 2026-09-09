import 'package:flutter/material.dart';
import 'package:kazi/core/routes/app_pages.dart';
import 'package:kazi/core/utils/base_state.dart';
import 'package:kazi/features/services/presenter/controllers/catalog_controller.dart';
import 'package:kazi/features/services/presenter/widgets/catalog_content.dart';
import 'package:kazi/features/services/presenter/widgets/catalog_nav_bar.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;
import 'package:kazi_core/kazi_core.dart';

class ServiceCatalogPage extends ConsumerStatefulWidget {
  const ServiceCatalogPage({super.key});

  @override
  ConsumerState<ServiceCatalogPage> createState() => _ServiceCatalogPageState();
}

class _ServiceCatalogPageState extends ConsumerState<ServiceCatalogPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(catalogControllerProvider.notifier).onInit(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(catalogControllerProvider);
    final controller = ref.read(catalogControllerProvider.notifier);
    final isEmpty = state.status == BaseStateStatus.noData;

    return Scaffold(
      // The shell's own Scaffold does not resize for the keyboard, so this one
      // must not either: shrinking only the inner body ends the content a nav
      // bar's height above the keyboard, with bare background in between. The
      // search field is at the top, and nothing here needs to move for it.
      resizeToAvoidBottomInset: false,
      body: KaziSafeArea(
        isScrollView: !isEmpty,
        onRefresh: controller.getCatalogItems,
        child: switch (state.status) {
          BaseStateStatus.loading when state.catalogItems.isEmpty => Column(
            children: const [
              CatalogNavBar(),
              KaziSpacings.verticalMd,
              KaziSkeletonList(),
            ],
          ),
          BaseStateStatus.error when state.catalogItems.isEmpty => Column(
            children: [
              const CatalogNavBar(),
              Expanded(
                child: KaziError(
                  message: state.callbackMessage,
                  onRetry: controller.getCatalogItems,
                  scrollable: true,
                ),
              ),
            ],
          ),
          BaseStateStatus.noData => Column(
            children: [
              const CatalogNavBar(),
              Expanded(
                child: KaziEmpty(
                  message: KaziLocalizations.current.noCatalogItems,
                  description:
                      KaziLocalizations.current.noCatalogItemsDescription,
                  scrollable: true,
                  action: KaziElevatedButton.label(
                    onTap: () => KaziNavigator.push(AppPage.addCatalogItem),
                    label: KaziLocalizations.current.newCatalogItem,
                  ),
                ),
              ),
            ],
          ),
          _ => const CatalogContent(),
        },
      ),
    );
  }
}
