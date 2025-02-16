import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kazi/app/shared/themes/themes.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.sentences,
    required this.labelText,
    this.iconLeft,
    this.iconRight,
    this.hintText = '',
    this.initialValue,
    this.validator,
    this.controller,
    this.onChanged,
    this.inputFormatters,
    this.onTap,
    this.readOnly = false,
    this.textFormKey,
    this.maxLines,
  });

  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String labelText;
  final String hintText;
  final int? maxLines;
  final IconData? iconLeft;
  final IconData? iconRight;
  final String? initialValue;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextCapitalization textCapitalization;
  final Key? textFormKey;
  final void Function(String value)? onChanged;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: textFormKey,
      controller: controller,
      initialValue: initialValue,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textCapitalization: textCapitalization,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      readOnly: readOnly,
      onChanged: onChanged,
      onTap: onTap,
      maxLines: maxLines,
      style: context.bodyMedium,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: context.labelLarge!.copyWith(
          color: context.colorsScheme.onSurface,
          backgroundColor: context.colorsScheme.surface,
          //TODO: CustomPaint here to create a rounded border background
        ),
        hintText: hintText,
        hintStyle: context.bodyMedium,
        prefixIcon: iconLeft != null
            ? Icon(
                iconLeft,
                color: context.colorsScheme.onSurface,
              )
            : null,
        suffixIcon: iconRight != null
            ? Icon(
                iconRight,
                color: context.colorsScheme.onSurface,
              )
            : null,
      ),
    );
  }
}
