import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'service_type.dart';

part 'service.g.dart';

@JsonSerializable(createToJson: false, constructor: '_')
class Service extends Equatable {
  const Service._({
    required this.id,
    required this.description,
    required this.value,
    required this.discountPercent,
    required this.serviceType,
    required this.serviceTypeId,
    required this.scheduledToStartAt,
    required this.scheduledToEndAt,
    required this.startedAt,
    required this.endedAt,
    required this.employeeId,
    required this.scheduledBy,
    required this.customerId,
  });

  Service.toCreate({
    this.description,
    this.value = 0,
    this.discountPercent = 0,
    this.serviceType,
    this.serviceTypeId = 0,
    DateTime? scheduledToStartAt,
    DateTime? scheduledToEndAt,
    this.startedAt,
    this.endedAt,
    required this.employeeId,
    this.customerId,
  })  : id = 0,
        scheduledBy = employeeId,
        scheduledToStartAt = scheduledToStartAt ?? _defaultDate,
        scheduledToEndAt = scheduledToEndAt ?? _defaultDate;

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);

  static final _defaultDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  final int id;
  final String? description;
  final double value;
  final double discountPercent;
  final ServiceType? serviceType;
  final int serviceTypeId;
  final DateTime scheduledToStartAt;
  final DateTime scheduledToEndAt;
  final DateTime? startedAt;
  final DateTime? endedAt;
  final int employeeId;
  final int scheduledBy;
  final int? customerId;

  double get discountValue => value * discountPercent / 100;
  double get finalValue => value - discountValue;

  Service copyWith({
    int? id,
    String? description,
    double? value,
    double? discountPercent,
    ServiceType? serviceType,
    int? serviceTypeId,
    DateTime? scheduledToStartAt,
    DateTime? scheduledToEndAt,
    DateTime? startedAt,
    DateTime? endedAt,
    int? employeeId,
    int? customerId,
    int? scheduledBy,
  }) {
    return Service._(
      id: id ?? this.id,
      description: description ?? this.description,
      value: value ?? this.value,
      discountPercent: discountPercent ?? this.discountPercent,
      serviceType: serviceType ?? serviceType,
      serviceTypeId: serviceTypeId ?? this.serviceTypeId,
      scheduledToStartAt: scheduledToStartAt ?? this.scheduledToStartAt,
      scheduledToEndAt: scheduledToEndAt ?? this.scheduledToEndAt,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      employeeId: employeeId ?? this.employeeId,
      customerId: customerId ?? this.customerId,
      scheduledBy: scheduledBy ?? this.scheduledBy,
    );
  }

  @override
  List<Object?> get props => [
        id,
        description,
        value,
        discountPercent,
        serviceType,
        serviceTypeId,
        scheduledToStartAt,
        scheduledToEndAt,
        startedAt,
        endedAt,
        employeeId,
        customerId,
        scheduledBy,
      ];

  Map<String, dynamic> toJson({bool withId = false}) {
    final json = {
      'description': description,
      'value': value,
      'discountPercent': discountPercent,
      'serviceTypeId': serviceTypeId,
      'scheduledToStartAt': scheduledToStartAt.toIso8601String(),
      'scheduledToEndAt': scheduledToEndAt.toIso8601String(),
      'startedAt': startedAt?.toIso8601String(),
      'endedAt': endedAt?.toIso8601String(),
      'employeeId': employeeId,
      'customerId': customerId,
      'scheduledBy': scheduledBy,
    };

    if (withId) {
      json.addEntries([MapEntry('id', id)]);
    }

    return json;
  }
}
