import 'package:flutter/material.dart';
import 'package:my_services/app/shared/constants/app_keys.dart';
import 'package:my_services/app/shared/extensions/extensions.dart';

import '../custom_text_form_field/custom_text_form_field.dart';

class CustomDateRangePicker extends StatelessWidget {
  final GlobalKey<FormFieldState> fieldKey;
  final TextEditingController controller;
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
      labelText: context.appLocalizations.period,
      keyboardType: TextInputType.datetime,
      iconRight: Icons.calendar_today,
      controller: controller,
      readOnly: true,
      onTap: () {
        showDateRangePicker(
          context: context,
          initialDateRange: DateTimeRange(
            start: startDate,
            end: endDate,
          ),
          firstDate: AppKeys.formStartDate,
          lastDate: AppKeys.formEndDate,
        ).then((value) => onChangeDatePicker(value));
      },
    );
  }
}
