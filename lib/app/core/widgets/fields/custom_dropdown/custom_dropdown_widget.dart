import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/models/dropdown_item.dart';

class CustomDropdown extends StatelessWidget {
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
  final String label;
  final String hint;
  final DropdownItem? selectedItem;
  final List<DropdownItem> items;
  final String? Function(DropdownItem?)? validator;
  final Function(DropdownItem?)? onChanged;
  final bool showSeach;
  final String? searchHint;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<DropdownItem>(
      selectedItem: selectedItem,
      items: items,
      itemAsString: (DropdownItem? u) => u!.label,
      onChanged: onChanged,
      validator: validator,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      popupProps: PopupProps.menu(
        showSearchBox: showSeach,
        fit: FlexFit.loose,
        constraints: const BoxConstraints.tightFor(),
        emptyBuilder: (context, searchEntry) => const DropdownEmpty(),
        //! IsSelected is not working
        itemBuilder: (context, item, isSelected) => PopupItem(
          item: item,
          isSelected: isSelected,
        ),
        searchFieldProps: SearchFieldProps(searchHint).build(context),
      ),
      dropdownBuilder: (_, item) => DropdownInput(item: item, hint: hint),
      dropdownDecoratorProps:
          DropdownInputDecorator(labelText: label).build(context),
      dropdownButtonProps: DropdownButtonProps(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizeConstants.mediumSpace,
        ),
        color: context.colorsScheme.onBackground,
        icon: const Icon(Icons.keyboard_arrow_down_outlined),
      ),
    );
  }
}

class DropdownInput extends StatelessWidget {
  const DropdownInput({super.key, this.item, required this.hint});
  final DropdownItem? item;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Text(
      item == null || item!.label == '' ? hint : item!.label,
      style: context.bodyMedium,
    );
  }
}

class DropdownInputDecorator extends DropDownDecoratorProps {
  const DropdownInputDecorator({required this.labelText});
  final String labelText;

  DropDownDecoratorProps build(BuildContext context) {
    return DropDownDecoratorProps(
      dropdownSearchDecoration: InputDecoration(
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
  const PopupItem({
    super.key,
    required this.item,
    required this.isSelected,
  });
  final DropdownItem item;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: isSelected
          ? AppColors.lightYellow
          : context.colorsScheme.primary.withOpacity(0.08),
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
  const SearchFieldProps(this.searchHint);
  final String? searchHint;

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
