import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kazi/app/core/themes/themes.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.sentences,
    required this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText = '',
    this.initialValue,
    this.validator,
    this.controller,
    this.onChanged,
    this.inputFormatters,
    this.onTap,
    this.onEditingComplete,
    this.readOnly = false,
    this.textFormKey,
    this.maxLines = 1,
    this.maxLength,
    this.obscureText = false,
    this.focusNode,
    this.onFieldSubmitted,
  }) : super(key: key);

  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String labelText;
  final String hintText;
  final int maxLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? initialValue;
  final bool readOnly;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextCapitalization textCapitalization;
  final Key? textFormKey;
  final FocusNode? focusNode;
  final void Function(String value)? onChanged;
  final void Function()? onTap;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: textFormKey,
      focusNode: focusNode,
      controller: controller,
      initialValue: initialValue,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textCapitalization: textCapitalization,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      readOnly: readOnly,
      onChanged: onChanged,
      onTap: onTap,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      maxLength: maxLength,
      maxLines: maxLines,
      style: context.bodyMedium,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        counterText: '',
        labelText: labelText,
        labelStyle: context.labelLarge!.copyWith(
          color: context.colorsScheme.onSurface,
        ),
        errorMaxLines: 3,
        hintText: hintText.isEmpty ? labelText : null,
        hintStyle: context.bodyMedium,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
