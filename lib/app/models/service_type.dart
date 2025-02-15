import 'dart:convert';

import 'package:equatable/equatable.dart';

class ServiceType extends Equatable {

  const ServiceType({
    this.id = '',
    this.name = '',
    this.defaultValue,
    this.discountPercent,
    required this.userId,
  });

  factory ServiceType.fromMap(Map<String, dynamic> map) {
    return ServiceType(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      defaultValue: map['defaultValue']?.toDouble(),
      discountPercent: map['discountPercent']?.toDouble(),
      userId: map['userId'] ?? '',
    );
  }

  factory ServiceType.fromJson(String source) =>
      ServiceType.fromMap(json.decode(source));
  final String id;
  final String name;
  final double? defaultValue;
  final double? discountPercent;
  final String userId;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'defaultValue': defaultValue,
      'discountPercent': discountPercent,
      'userId': userId,
    };
  }

  String toJson() => json.encode(toMap());

  ServiceType copyWith({
    String? id,
    String? name,
    double? defaultValue,
    double? discountPercent,
    String? userId,
  }) {
    return ServiceType(
      id: id ?? this.id,
      name: name ?? this.name,
      defaultValue: defaultValue ?? this.defaultValue,
      discountPercent: discountPercent ?? this.discountPercent,
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object?> get props => [id, name, defaultValue, discountPercent, userId];
}
