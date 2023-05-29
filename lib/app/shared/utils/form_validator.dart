import 'package:kazi/app/models/dropdown_item.dart';
import 'package:kazi/app/shared/l10n/generated/l10n.dart';

mixin FormValidator {
  String? validateTextField(String? fieldValue, String fieldName) {
    return _validateIsNullOrEmpty(
      fieldValue: fieldValue,
      fieldName: fieldName,
    );
  }

  String? validateNumberField(String? fieldValue, String fieldName) {
    String? error = _validateIsNullOrEmpty(
      fieldValue: fieldValue,
      fieldName: fieldName,
    );

    if (error != null) {
      return error;
    }

    final convertedValue = double.tryParse(fieldValue!);

    if (convertedValue == null) {
      error = AppLocalizations.current.invalidNumber;
    } else if (convertedValue < 0) {
      error = AppLocalizations.current.numberLesserThanZero;
    }

    return error;
  }

  String? validateDropdownField(DropdownItem? fieldValue, String fieldName) {
    return _validateIsNullOrEmpty(
      fieldValue: fieldValue?.label,
      fieldName: fieldName,
    );
  }

  String? _validateIsNullOrEmpty({String? fieldValue, String? fieldName}) =>
      fieldValue == null || fieldValue.isEmpty
          ? AppLocalizations.current
              .isEmpty(fieldName ?? AppLocalizations.current.field)
          : null;
}
