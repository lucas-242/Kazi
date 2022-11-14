import 'dart:convert';

class ServiceType {
  final String id;
  final String name;
  final double? defaultValue;
  final double? descountPercent;
  final String userId;

  ServiceType({
    required this.id,
    required this.name,
    this.defaultValue,
    this.descountPercent,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'defaultValue': defaultValue,
      'descountPercent': descountPercent,
      'userId': userId,
    };
  }

  factory ServiceType.fromMap(Map<String, dynamic> map) {
    return ServiceType(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      defaultValue: map['defaultValue']?.toDouble(),
      descountPercent: map['descountPercent']?.toDouble(),
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
    double? descountPercent,
    String? userId,
  }) {
    return ServiceType(
      id: id ?? this.id,
      name: name ?? this.name,
      defaultValue: defaultValue ?? this.defaultValue,
      descountPercent: descountPercent ?? this.descountPercent,
      userId: userId ?? this.userId,
    );
  }
}
