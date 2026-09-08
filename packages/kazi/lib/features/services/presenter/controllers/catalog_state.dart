import 'package:equatable/equatable.dart';
import 'package:kazi/core/utils/base_state.dart';
import 'package:kazi/features/services/domain/models/catalog_filter.dart';
import 'package:kazi/features/services/domain/models/catalog_item.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

class CatalogState extends BaseState with Equatable {
  CatalogState({
    required this.userId,
    CatalogItem? catalogItem,
    List<CatalogItem>? catalogItemList,
    this.archivedCollision,
    this.filter = CatalogFilter.all,
    this.query = '',
    this.isSearching = false,
    required super.status,
    super.callbackMessage,
  }) : catalogItem = catalogItem ?? CatalogItem(userId: userId),
       catalogItems = catalogItemList ?? [];

  /// Every item the user owns, archived ones included — the services list joins
  /// against this list, so dropping archived items here would cost old services
  /// their name and colour. Screens that present items read [activeCatalogItems].
  final List<CatalogItem> catalogItems;
  final CatalogItem catalogItem;
  final String userId;

  /// An archived item whose name the user just tried to reuse. The form offers
  /// to restore it instead of refusing the name, which is what stops the
  /// catalog from growing a second row that splits the same total in two.
  final CatalogItem? archivedCollision;

  final CatalogFilter filter;

  final String query;

  /// Whether the header is a search field rather than a title.
  final bool isSearching;

  List<CatalogItem> get activeCatalogItems =>
      catalogItems.where((item) => !item.isArchived).toList();

  /// What the chips and the search term left standing, in the order the chip
  /// implies. Both cuts are made in memory: this keepAlive controller holds the
  /// whole catalogue, so neither costs a query.
  List<CatalogItem> get visibleCatalogItems {
    final items = _matching(activeCatalogItems);

    return switch (filter) {
      CatalogFilter.all => items,
      CatalogFilter.withoutCommission =>
        items.where((item) => item.effectiveCommissionPercent == null).toList(),
      CatalogFilter.mostUsed => [
        ...items,
      ]..sort((a, b) => b.counters.count.compareTo(a.counters.count)),
    };
  }

  /// Archived items the term found. What was searched for may be in the
  /// catalogue already, put away — offering to restore it is what stops the
  /// user recreating it as a duplicate.
  List<CatalogItem> get archivedMatching =>
      query.isEmpty ? const [] : _matching(archivedCatalogItems);

  List<CatalogItem> _matching(List<CatalogItem> items) {
    if (query.isEmpty) return items;

    final term = query.normalizedName;
    return items
        .where((item) => item.name.normalizedName.contains(term))
        .toList();
  }

  /// The term matched nothing active — a cut with no rows, which offers to
  /// create what was typed rather than saying the catalogue is empty.
  bool get isSearchEmpty => query.isNotEmpty && visibleCatalogItems.isEmpty;

  /// The chips alone hide every item. Never with a term standing: that is
  /// [isSearchEmpty], and the two states offer different ways out.
  bool get isFilteredEmpty =>
      query.isEmpty &&
      activeCatalogItems.isNotEmpty &&
      visibleCatalogItems.isEmpty;

  CatalogItem? activeNamed(String name, {String? excluding}) {
    final normalized = name.normalizedName;
    if (normalized.isEmpty) return null;

    for (final item in activeCatalogItems) {
      if (item.id == excluding) continue;
      if (item.name.normalizedName == normalized) return item;
    }
    return null;
  }

  CatalogItem? get nameCollision =>
      activeNamed(catalogItem.name, excluding: catalogItem.id);

  List<CatalogItem> get archivedCatalogItems =>
      catalogItems.where((item) => item.isArchived).toList();

  int get archivedCount => archivedCatalogItems.length;

  @override
  CatalogState copyWith({
    List<CatalogItem>? catalogItems,
    CatalogItem? catalogItem,
    CatalogItem? archivedCollision,
    CatalogFilter? filter,
    String? query,
    bool? isSearching,
    BaseStateStatus? status,
    String? callbackMessage,
  }) {
    return CatalogState(
      status: status ?? this.status,
      catalogItem: catalogItem ?? this.catalogItem,
      catalogItemList: catalogItems ?? this.catalogItems,
      archivedCollision: archivedCollision ?? this.archivedCollision,
      filter: filter ?? this.filter,
      query: query ?? this.query,
      isSearching: isSearching ?? this.isSearching,
      callbackMessage: callbackMessage ?? this.callbackMessage,
      userId: userId,
    );
  }

  /// Drops a pending [archivedCollision]. A separate method because [copyWith]
  /// reads null as "keep what you have".
  CatalogState withoutArchivedCollision() => CatalogState(
    status: status,
    catalogItem: catalogItem,
    catalogItemList: catalogItems,
    filter: filter,
    query: query,
    isSearching: isSearching,
    callbackMessage: callbackMessage,
    userId: userId,
  );

  @override
  List<Object?> get props => [
    catalogItems,
    catalogItem,
    archivedCollision,
    filter,
    query,
    isSearching,
    userId,
    status,
    callbackMessage,
  ];
}
