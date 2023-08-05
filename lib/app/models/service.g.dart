// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Service _$ServiceFromJson(Map<String, dynamic> json) => Service(
      id: json['id'] as String? ?? '',
      description: json['description'] as String?,
      value: (json['value'] as num?)?.toDouble() ?? 0,
      discountPercent: (json['discountPercent'] as num?)?.toDouble() ?? 0,
      type: json['type'] == null
          ? null
          : ServiceType.fromJson(json['type'] as Map<String, dynamic>),
      typeId: json['typeId'] as String? ?? '',
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'value': instance.value,
      'discountPercent': instance.discountPercent,
      'type': instance.type,
      'typeId': instance.typeId,
      'date': instance.date.toIso8601String(),
      'userId': instance.userId,
    };
