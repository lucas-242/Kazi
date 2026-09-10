import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:kazi/core/utils/base_state.dart';
import 'package:kazi/features/clients/domain/models/client_entry.dart';
import 'package:kazi/features/services/domain/models/receipt_filter.dart';
import 'package:kazi/features/services/domain/models/service.dart';
import 'package:kazi/features/services/domain/models/service_breakdown.dart';
import 'package:kazi/features/services/domain/models/service_totals.dart';
import 'package:kazi/features/services/domain/models/service_view.dart';
import 'package:kazi/features/services/domain/models/weekly_earnings.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

/// Distinguishes "no client selected" from "clear the selected client" in
/// [ServiceLandingState.copyWith], where a plain null argument is
/// indistinguishable from an omitted one.
const Object _unset = Object();

/// The window the tab opens on, and the one [ServiceLandingState.fastSearch]
/// has to differ from for the period to count as filtered.
const FastSearch _defaultFastSearch = FastSearch.month;

class ServiceLandingState extends BaseState with Equatable {
  ServiceLandingState({
    required super.status,
    List<Service>? services,
    super.callbackMessage,
    required this.startDate,
    required this.endDate,
    this.fastSearch = _defaultFastSearch,
    this.selectedOrderBy = OrderBy.dateDesc,
    this.defaultCurrency = SupportedCurrency.usd,
    this.rateBook = const RateBook.empty(),
    this.view = ServiceView.list,
    this.receiptFilter = ReceiptFilter.all,
    this.clientId,
    this.catalogItemIds = const {},
    this.isSearching = false,
    this.searchTerm = '',
    List<Service>? searchServices,
    this.searchClients = const [],
  }) : services = services ?? [],
       searchServices = searchServices ?? [];
  final DateTime startDate;
  final DateTime endDate;
  final FastSearch fastSearch;
  final OrderBy selectedOrderBy;

  /// Everything fetched for the period. The two chip filters below narrow it
  /// in memory; see [visibleServices].
  final List<Service> services;

  /// Currency the totals are expressed in (the user's profile default).
  final SupportedCurrency defaultCurrency;

  /// Rate snapshots covering the dates of [services].
  final RateBook rateBook;

  /// Which representation of [visibleServices] is on screen.
  final ServiceView view;

  final ReceiptFilter receiptFilter;

  /// Narrows the list to a single client. Null means every client.
  final String? clientId;

  /// Narrows the list to a set of catalog items. Empty means every item.
  final Set<String> catalogItemIds;

  /// Whether the header is a search field rather than a title. Search is a
  /// mode of this screen, not a route of its own.
  final bool isSearching;

  final String searchTerm;

  /// Everything ever registered, fetched once when search opens.
  ///
  /// Search deliberately ignores the period — someone typing a client's name
  /// wants to find them in everything they have registered, not in the six
  /// weeks the chips happen to be showing.
  final List<Service> searchServices;

  /// Clients matching [searchTerm], which the services alone cannot supply: a
  /// client with no service yet would never appear.
  final List<ClientEntry> searchClients;

  /// What the user is actually looking at: [services] after the receipt and
  /// client chips. Everything downstream — the list, the totals, the
  /// breakdowns and the bulk "mark as received" — reads this, so the numbers
  /// always describe the rows on screen.
  List<Service> get visibleServices => services
      .where(
        (service) =>
            receiptFilter.allows(service) &&
            (clientId == null || service.clientId == clientId) &&
            (catalogItemIds.isEmpty ||
                catalogItemIds.contains(service.catalogItemId)),
      )
      .toList();

