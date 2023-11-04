import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kazi/app/models/service.dart';

part 'service_group_by_date.g.dart';

@JsonSerializable(createToJson: false)
class ServicesGroupByDate extends Equatable {
  const ServicesGroupByDate({
    required this.date,
    required this.services,
    this.isExpanded = false,
  });

  factory ServicesGroupByDate.fromJson(Map<String, dynamic> json) =>
      _$ServicesGroupByDateFromJson(json);

  final DateTime date;
  final List<Service> services;
  @JsonKey(includeFromJson: false, includeToJson: true)
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
