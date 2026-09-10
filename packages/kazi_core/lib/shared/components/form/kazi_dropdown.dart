import 'package:flutter/material.dart';
import 'package:kazi_core/kazi_core.dart';

/// A dropdown-style selector built on top of [KaziTextFormField] and a modal
/// bottom sheet, following the app's visual patterns (no third-party lib).
///
/// The field is read-only and opens a bottom sheet with the available [items]
/// (optionally searchable via [showSeach]). When [validator] is `null` the
/// selection is optional and a clear button is shown once something is picked,
/// letting the user deselect (emits `onChanged(null)`).
class KaziDropdown extends StatefulWidget {
  const KaziDropdown({
    super.key,
    required this.label,
    required this.hint,
    this.selectedItem,
    required this.items,
    this.validator,
    this.onChanged,
    this.showSeach = false,
    this.searchHint,
    required this.searchLabel,
    required this.noResultsLabel,
    this.secondarySectionLabel,
  });
  final String label;
  final String hint;
  final DropdownItem? selectedItem;
  final List<DropdownItem> items;
  final String? Function(DropdownItem?)? validator;
  final Function(DropdownItem?)? onChanged;
  final bool showSeach;
  final String? searchHint;
  final String searchLabel;
  final String noResultsLabel;

  /// Heading for the trailing section holding the `isSecondary` items. Required
  /// for that section to render at all — without it every item is listed
  /// together, as before.
  final String? secondarySectionLabel;

  @override
  State<KaziDropdown> createState() => _KaziDropdownState();
}

class _KaziDropdownState extends State<KaziDropdown> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.selectedItem?.label ?? '');
  }

  @override
  void didUpdateWidget(covariant KaziDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedItem != widget.selectedItem) {
      final label = widget.selectedItem?.label ?? '';
      // Setting controller.text here directly would notify the underlying
      // TextFormField synchronously, triggering setState while this
      // widget's own ancestor is still mid-build. Defer to after the frame.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _controller.text = label;
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _isOptional => widget.validator == null;

  bool get _hasSelection {
    final item = widget.selectedItem;
    return item != null && item.label.isNotEmpty;
  }

  Future<void> _openPicker() async {
    final selected = await showKaziDropdownPicker(
      context: context,
      title: widget.label,
      items: widget.items,
      selectedItem: widget.selectedItem,
      showSearch: widget.showSeach,
      searchHint: widget.searchHint,
      searchLabel: widget.searchLabel,
      noResultsLabel: widget.noResultsLabel,
      secondarySectionLabel: widget.secondarySectionLabel,
    );
    if (selected != null) {
      widget.onChanged?.call(selected);
    }
  }

  void _clear() {
    _controller.clear();
    widget.onChanged?.call(null);
  }

  @override
  Widget build(BuildContext context) {
    final showClear = _isOptional && _hasSelection;
    final selectedColor = widget.selectedItem?.color;
    return KaziTextFormField(
      labelText: widget.hint,
      controller: _controller,
      readOnly: true,
      onTap: _openPicker,
      prefixIcon: selectedColor == null
          ? null
          : Center(
              widthFactor: 1,
              heightFactor: 1,
              child: KaziColorDot(color: selectedColor),
            ),
      validator: widget.validator == null
          ? null
          : (_) => widget.validator!(widget.selectedItem),
      suffixIcon: showClear
          ? IconButton(
              icon: const Icon(Icons.close),
              onPressed: _clear,
            )
          : const Icon(Icons.keyboard_arrow_down_outlined),
    );
  }
}

/// Opens the shared selection sheet and resolves to the chosen item, or null
/// when it is dismissed.
///
/// Exposed because the sheet is the app's one way of picking from a list: the
/// boxed [KaziFieldPicker] and the older [KaziDropdown] draw different fields
/// but must never offer two different pickers.
Future<DropdownItem?> showKaziDropdownPicker({
  required BuildContext context,
  required String title,
  required List<DropdownItem> items,
  required String searchLabel,
  required String noResultsLabel,
  DropdownItem? selectedItem,
  bool showSearch = false,
  String? searchHint,
  String? secondarySectionLabel,
}) {
  return KaziNavigator.showBottomSheet<DropdownItem>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (_) => Material(
      type: MaterialType.transparency,
      child: _KaziDropdownPicker(
        title: title,
        items: items,
        selectedItem: selectedItem,
        showSearch: showSearch,
        searchHint: searchHint,
        searchLabel: searchLabel,
        noResultsLabel: noResultsLabel,
        secondarySectionLabel: secondarySectionLabel,
      ),
    ),
  );
}

