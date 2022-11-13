import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../themes/themes.dart';

class CustomTextFormField extends StatelessWidget {
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String labelText;
  final String hintText;
  final IconData icon;
  final String? initialValue;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String value)? onChanged;
  final void Function()? onTap;

  const CustomTextFormField({
    Key? key,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    required this.labelText,
    required this.icon,
    this.hintText = '',
    this.initialValue,
    this.validator,
    this.controller,
    this.onChanged,
    this.inputFormatters,
    this.onTap,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          TextFormField(
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
              contentPadding: EdgeInsets.zero,
              border: const OutlineInputBorder(),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Icon(icon),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
