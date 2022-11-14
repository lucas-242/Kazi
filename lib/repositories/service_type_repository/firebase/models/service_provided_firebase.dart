import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_services/models/service_provided.dart';

import '../../../../models/service_type.dart';

class ServiceProvidedFirebase extends ServiceProvided {
  ServiceProvidedFirebase({
    required super.id,
    required super.description,
    required super.value,
    super.type,
    required super.typeId,
    required super.date,
    required super.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'value': value,
      'typeId': typeId,
      'date': Timestamp.fromDate(date),
      'userId': userId,
    };
  }

  factory ServiceProvidedFirebase.fromMap(Map<String, dynamic> map) {
    return ServiceProvidedFirebase(
      id: map['id'] ?? '',
      description: map['description'] ?? '',
      value: map['value']?.toDouble() ?? 0.0,
      type: map['type'] != null ? ServiceType.fromMap(map['type']) : null,
      typeId: map['typeId'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      userId: map['userId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceProvidedFirebase.fromJson(String source) =>
      ServiceProvidedFirebase.fromMap(json.decode(source));

  ServiceProvidedFirebase copyWith({
    String? id,
    String? description,
    double? value,
    ServiceType? type,
    String? typeId,
    DateTime? date,
    String? userId,
  }) {
    return ServiceProvidedFirebase(
      id: id ?? this.id,
      description: description ?? this.description,
      value: value ?? this.value,
      type: type ?? this.type,
      typeId: typeId ?? this.typeId,
      date: date ?? this.date,
      userId: userId ?? this.userId,
    );
  }

  factory ServiceProvidedFirebase.fromServiceProvided(ServiceProvided source) =>
      source as ServiceProvidedFirebase;
}