  /// The services [searchTerm] matches, across type, client and note. Ordered
  /// by date, newest first — a search result has no period to group by.
  List<Service> get searchedServices {
    final term = searchTerm.trim().normalizedName;
    if (term.isEmpty) return const [];

    return searchServices.where((service) {
          final haystack = [
            service.catalogItem?.name ?? '',
            service.clientName ?? '',
            service.description ?? '',
          ].join(' ').normalizedName;

          return haystack.contains(term);
        }).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  /// What the search found, totalled — the header the results block carries.
  ServiceTotals get searchTotals => ServiceTotals.from(
    searchedServices,
    currency: defaultCurrency,
    rateBook: rateBook,
  );

  ServiceTotals get totals => ServiceTotals.from(
    visibleServices,
    currency: defaultCurrency,
    rateBook: rateBook,
  );

  ServiceBreakdown breakdownByType(String untypedLabel) =>
      ServiceBreakdown.byType(
        visibleServices,
        currency: defaultCurrency,
        rateBook: rateBook,
        untypedLabel: untypedLabel,
      );

  /// The filtered services as one bar per week of the filtered period.
  WeeklyEarnings get weeklyEarnings => WeeklyEarnings.from(
    visibleServices,
    start: startDate,
    end: endDate,
    currency: defaultCurrency,
    rateBook: rateBook,
  );

  ServiceBreakdown get breakdownByClient => ServiceBreakdown.byClient(
    visibleServices,
    currency: defaultCurrency,
    rateBook: rateBook,
  );

  bool get hasSecondaryFilters =>
      receiptFilter != ReceiptFilter.all ||
      clientId != null ||
      catalogItemIds.isNotEmpty;

  /// Catalog items with a service in this period, and how many — for the
  /// filter sheet, which counts what it offers.
  ///
  /// Derived from the fetched list rather than from the catalog: offering an
  /// item with nothing to show would be a filter that can only empty the
  /// screen. Ordered by name.
  List<({String id, String name, int count, Color? color})>
  get filterableCatalogItems {
    final names = <String, String>{};
    final colors = <String, Color?>{};
    final counts = <String, int>{};

    for (final service in services) {
      final id = service.catalogItemId;
      final name = service.catalogItem?.name ?? '';
      if (id.isEmpty || name.isEmpty) continue;
      names.putIfAbsent(id, () => name);
      colors.putIfAbsent(id, () => service.catalogItem?.colorAs);
      counts[id] = (counts[id] ?? 0) + 1;
    }

    return names.entries
        .map(
          (entry) => (
            id: entry.key,
            name: entry.value,
            count: counts[entry.key] ?? 0,
            color: colors[entry.key],
          ),
        )
        .toList()
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  }

  /// Whether anything is narrowing the list right now.
  ///
  /// Derived, never stored: a flag raised when a filter is touched stays up
  /// after the user puts every filter back where it started, and the badge on
  /// the filter button then reports a narrowing that is not happening.
  bool get hasActiveFilters =>
      fastSearch != _defaultFastSearch || hasSecondaryFilters;

  /// Nothing to show for the cut on screen.
  ///
  /// Never an account with nothing in it: the tab only ever fetches one
  /// period, so an empty answer says nothing about whether anything was ever
  /// registered — and finding that out would cost a second read. The chips
  /// stay above it either way, or there would be no way back.
  bool get hasNothingToShow => visibleServices.isEmpty;

  /// Clients that actually have a service in this period, for the picker.
  ///
  /// Derived from the fetched list rather than from the clients repository:
  /// offering a client with nothing to show would be a filter that can only
  /// empty the screen. Ordered by name.
  List<({String id, String name})> get filterableClients {
    final byId = <String, String>{};

    for (final service in services) {
      final id = service.clientId;
      final name = service.clientName;
      if (id == null || id.isEmpty || name == null || name.isEmpty) continue;
      byId.putIfAbsent(id, () => name);
    }

    return byId.entries
        .map((entry) => (id: entry.key, name: entry.value))
        .toList()
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  }

  @override
  ServiceLandingState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
    List<Service>? services,
    DateTime? startDate,
    DateTime? endDate,
    FastSearch? fastSearch,
    OrderBy? selectedOrderBy,
    SupportedCurrency? defaultCurrency,
    RateBook? rateBook,
    ServiceView? view,
    ReceiptFilter? receiptFilter,
    Object? clientId = _unset,
    Set<String>? catalogItemIds,
    bool? isSearching,
    String? searchTerm,
    List<Service>? searchServices,
    List<ClientEntry>? searchClients,
  }) {
    return ServiceLandingState(
      status: status ?? this.status,
      callbackMessage: callbackMessage ?? this.callbackMessage,
      services: services ?? this.services,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      fastSearch: fastSearch ?? this.fastSearch,
      selectedOrderBy: selectedOrderBy ?? this.selectedOrderBy,
      defaultCurrency: defaultCurrency ?? this.defaultCurrency,
      rateBook: rateBook ?? this.rateBook,
      view: view ?? this.view,
      receiptFilter: receiptFilter ?? this.receiptFilter,
      clientId: clientId == _unset ? this.clientId : clientId as String?,
      catalogItemIds: catalogItemIds ?? this.catalogItemIds,
      isSearching: isSearching ?? this.isSearching,
      searchTerm: searchTerm ?? this.searchTerm,
      searchServices: searchServices ?? this.searchServices,
      searchClients: searchClients ?? this.searchClients,
    );
  }

  @override
  List<Object?> get props => [
    startDate,
    endDate,
    fastSearch,
    selectedOrderBy,
    services,
    defaultCurrency,
    rateBook,
    view,
    receiptFilter,
    clientId,
    catalogItemIds,
    isSearching,
    searchTerm,
    searchServices,
    searchClients,
    status,
    callbackMessage,
  ];
}
