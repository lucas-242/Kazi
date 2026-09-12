import 'package:kazi_core/kazi_core.dart';

enum AppPage implements KaziPage {
  initial('/', -1),
  login('/login', -1),
  forcedUpdate('/forced-update', -1),
  currencyMigration('/currency-migration', -1),
  onboarding('/onboarding', -1),
  home('/home', 0),
  services('/services', 1),
  serviceDetails('/services/service-details', 1),
  addServices('/services/add-services', 1),
  clients('/clients', 2),
  clientDetails('/clients/client-details', 2),
  addClient('/clients/add-client', 2),
  archivedClients('/clients/archived', 2),
  settings('/settings', 3),
  serviceCatalog('/settings/catalog', 3),
  catalogItemDetails('/settings/catalog/details', 3),
  addCatalogItem('/settings/catalog/add', 3),
  archivedCatalogItems('/settings/catalog/archived', 3),
  billingCycle('/settings/billing-cycle', 3),
  howToUse('/settings/how-to-use', 3),
  privacyPolicy('/settings/privacy-policy', 3),
  themeGallery('/settings/design-tokens', 3),
  tapHeatmap('/settings/tap-heatmap', 3);

  const AppPage(this.route, this.pageIndex);

  /// Full, absolute location used to navigate to this page. Sub-routes keep
  /// their parent prefix so `go`/`push` resolve against the real route tree.
  @override
  final String route;

  /// Index of the bottom navigation tab this page belongs to (`-1` when the
  /// page is not part of the tab bar).
  @override
  final int pageIndex;

  /// Resolves the page owning [route] by longest matching prefix, so nested
  /// locations (e.g. `/services/add-services`) map to the most specific page.
  static AppPage fromRoute(String route) {
    final path = route.split('?').first;
    AppPage? best;
    for (final page in values) {
      final candidate = page.route;
      final matches = candidate == '/'
          ? path == '/'
          : path == candidate || path.startsWith('$candidate/');
      if (matches && (best == null || candidate.length > best.route.length)) {
        best = page;
      }
    }
    return best ?? home;
  }

  /// Resolves the first page belonging to the given bottom navigation tab.
  static AppPage fromIndex(int index) {
    return values.firstWhere((e) => e.pageIndex == index, orElse: () => home);
  }
}
