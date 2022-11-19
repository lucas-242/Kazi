import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

import '../custom_text_form_field/custom_text_form_field.dart';

class CustomDatePicker extends StatelessWidget {
  final GlobalKey<FormFieldState> fieldKey;
  final MaskedTextController controller;
  final void Function(DateTime) onChange;
  final DateTime initialDate;

  CustomDatePicker({
    Key? key,
    required this.fieldKey,
    required this.controller,
    required this.onChange,
    DateTime? initialDate,
  })  : initialDate = initialDate ?? DateTime.now(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    void onChangeDatePicker(DateTime? date) {
      if (date != null) {
        onChange(date);
      }
    }

    return CustomTextFormField(
        labelText: 'Data',
        keyboardType: TextInputType.datetime,
        controller: controller,
        readOnly: true,
        onTap: () {
          showDatePicker(
            context: context,
            initialDate:
                controller.text.isNotEmpty ? initialDate : DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now(),
          ).then((value) => onChangeDatePicker(value));
        });
  }
}
