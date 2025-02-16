import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:kazi/app/shared/constants/app_keys.dart';
import 'package:kazi/app/shared/widgets/fields/fields.dart';

class CustomDatePicker extends StatelessWidget {

  CustomDatePicker({
    super.key,
    required this.fieldKey,
    required this.controller,
    required this.onChange,
    DateTime? initialDate,
    required this.label,
    this.validator,
  })  : initialDate = initialDate ?? DateTime.now();
  final GlobalKey<FormFieldState> fieldKey;
  final MaskedTextController controller;
  final void Function(DateTime) onChange;
  final String label;
  final String? Function(String?)? validator;
  final DateTime initialDate;

  @override
  Widget build(BuildContext context) {
    void onChangeDatePicker(DateTime? date) {
      if (date != null) {
        onChange(date);
      }
    }

    return CustomTextFormField(
      labelText: label,
      keyboardType: TextInputType.datetime,
      controller: controller,
      readOnly: true,
      onTap: () {
        showDatePicker(
          context: context,
          initialDate:
              controller.text.isNotEmpty ? initialDate : DateTime.now(),
          firstDate: AppKeys.formStartDate,
          lastDate: AppKeys.formEndDate,
        ).then((value) => onChangeDatePicker(value));
      },
      validator: validator,
    );
  }
}
