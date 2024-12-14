import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:kazi/app/models/dropdown_item.dart';
import 'package:kazi/app/shared/l10n/generated/l10n.dart';
import 'package:kazi/app/shared/themes/themes.dart';

class CustomDropdown extends StatefulWidget {
  final String label;
  final String hint;
  final DropdownItem? selectedItem;
  final List<DropdownItem> items;
  final String? Function(DropdownItem?)? validator;
  final Function(DropdownItem?)? onChanged;
  final bool showSeach;
  final String? searchHint;
  const CustomDropdown({
    super.key,
    required this.label,
    required this.hint,
    this.selectedItem,
    required this.items,
    this.validator,
    this.onChanged,
    this.showSeach = false,
    this.searchHint,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownSearch<DropdownItem>(
      selectedItem: widget.selectedItem,
      items: (filter, infiniteScrollProps) => widget.items,
      compareFn: (item1, item2) => item1.value == item2.value,
      itemAsString: (DropdownItem? u) => u!.label,
      onChanged: widget.onChanged,
      validator: widget.validator,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      popupProps: PopupProps.menu(
        showSearchBox: widget.showSeach,
        fit: FlexFit.loose,
        constraints: const BoxConstraints.tightFor(),
        emptyBuilder: (context, searchEntry) => const DropdownEmpty(),
        itemBuilder: (context, item, _, __) => PopupItem(
          item: item,
          isSelected: widget.selectedItem == item,
        ),
        searchFieldProps: SearchFieldProps(widget.searchHint).build(context),
      ),
      dropdownBuilder: (_, item) =>
          DropdownInput(item: item, hint: widget.hint),
      decoratorProps:
          DropdownInputDecorator(labelText: widget.label).build(context),
      suffixProps: DropdownSuffixProps(
        dropdownButtonProps: DropdownButtonProps(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizeConstants.mediumSpace,
          ),
          color: context.colorsScheme.onSurface,
          iconOpened: const Icon(Icons.keyboard_arrow_down_outlined),
        ),
      ),
    );
  }
}

class DropdownInput extends StatelessWidget {
  final DropdownItem? item;
  final String hint;
  const DropdownInput({super.key, this.item, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Text(
      item == null || item!.label == '' ? hint : item!.label,
      style: context.bodyMedium,
    );
  }
}

class DropdownInputDecorator extends DropDownDecoratorProps {
  final String labelText;
  const DropdownInputDecorator({required this.labelText});

  DropDownDecoratorProps build(BuildContext context) {
    return DropDownDecoratorProps(
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: labelText,
        hintStyle: context.bodyMedium,
        labelStyle: context.bodyMedium,
        contentPadding:
            const EdgeInsets.only(left: AppSizeConstants.mediumSpace),
        border: const OutlineInputBorder(),
      ),
    );
  }
}

class PopupItem extends StatelessWidget {
  final DropdownItem item;
  final bool isSelected;
  const PopupItem({
    super.key,
    required this.item,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: isSelected ? AppColors.lightYellow : AppColors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.only(
          left: AppSizeConstants.mediumSpace,
          right: AppSizeConstants.largeSpace,
        ),
        title: Text(item.label, style: context.bodyMedium),
      ),
    );
  }
}

class DropdownEmpty extends StatelessWidget {
  const DropdownEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSizeConstants.mediumSpace,
        horizontal: AppSizeConstants.mediumSpace,
      ),
      child: Text(
        AppLocalizations.current.noResults,
        style: context.titleSmall,
      ),
    );
  }
}

class SearchFieldProps extends TextFieldProps {
  final String? searchHint;

  const SearchFieldProps(this.searchHint);

  TextFieldProps build(BuildContext context) {
    return TextFieldProps(
      style: context.bodyMedium,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: AppLocalizations.current.search,
        hintText: searchHint,
        hintStyle: context.bodyMedium,
        contentPadding: EdgeInsets.zero,
        border: const OutlineInputBorder(),
        prefixIcon: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Icon(Icons.search),
        ),
      ),
    );
  }
}
