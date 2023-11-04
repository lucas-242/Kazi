// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Service _$ServiceFromJson(Map<String, dynamic> json) => Service._(
      id: json['id'] as int,
      description: json['description'] as String?,
      value: (json['value'] as num).toDouble(),
      discountPercent: (json['discountPercent'] as num).toDouble(),
      serviceType: json['serviceType'] == null
          ? null
          : ServiceType.fromJson(json['serviceType'] as Map<String, dynamic>),
      serviceTypeId: json['serviceTypeId'] as int,
      scheduledToStartAt: DateTime.parse(json['scheduledToStartAt'] as String),
      scheduledToEndAt: DateTime.parse(json['scheduledToEndAt'] as String),
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      endedAt: json['endedAt'] == null
          ? null
          : DateTime.parse(json['endedAt'] as String),
      employeeId: json['employeeId'] as int,
      scheduledBy: json['scheduledBy'] as int,
      customerId: json['customerId'] as int?,
    );
