import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:my_services/app/models/dropdown_item.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/themes/themes.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final String hint;
  final DropdownItem? selectedItem;
  final List<DropdownItem> items;
  final String? Function(DropdownItem?)? validator;
  final Function(DropdownItem?)? onChanged;
  final bool showSeach;
  final String? searchHint;
  const CustomDropdown({
    Key? key,
    required this.label,
    required this.hint,
    this.selectedItem,
    required this.items,
    this.validator,
    this.onChanged,
    this.showSeach = false,
    this.searchHint,
  }) : super(key: key);

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
