import 'package:equatable/equatable.dart';

import 'service_type.dart';

class Service extends Equatable {

  Service({
    this.id = '',
    this.description,
    this.value = 0,
    this.discountPercent = 0,
    this.type,
    this.typeId = '',
    DateTime? date,
    required this.userId,
  }) : date = date ??
            DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day,);
  final String id;
  final String? description;
  final double value;
  final double discountPercent;
  final ServiceType? type;
  final String typeId;
  final DateTime date;
  final String userId;

  double get valueDiscounted => value * discountPercent / 100;

  double get valueWithDiscount => value - valueDiscounted;

  Service copyWith({
    String? id,
    String? description,
    double? value,
    double? discountPercent,
    ServiceType? type,
    String? typeId,
    DateTime? date,
    String? userId,
  }) {
    return Service(
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

  @override
  List<Object?> get props =>
      [id, description, value, discountPercent, type, typeId, date, userId];
}