/// Bottom-sheet content that lists the [items], optionally with a search box,
/// and pops the chosen [DropdownItem] back to [KaziDropdown].
class _KaziDropdownPicker extends StatefulWidget {
  const _KaziDropdownPicker({
    required this.title,
    required this.items,
    required this.selectedItem,
    required this.showSearch,
    required this.searchHint,
    required this.searchLabel,
    required this.noResultsLabel,
    required this.secondarySectionLabel,
  });
  final String title;
  final List<DropdownItem> items;
  final DropdownItem? selectedItem;
  final bool showSearch;
  final String? searchHint;
  final String searchLabel;
  final String noResultsLabel;
  final String? secondarySectionLabel;

  @override
  State<_KaziDropdownPicker> createState() => _KaziDropdownPickerState();
}

class _KaziDropdownPickerState extends State<_KaziDropdownPicker> {
  late List<DropdownItem> _filtered;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filtered = widget.items;
  }

  /// The secondary items are pulled out only when there is a heading to put
  /// above them; otherwise they stay in the main list, as they always did.
  bool get _isSectioned => widget.secondarySectionLabel != null;

  List<DropdownItem> get _primary => _isSectioned
      ? _filtered.where((item) => !item.isSecondary).toList()
      : _filtered;

  List<DropdownItem> get _secondary => _isSectioned
      ? _filtered.where((item) => item.isSecondary).toList()
      : const [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String value) {
    final query = value.trim().toLowerCase();
    setState(() {
      _filtered = query.isEmpty
          ? widget.items
          : widget.items.where((item) {
              final haystack =
                  '${item.label} ${item.searchTerms ?? ''}'.toLowerCase();
              return haystack.contains(query);
            }).toList();
    });
  }

  List<Widget> _tilesFor(List<DropdownItem> items) {
    final tiles = <Widget>[];

    for (final item in items) {
      if (tiles.isNotEmpty) {
        tiles.add(
          Divider(height: 1, thickness: 1, color: context.colors.border),
        );
      }

      final isSelected = item == widget.selectedItem;
      tiles.add(
        ListTile(
          leading: item.color == null ? null : KaziColorDot(color: item.color),
          minLeadingWidth: 0,
          title: Text(
            item.label,
            style: isSelected
                ? KaziTextStyles.titleSmall
                : KaziTextStyles.bodyMedium,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: KaziInsets.xLg,
          ),
          trailing: isSelected
              ? Icon(Icons.check, color: context.colors.brand.text)
              : null,
          onTap: () => Navigator.of(context).pop(item),
        ),
      );
    }

    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: context.height * 0.7),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: KaziInsets.xLg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title, style: KaziTextStyles.titleMedium),
            KaziSpacings.verticalLg,
            if (widget.showSearch) ...[
              KaziTextFormField(
                labelText: widget.searchLabel,
                hintText: widget.searchHint ?? widget.searchLabel,
                onChanged: _onSearch,
                prefixIcon: const Icon(Icons.search),
              ),
              KaziSpacings.verticalMd,
            ],
            if (_filtered.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: KaziInsets.md),
                child: Text(
                  widget.noResultsLabel,
                  style: KaziTextStyles.titleSmall,
                ),
              )
            else
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                    // The keyboard, while up, covers the last rows.
                    bottom:
                        KaziInsets.lg + MediaQuery.viewInsetsOf(context).bottom,
                  ),
                  children: [
                    ..._tilesFor(_primary),
                    if (_secondary.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.only(
                          left: KaziInsets.xLg,
                          top: KaziInsets.lg,
                          bottom: KaziInsets.xs,
                        ),
                        child: Text(
                          widget.secondarySectionLabel!,
                          style: KaziTextStyles.labelSmall.copyWith(
                            color: context.colors.textMuted,
                          ),
                        ),
                      ),
                      ..._tilesFor(_secondary),
                    ],
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
