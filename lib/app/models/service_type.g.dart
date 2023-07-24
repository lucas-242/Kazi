// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceType _$ServiceTypeFromJson(Map<String, dynamic> json) => ServiceType(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      defaultValue: (json['defaultValue'] as num?)?.toDouble(),
      discountPercent: (json['discountPercent'] as num?)?.toDouble(),
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$ServiceTypeToJson(ServiceType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'defaultValue': instance.defaultValue,
      'discountPercent': instance.discountPercent,
      'userId': instance.userId,
    };
