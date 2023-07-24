import 'dart:convert';

import 'package:kazi/app/models/service_type.dart';

final class FirebaseServiceTypeModel extends ServiceType {
  const FirebaseServiceTypeModel({
    super.id,
    super.name,
    super.defaultValue,
    super.discountPercent,
    required super.userId,
  });
  factory FirebaseServiceTypeModel.fromJson(String source) =>
      FirebaseServiceTypeModel.fromMap(json.decode(source));

  factory FirebaseServiceTypeModel.fromServiceType(ServiceType source) =>
      FirebaseServiceTypeModel(
        id: source.id,
        name: source.name,
        defaultValue: source.defaultValue,
        discountPercent: source.discountPercent,
        userId: source.userId,
      );

  factory FirebaseServiceTypeModel.fromMap(Map<String, dynamic> map) {
    return FirebaseServiceTypeModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      defaultValue: map['defaultValue']?.toDouble(),
      discountPercent: map['discountPercent']?.toDouble(),
      userId: map['userId'] ?? '',
    );
  }

  @override
  FirebaseServiceTypeModel copyWith({
    String? id,
    String? name,
    double? defaultValue,
    double? discountPercent,
    String? userId,
  }) {
    return FirebaseServiceTypeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      defaultValue: defaultValue ?? this.defaultValue,
      discountPercent: discountPercent ?? this.discountPercent,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'defaultValue': defaultValue,
      'discountPercent': discountPercent,
      'userId': userId,
    };
  }
}
