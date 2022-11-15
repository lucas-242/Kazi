import 'dart:convert';

class ServiceType {
  final String id;
  final String name;
  final double? defaultValue;
  final double? discountPercent;
  final String userId;

  ServiceType({
    this.id = '',
    this.name = '',
    this.defaultValue,
    this.discountPercent,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'defaultValue': defaultValue,
      'discountPercent': discountPercent,
      'userId': userId,
    };
  }

  factory ServiceType.fromMap(Map<String, dynamic> map) {
    return ServiceType(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      defaultValue: map['defaultValue']?.toDouble(),
      discountPercent: map['discountPercent']?.toDouble(),
      userId: map['userId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceType.fromJson(String source) =>
      ServiceType.fromMap(json.decode(source));

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
}
