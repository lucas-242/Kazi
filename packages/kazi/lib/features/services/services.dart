import 'package:flutter/material.dart';
import 'package:kazi/core/routes/app_pages.dart';
import 'package:kazi/core/routes/navigation_keys.dart';
import 'package:kazi/core/widgets/keyboard_while_on_top.dart';
import 'package:kazi/features/services/domain/models/catalog_item.dart';
import 'package:kazi/features/services/domain/models/service.dart';
import 'package:kazi/features/services/presenter/pages/archived_catalog_page.dart';
import 'package:kazi/features/services/presenter/pages/service_details_page.dart';
import 'package:kazi/features/services/presenter/pages/service_form_page.dart';
import 'package:kazi/features/services/presenter/pages/service_landing_page.dart';
import 'package:kazi/features/services/presenter/pages/catalog_item_details_page.dart';
import 'package:kazi/features/services/presenter/pages/catalog_item_form_page.dart';
import 'package:kazi/features/services/presenter/pages/service_catalog_page.dart';
import 'package:kazi_core/kazi_core.dart' hide Service, CatalogItem;

final class ServiceArguments extends KaziNavigationArguments {
  const ServiceArguments({super.previousPage, this.service});

  final Service? service;
}

final class CatalogItemArguments extends KaziNavigationArguments {
  const CatalogItemArguments({super.previousPage, required this.catalogItem});

  final CatalogItem catalogItem;
}

abstract final class ServicesRoutes {
  // Sub-route paths are relative segments; go_router builds the full location
  // by prefixing the parent (`/services`), matching each `AppPage.route`.
  //
  // `parentNavigatorKey: rootNavigatorKey` makes these screens render on the
  // root navigator, above the AppShell — so they stack full-screen, hiding the
  // bottom navigation, and rely on their own back-button navbar.
  //
  // `KeyboardWhileOnTop` keeps a page covered by a sheet or a dialog from
  // following that keyboard.
  static final GoRoute addService = GoRoute(
    path: 'add-services',
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) => KeyboardWhileOnTop(
      child: Scaffold(
        body: ServiceFormPage(
          service: (state.extra as ServiceArguments?)?.service,
        ),
      ),
    ),
  );

  static final GoRoute serviceDetails = GoRoute(
    path: 'service-details',
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) => KeyboardWhileOnTop(
      child: Scaffold(
        body: ServiceDetailsPage(
          service: (state.extra as ServiceArguments).service!,
        ),
      ),
    ),
  );

  static final GoRoute serviceCatalog = GoRoute(
    path: 'catalog',
    builder: (_, _) => const ServiceCatalogPage(),
    routes: [
      GoRoute(
        path: 'details',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => KeyboardWhileOnTop(
          child: Scaffold(
            body: CatalogItemDetailsPage(
              catalogItem: (state.extra as CatalogItemArguments).catalogItem,
            ),
          ),
        ),
      ),
      GoRoute(
        path: 'add',
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, _) => const KeyboardWhileOnTop(
          child: Scaffold(body: CatalogItemFormPage()),
        ),
      ),
      GoRoute(
        path: 'archived',
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, _) => const ArchivedCatalogPage(),
      ),
    ],
  );

  static GoRoute shellRoute() => GoRoute(
    path: AppPage.services.route,
    builder: (_, _) => const ServiceLandingPage(),
    routes: [addService, serviceDetails],
  );
}
