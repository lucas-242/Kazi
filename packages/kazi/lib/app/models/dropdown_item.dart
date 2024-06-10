import 'package:equatable/equatable.dart';

class DropdownItem extends Equatable {
  DropdownItem({String? label, this.auxValue, required this.value})
      : label = label ?? value.toString();
  final String label;
  final int value;

  final String? auxValue;

  @override
  List<Object?> get props => [label, value, auxValue];
}
