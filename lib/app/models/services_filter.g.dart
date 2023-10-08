// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServicesFilter _$ServicesFilterFromJson(Map<String, dynamic> json) =>
    ServicesFilter(
      scheduledToStartAt: json['scheduledToStartAt'] == null
          ? null
          : DateTime.parse(json['scheduledToStartAt'] as String),
      scheduledToEndAt: json['scheduledToEndAt'] == null
          ? null
          : DateTime.parse(json['scheduledToEndAt'] as String),
      orderBy: $enumDecodeNullable(_$OrderByEnumMap, json['orderBy']) ??
          OrderBy.dateDesc,
      isActive: json['isActive'] as bool? ?? true,
      pageSize: json['pageSize'] as int? ?? 10,
      pageNumber: json['pageNumber'] as int? ?? 0,
    );

Map<String, dynamic> _$ServicesFilterToJson(ServicesFilter instance) =>
    <String, dynamic>{
      'scheduledToStartAt': instance.scheduledToStartAt?.toIso8601String(),
      'scheduledToEndAt': instance.scheduledToEndAt?.toIso8601String(),
      'orderBy': _$OrderByEnumMap[instance.orderBy],
      'isActive': instance.isActive,
      'pageSize': instance.pageSize,
      'pageNumber': instance.pageNumber,
    };

const _$OrderByEnumMap = {
  OrderBy.alphabetical: 'alphabetical',
  OrderBy.valueAsc: 'valueAsc',
  OrderBy.valueDesc: 'valueDesc',
  OrderBy.dateAsc: 'dateAsc',
  OrderBy.dateDesc: 'dateDesc',
};
