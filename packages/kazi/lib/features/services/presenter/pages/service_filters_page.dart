import 'package:flutter/material.dart';
import 'package:kazi/core/constants/form_keys.dart';
import 'package:kazi/core/widgets/option_tile.dart';
import 'package:kazi/features/services/domain/models/receipt_filter.dart';
import 'package:kazi/features/services/presenter/controllers/service_filters_controller.dart';
import 'package:kazi/features/services/presenter/controllers/service_filters_state.dart';
import 'package:kazi/features/services/presenter/controllers/service_landing_controller.dart';
import 'package:kazi/features/services/presenter/controllers/service_landing_state.dart';
import 'package:kazi/features/services/presenter/widgets/service_period_l10n.dart';
import 'package:kazi/injector.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;
import 'package:kazi_core/kazi_core.dart';

/// Everything that does not fit in a chip: the full period picker, status, the
/// service types and the client.
///
/// Its draft is applied on the way out, not as it is edited — which is what
/// lets the button count the result before anyone applies it blind. The count
/// is only shown when it can be trusted. See README.md.
class FiltersBottomSheet extends ConsumerStatefulWidget {
  const FiltersBottomSheet({super.key});

  @override
  ConsumerState<FiltersBottomSheet> createState() => _FiltersBottomSheetState();
}

class _FiltersBottomSheetState extends ConsumerState<FiltersBottomSheet> {
  late DateTime initialStartDate;
  late DateTime initialEndDate;
  late FastSearch initialFastSearch;
  late ServiceFiltersControllerProvider _filtersProvider;

  late ReceiptFilter _receiptFilter;
  late Set<String> _catalogItemIds;
  late String? _clientId;

  @override
  void initState() {
    super.initState();
    final landingState = ref.read(serviceLandingControllerProvider);
    initialStartDate = landingState.startDate;
    initialEndDate = landingState.endDate;
    initialFastSearch = landingState.fastSearch;
    _receiptFilter = landingState.receiptFilter;
    _catalogItemIds = {...landingState.catalogItemIds};
    _clientId = landingState.clientId;
    _filtersProvider = serviceFiltersControllerProvider(
      startDate: initialStartDate,
      endDate: initialEndDate,
      fastSearch: initialFastSearch,
    );
  }

  void _onChangeFastSearch(FastSearch selectedFastSearch) => ref
      .read(_filtersProvider.notifier)
      .onChangeFastSearch(selectedFastSearch);

  void _onSelectCurrentCycle() =>
      ref.read(_filtersProvider.notifier).onSelectCurrentCycle();

  Future<void> _onPickDates() async {
    final draft = ref.read(_filtersProvider);
    final range = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(
        start: draft.startDate,
        end: draft.endDate,
      ),
      firstDate: FormKeys.formStartDate,
      lastDate: FormKeys.formEndDate,
    );

