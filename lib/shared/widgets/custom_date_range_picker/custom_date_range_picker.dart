import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

import '../custom_text_form_field/custom_text_form_field.dart';

class CustomDateRangePicker extends StatelessWidget {
  final GlobalKey<FormFieldState> fieldKey;
  final MaskedTextController controller;
  final DateTime startDate;
  final DateTime endDate;
  final void Function(DateTimeRange) onChange;

  const CustomDateRangePicker({
    super.key,
    required this.fieldKey,
    required this.controller,
    required this.onChange,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    void onChangeDatePicker(DateTimeRange? date) {
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
        showDateRangePicker(
          context: context,
          initialDateRange: DateTimeRange(
            start: startDate,
            end: endDate,
          ),
          firstDate: DateTime(2022),
          lastDate: DateTime.now(),
        ).then((value) => onChangeDatePicker(value));
      },
    );
  }
}
