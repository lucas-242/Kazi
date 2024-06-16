import 'package:kazi/core/l10n/generated/l10n.dart';
import 'package:kazi_design_system/components/form/dropdown_item.dart';

abstract class FormValidator {
  static String? validateTextField(String? fieldValue, String fieldName) {
    return _validateIsNullOrEmpty(
      fieldValue: fieldValue,
      fieldName: fieldName,
    );
  }

  static String? validateNumberField(String? fieldValue, String fieldName) {
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

  static String? validateDropdownField(
      DropdownItem? fieldValue, String fieldName) {
    return _validateIsNullOrEmpty(
      fieldValue: fieldValue?.label,
      fieldName: fieldName,
    );
  }

  static String? _validateIsNullOrEmpty(
          {String? fieldValue, String? fieldName}) =>
      fieldValue == null || fieldValue.isEmpty
          ? AppLocalizations.current
              .isEmpty(fieldName ?? AppLocalizations.current.field)
          : null;

  static String? validateEmailField(String? fieldValue) => fieldValue == null ||
          !RegExp(
            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
          ).hasMatch(fieldValue)
      ? AppLocalizations.current.validatorEmail
      : null;

  static String? validatePasswordField(String? fieldValue) =>
      fieldValue == null || fieldValue.length < 8 || fieldValue.length > 16
          ? AppLocalizations.current.validatorPassword
          : null;

  static String? validateConfirmPasswordField(
    String? fieldValue,
    String password,
  ) =>
      fieldValue != password
          ? AppLocalizations.current.validatorConfirmPassword
          : null;

  static String? validatePercentField(String? fieldValue, String fieldName) {
    String? error = validateNumberField(fieldValue, fieldName);

    if (error != null) {
      return error;
    }

    final convertedValue = double.tryParse(fieldValue!);

    if (convertedValue == null || convertedValue > 100) {
      error = AppLocalizations.current.numberBiggerThan100;
    }

    return error;
  }

  static String? validateQuantityField(String? fieldValue, String fieldName) {
    String? error;

    if (fieldValue == null || fieldValue.isEmpty) {
      return error;
    }

    final convertedValue = int.tryParse(fieldValue);

    if (convertedValue == null) {
      error = AppLocalizations.current.invalidIntNumber;
    } else if (convertedValue < 0) {
      error = AppLocalizations.current.numberLesserThanZero;
    }

    return error;
  }
}
