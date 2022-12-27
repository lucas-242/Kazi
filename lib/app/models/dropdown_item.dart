import 'package:equatable/equatable.dart';

class DropdownItem extends Equatable {
  final String label;
  final String value;

  final String? auxValue;

  const DropdownItem({String? label, this.auxValue, required this.value})
      : label = label ?? value;

  @override
  List<Object?> get props => [label, value, auxValue];
}
