import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../themes/themes.dart';

class CustomTextFormField extends StatelessWidget {
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String labelText;
  final String hintText;
  final IconData? icon;
  final String? initialValue;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Key? textFormKey;
  final void Function(String value)? onChanged;
  final void Function()? onTap;

  const CustomTextFormField({
    Key? key,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    required this.labelText,
    this.icon,
    this.hintText = '',
    this.initialValue,
    this.validator,
    this.controller,
    this.onChanged,
    this.inputFormatters,
    this.onTap,
    this.readOnly = false,
    this.textFormKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: textFormKey,
      controller: controller,
      initialValue: initialValue,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      readOnly: readOnly,
      onChanged: onChanged,
      onTap: onTap,
      style: context.bodyMedium,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: labelText,
        hintText: hintText,
        hintStyle: context.bodyMedium,
        contentPadding:
            icon == null ? const EdgeInsets.only(left: 15) : EdgeInsets.zero,
        border: const OutlineInputBorder(),
        prefixIcon: icon != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Icon(icon),
              )
            : null,
      ),
    );
  }
}
