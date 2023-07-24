import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'service_type.g.dart';

@JsonSerializable()
class ServiceType extends Equatable {
  const ServiceType({
    this.id = '',
    this.name = '',
    this.defaultValue,
    this.discountPercent,
    required this.userId,
  });

  factory ServiceType.fromJson(Map<String, dynamic> json) =>
      _$ServiceTypeFromJson(json);

  final String id;
  final String name;
  final double? defaultValue;
  final double? discountPercent;
  final String userId;

  Map<String, dynamic> toJson(Map<String, dynamic> json) =>
      _$ServiceTypeToJson(this);

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
