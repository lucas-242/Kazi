class DropdownItem {
  /// Label Text
  late String text;
  // Value of item
  late String value;

  /// Auxilar value
  late String? auxValue;

  DropdownItem({String? text, this.auxValue, required this.value})
      : text = text ?? value;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DropdownItem &&
        other.text == text &&
        other.value == value &&
        other.auxValue == auxValue;
  }

  @override
  int get hashCode => text.hashCode ^ value.hashCode ^ auxValue.hashCode;
}
