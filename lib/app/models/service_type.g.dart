// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceType _$ServiceTypeFromJson(Map<String, dynamic> json) => ServiceType(
      id: ServiceType._idFromJson(json['id'] as int),
      name: json['name'] as String,
      userId: ServiceType._idFromJson(json['userId'] as int),
      defaultValue: (json['value'] as num).toDouble(),
      discountPercent: (json['discountValue'] as num).toDouble(),
    );

Map<String, dynamic> _$ServiceTypeToJson(ServiceType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'value': instance.defaultValue,
      'discountValue': instance.discountPercent,
      'userId': instance.userId,
    };
