import 'package:flutter/material.dart';
import 'package:kazi/app/shared/constants/app_keys.dart';
import 'package:kazi/app/shared/l10n/generated/l10n.dart';

import '../custom_text_form_field/custom_text_form_field.dart';

class CustomDateRangePicker extends StatelessWidget {

  const CustomDateRangePicker({
    super.key,
    required this.fieldKey,
    required this.controller,
    required this.onChange,
    required this.startDate,
    required this.endDate,
  });
  final GlobalKey<FormFieldState> fieldKey;
  final TextEditingController controller;
  final DateTime startDate;
  final DateTime endDate;
  final void Function(DateTimeRange) onChange;

  @override
  Widget build(BuildContext context) {
    void onChangeDatePicker(DateTimeRange? date) {
      if (date != null) {
        onChange(date);
      }
    }

    return CustomTextFormField(
      labelText: AppLocalizations.current.period,
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
