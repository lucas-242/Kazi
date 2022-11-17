import 'service_type.dart';

class ServiceProvided {
  String id;
  String? description;
  double value;
  double discountPercent;
  ServiceType? type;
  String typeId;
  DateTime date;
  String userId;

  ServiceProvided({
    this.id = '',
    this.description,
    this.value = 0,
    this.discountPercent = 0,
    this.type,
    this.typeId = '',
    DateTime? date,
    required this.userId,
  }) : date = date ?? DateTime.now();

  double get valueDiscounted => value * discountPercent / 100;

  double get valueWithDiscount => value - valueDiscounted;

  ServiceProvided copyWith({
    String? id,
    String? description,
    double? value,
    double? discountPercent,
    ServiceType? type,
    String? typeId,
    DateTime? date,
    String? userId,
  }) {
    return ServiceProvided(
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
