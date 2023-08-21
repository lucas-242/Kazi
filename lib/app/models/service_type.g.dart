// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceType _$ServiceTypeFromJson(Map<String, dynamic> json) => ServiceType(
      id: json['id'] as int,
      name: json['name'] as String,
      userId: json['userId'] as int,
      defaultValue: (json['value'] as num).toDouble(),
      discountPercent: (json['discountValue'] as num).toDouble(),
    );