    if (range == null) return;
    ref.read(_filtersProvider.notifier).onChangeDate(range.start, range.end);
  }

  /// The window each preset resolves to, so the month chips can name their
  /// month rather than saying "this one".
  String _fastSearchLabel(FastSearch search) {
    final range = ref
        .read(serviceOrganizerProvider)
        .getRangeDateByFastSearch(search);

    return fastSearchLabel(search, range['startDate']!);
  }

  /// Whether the draft still describes the period already in memory. When it
  /// does not, the result cannot be counted without a query — which is exactly
  /// what applying is for.
  bool get _periodIsLoaded {
    final draft = ref.read(_filtersProvider);
    final landing = ref.read(serviceLandingControllerProvider);
    return draft.startDate == landing.startDate &&
        draft.endDate == landing.endDate;
  }

  /// How many rows the draft would leave standing, over the services already
  /// fetched. Null when the period moved and the answer is not in memory.
  int? get _resultCount {
    if (!_periodIsLoaded) return null;

    return ref
        .read(serviceLandingControllerProvider)
        .services
        .where(
          (service) =>
              _receiptFilter.allows(service) &&
              (_clientId == null || service.clientId == _clientId) &&
              (_catalogItemIds.isEmpty ||
                  _catalogItemIds.contains(service.catalogItemId)),
        )
        .length;
  }

  Future<void> _onApply() async {
    final draft = ref.read(_filtersProvider);
    final controller = ref.read(serviceLandingControllerProvider.notifier);

    KaziNavigator.pop();
    controller.applySecondaryFilters(
      receiptFilter: _receiptFilter,
      catalogItemIds: _catalogItemIds,
      clientId: _clientId,
    );
    await controller.onApplyFilters(
      draft.fastSearch,
      draft.startDate,
      draft.endDate,
    );
  }

  Future<void> _onClearAll() async {
    KaziNavigator.pop();
    await ref.read(serviceLandingControllerProvider.notifier).onCleanFilters();
  }

  @override
  Widget build(BuildContext context) {
    final draft = ref.watch(_filtersProvider);
    final landing = ref.watch(serviceLandingControllerProvider);
    final l10n = KaziLocalizations.current;
    final count = _resultCount;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        KaziInsets.xLg,
        KaziInsets.zero,
        KaziInsets.xLg,
        KaziInsets.xLg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l10n.filters.capitalize(), style: KaziTextStyles.titleLarge),
              KaziTextButton(onTap: _onClearAll, child: Text(l10n.clearAll)),
            ],
          ),
          KaziSpacings.verticalSm,
          _Section(
            title: l10n.period,
            child: Wrap(
              spacing: KaziInsets.xs,
              runSpacing: KaziInsets.xs,
              children: [
                for (final search in FastSearch.values)
                  if (search != FastSearch.custom)
                    KaziChip(
                      onTap: () => _onChangeFastSearch(search),
                      label: _fastSearchLabel(search),
                      isSelected:
                          !draft.isCurrentCycle && draft.fastSearch == search,
                    ),
                // After the calendar presets: it is the window the home
                // reports on, and the one the bulk "mark as received" action
                // is meant to operate on.
                KaziChip(
                  onTap: _onSelectCurrentCycle,
                  label: l10n.currentCycle,
                  isSelected: draft.isCurrentCycle,
                ),
                // Says its dates once a range is picked: a chip reading
                // "Escolher datas" while a hand-picked window is applied
                // would be the only control on screen not showing its value.
                KaziChip(
                  onTap: _onPickDates,
                  label: _isCustomRange(draft)
                      ? fastSearchLabel(
                          FastSearch.custom,
                          draft.startDate,
                          draft.endDate,
                        )
                      : l10n.pickDates,
                  isSelected: _isCustomRange(draft),
                ),
              ],
            ),
          ),
          KaziSpacings.verticalLg,
          _Section(
            title: l10n.situation,
            child: Wrap(
              spacing: KaziInsets.xs,
              runSpacing: KaziInsets.xs,
              children: [
                for (final filter in ReceiptFilter.values)
                  KaziChip(
                    onTap: () => setState(() => _receiptFilter = filter),
                    label: _receiptLabel(filter),
                    isSelected: _receiptFilter == filter,
                  ),
              ],
            ),
          ),
          if (landing.filterableCatalogItems.isNotEmpty) ...[
            KaziSpacings.verticalLg,
            _Section(
              title: l10n.serviceType,
              child: _CatalogItemFilter(
                items: landing.filterableCatalogItems,
                selectedIds: _catalogItemIds,
                onToggle: (id) => setState(() {
                  if (!_catalogItemIds.remove(id)) _catalogItemIds.add(id);
                }),
              ),
            ),
          ],
          if (landing.filterableClients.isNotEmpty) ...[
            KaziSpacings.verticalLg,
            // A field rather than a row of chips: a busy month has as many
            // clients as it has services, and the picker searches them over
            // the services already fetched. It carries its own caption, so
            // it needs no _Section around it.
            KaziFieldPicker(
              label: l10n.client,
              placeholder: l10n.allClients,
              searchLabel: l10n.search,
              noResultsLabel: l10n.noResults,
              showSearch: true,
              items: [
                for (final client in landing.filterableClients)
                  DropdownItem(value: client.id, label: client.name),
              ],
              selectedItem: _selectedClientItem(landing),
              onChanged: (item) => setState(() => _clientId = item?.value),
              onClear: () => setState(() => _clientId = null),
            ),
          ],
          KaziSpacings.verticalXLg,
          KaziElevatedButton.label(
            onTap: _onApply,
            width: double.infinity,
            label: count == null ? l10n.applyFilters : l10n.seeNServices(count),
          ),
        ],
      ),
    );
  }

  bool _isCustomRange(ServiceFiltersState draft) =>
      !draft.isCurrentCycle && draft.fastSearch == FastSearch.custom;

  DropdownItem? _selectedClientItem(ServiceLandingState landing) {
    final selected = landing.filterableClients
        .where((client) => client.id == _clientId)
        .firstOrNull;

    return selected == null
        ? null
        : DropdownItem(value: selected.id, label: selected.name);
  }

  String _receiptLabel(ReceiptFilter filter) => switch (filter) {
    ReceiptFilter.all => KaziLocalizations.current.allReceipts,
    ReceiptFilter.pending => KaziLocalizations.current.pendingReceipt,
    ReceiptFilter.received => KaziLocalizations.current.receivedPlural,
  };
}

