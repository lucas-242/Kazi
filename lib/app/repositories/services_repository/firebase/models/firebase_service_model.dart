import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:kazi/app/models/service.dart';
import 'package:kazi/app/models/service_type.dart';

class FirebaseServiceModel extends Service {
  FirebaseServiceModel({
    super.id,
    super.description,
    required super.value,
    required super.discountPercent,
    super.type,
    required super.typeId,
    required super.date,
    required super.userId,
  });

  factory FirebaseServiceModel.fromMap(Map<String, dynamic> map) {
    return FirebaseServiceModel(
      id: map['id'] ?? '',
      description: map['description'],
      value: map['value']?.toDouble(),
      discountPercent: map['discountPercent']?.toDouble(),
      type: map['type'] != null ? ServiceType.fromMap(map['type']) : null,
      typeId: map['typeId'],
      date: DateTime.fromMillisecondsSinceEpoch(
          map['date'].millisecondsSinceEpoch,),
      userId: map['userId'],
    );
  }

  factory FirebaseServiceModel.fromJson(String source) =>
      FirebaseServiceModel.fromMap(json.decode(source));

  factory FirebaseServiceModel.fromService(Service source) =>
      FirebaseServiceModel(
        id: source.id,
        description: source.description,
        value: source.value,
        discountPercent: source.discountPercent,
        typeId: source.typeId,
        date: source.date,
        userId: source.userId,
      );

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'value': value,
      'typeId': typeId,
      'discountPercent': discountPercent,
      'date': Timestamp.fromDate(date),
      'userId': userId,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  FirebaseServiceModel copyWith({
    String? id,
    String? description,
    double? value,
    double? discountPercent,
    ServiceType? type,
    String? typeId,
    DateTime? date,
    String? userId,
  }) {
    return FirebaseServiceModel(
      id: id ?? this.id,
      description: description ?? this.description,
      value: value ?? this.value,
      discountPercent: discountPercent ?? this.discountPercent,
      type: type ?? this.type,
      typeId: typeId ?? this.typeId,
      date: date ?? this.date,
      userId: userId ?? this.userId,
    );
  }
}
