import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:my_services/app/models/dropdown_item.dart';
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
      popupProps: PopupProps.bottomSheet(
        showSearchBox: showSeach,
        fit: FlexFit.loose,
        constraints: const BoxConstraints.tightFor(),
        emptyBuilder: (context, searchEntry) => const DropdownEmpty(),
        itemBuilder: (context, item, isSelected) => PopupItem(item: item),
        searchFieldProps: SearchFieldProps(searchHint).build(context),
      ),
      dropdownBuilder: (_, item) => DropdownInput(item: item, hint: hint),
      dropdownDecoratorProps:
          DropdownInputDecorator(labelText: label).build(context),
      dropdownButtonProps: const DropdownButtonProps(
        padding: EdgeInsets.symmetric(horizontal: 15),
        icon: Icon(Icons.arrow_drop_down, size: 24),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        item == null || item!.label == '' ? hint : item!.label,
        style: context.bodyMedium,
      ),
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
        contentPadding: const EdgeInsets.only(left: 15),
        border: const OutlineInputBorder(),
      ),
    );
  }
}

class PopupItem extends StatelessWidget {
  final DropdownItem item;
  const PopupItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.label, style: context.bodyMedium),
    );
  }
}

class DropdownEmpty extends StatelessWidget {
  const DropdownEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Text(
        'Sem resultados',
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
        labelText: 'Busca',
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
