import 'package:equatable/equatable.dart';
import 'package:kazi/app/models/service.dart';

class ServicesGroupByDate extends Equatable {
  final DateTime date;
  final List<Service> services;
  final bool isExpanded;

  const ServicesGroupByDate({
    required this.date,
    required this.services,
    this.isExpanded = false,
  });

  ServicesGroupByDate copyWith({
    DateTime? date,
    List<Service>? services,
    bool? isExpaded,
  }) {
    return ServicesGroupByDate(
      date: date ?? this.date,
      services: services ?? this.services,
      isExpanded: isExpaded ?? isExpanded,
    );
  }

  @override
  List<Object?> get props => [date, services, isExpanded];
}