/// The service types with something in the period, as rows: the tick, the
/// colour that identifies the type in the list, and how many services carry it.
///
/// Only a handful are shown at once. A catalog can hold hundreds of types, and
/// a sheet that lists every one of them buries the client field and the button
/// under a wall of rows — so what is selected comes first, a search narrows the
/// rest, and the full list is one tap away. Everything here reads the services
/// already fetched; none of it costs a query.
class _CatalogItemFilter extends StatefulWidget {
  const _CatalogItemFilter({
    required this.items,
    required this.selectedIds,
    required this.onToggle,
  });

  final List<({String id, String name, int count, Color? color})> items;
  final Set<String> selectedIds;
  final void Function(String id) onToggle;

  @override
  State<_CatalogItemFilter> createState() => _CatalogItemFilterState();
}

class _CatalogItemFilterState extends State<_CatalogItemFilter> {
  /// Above this many types the list gets a search field, and below it the
  /// field would only be one more thing to skip past.
  static const _searchThreshold = 8;

  /// How many rows are shown before "show all". Enough to recognize the list
  /// as a list, short enough to leave the button on screen.
  static const _collapsedLimit = 5;

  final _searchController = TextEditingController();
  String _query = '';
  bool _showAll = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Selected first, so the cap can never hide a filter the user applied.
  List<({String id, String name, int count, Color? color})> get _ordered {
    final query = _query.trim().toLowerCase();
    final matches = query.isEmpty
        ? widget.items
        : widget.items
              .where((item) => item.name.toLowerCase().contains(query))
              .toList();

    final selected = matches.where(
      (item) => widget.selectedIds.contains(item.id),
    );
    final rest = matches.where((item) => !widget.selectedIds.contains(item.id));

    return [...selected, ...rest];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = KaziLocalizations.current;
    final ordered = _ordered;
    final isCapped = !_showAll && ordered.length > _collapsedLimit;
    final visible = isCapped ? ordered.take(_collapsedLimit).toList() : ordered;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.items.length > _searchThreshold) ...[
          KaziTextFormField(
            labelText: l10n.searchServiceTypeHint,
            controller: _searchController,
            textCapitalization: TextCapitalization.none,
            prefixIcon: const Icon(Icons.search, size: KaziSizings.iconMd),
            onChanged: (value) => setState(() => _query = value),
          ),
          KaziSpacings.verticalXs,
        ],
        for (final item in visible)
          OptionTile(
            label: item.name,
            selected: widget.selectedIds.contains(item.id),
            leading: KaziColorDot(color: item.color),
            detail: item.count.toString(),
            onTap: () => widget.onToggle(item.id),
          ),
        if (ordered.isEmpty)
          Text(
            l10n.noResults,
            style: KaziTextStyles.bodySmall.copyWith(
              color: context.colors.textMuted,
            ),
          ),
        if (isCapped)
          KaziTextButton(
            onTap: () => setState(() => _showAll = true),
            child: Text(l10n.showAllTypes(ordered.length)),
          ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KaziFieldCaption(title),
        KaziSpacings.verticalSm,
        child,
      ],
    );
  }
}
