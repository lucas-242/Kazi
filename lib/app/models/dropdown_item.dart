import 'package:equatable/equatable.dart';

class DropdownItem extends Equatable {

  const DropdownItem({String? label, this.auxValue, required this.value})
      : label = label ?? value;
  final String label;
  final String value;

  final String? auxValue;

  @override
  List<Object?> get props => [label, value, auxValue];
}
