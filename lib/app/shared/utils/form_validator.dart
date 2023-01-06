import '../../models/dropdown_item.dart';

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
      error = 'Please, inform a valid number';
    } else if (convertedValue < 0) {
      error = 'Please, inform a number equal or greater than 0';
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
          ? '${fieldName ?? "Field"} is Empty'
          : null;
}
