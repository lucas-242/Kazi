// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_group_by_date.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServicesGroupByDate _$ServicesGroupByDateFromJson(Map<String, dynamic> json) =>
    ServicesGroupByDate(
      date: DateTime.parse(json['date'] as String),
      services: (json['services'] as List<dynamic>)
          .map((e) => Service.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
