import 'package:equatable/equatable.dart';
import 'package:kazi/app/models/service.dart';

class ServicesGroupByDate extends Equatable {

  const ServicesGroupByDate({
    required this.date,
    required this.services,
    this.isExpanded = false,
  });
  final DateTime date;
  final List<Service> services;
  final bool isExpanded;

  ServicesGroupByDate copyWith({
    DateTime? date,
    List<Service>? services,
    bool? isExpanded,
  }) {
    return ServicesGroupByDate(
      date: date ?? this.date,
      services: services ?? this.services,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }

  @override
  List<Object?> get props => [date, services, isExpanded];
}
