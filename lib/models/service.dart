import 'service_type.dart';

class Service {
  final String id;
  final String? description;
  final double value;
  final double discountPercent;
  final ServiceType? type;
  final String typeId;
  final DateTime date;
  final String userId;

  Service({
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
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Service &&
        other.id == id &&
        other.description == description &&
        other.value == value &&
        other.discountPercent == discountPercent &&
        other.typeId == typeId &&
        other.date == date &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        description.hashCode ^
        value.hashCode ^
        discountPercent.hashCode ^
        typeId.hashCode ^
        date.hashCode ^
        userId.hashCode;
  }
}
