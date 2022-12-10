class DropdownItem {
  late String label;
  late String value;

  late String? auxValue;

  DropdownItem({String? text, this.auxValue, required this.value})
      : label = text ?? value;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DropdownItem &&
        other.label == label &&
        other.value == value &&
        other.auxValue == auxValue;
  }

  @override
  int get hashCode => label.hashCode ^ value.hashCode ^ auxValue.hashCode;
}
