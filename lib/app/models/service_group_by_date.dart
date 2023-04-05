import 'package:my_services/app/models/service.dart';

class ServicesGroupByDate {
  final DateTime date;
  final List<Service> services;
  final bool isExpaded;

  ServicesGroupByDate({
    required this.date,
    required this.services,
    this.isExpaded = false,
  });

  ServicesGroupByDate copyWith({
    DateTime? date,
    List<Service>? services,
    bool? isExpaded,
  }) {
    return ServicesGroupByDate(
      date: date ?? this.date,
      services: services ?? this.services,
      isExpaded: isExpaded ?? this.isExpaded,
    );
  }
}
