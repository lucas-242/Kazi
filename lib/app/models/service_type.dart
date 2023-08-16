import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'service_type.g.dart';

@JsonSerializable()
class ServiceType extends Equatable {
  const ServiceType({
    required this.id,
    required this.name,
    required this.userId,
    required this.defaultValue,
    required this.discountPercent,
  });

  const ServiceType.toCreate({
    this.name = '',
    this.defaultValue = 0,
    this.discountPercent = 0,
    required this.userId,
  }) : id = '';

  factory ServiceType.fromJson(Map<String, dynamic> json) =>
      _$ServiceTypeFromJson(json);

  @JsonKey(fromJson: _idFromJson)
  final String id;
  final String name;
  @JsonKey(name: 'value')
  final double defaultValue;
  @JsonKey(name: 'discountValue')
  final double discountPercent;
  @JsonKey(fromJson: _idFromJson)
  final String userId;

  static String _idFromJson(int value) => value.toString();

  Map<String, dynamic> toJson() => _$ServiceTypeToJson(this);

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
