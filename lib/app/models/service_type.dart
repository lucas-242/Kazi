import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'service_type.g.dart';

@JsonSerializable(createToJson: false)
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
  }) : id = 0;

  factory ServiceType.fromJson(Map<String, dynamic> json) =>
      _$ServiceTypeFromJson(json);

  final int id;
  final String name;
  @JsonKey(name: 'value')
  final double defaultValue;
  @JsonKey(name: 'discountValue')
  final double discountPercent;
  final int userId;

  Map<String, dynamic> toJson({bool withId = false}) {
    final json = {
      'name': name,
      'value': defaultValue,
      'discountValue': discountPercent,
      'userId': userId,
    };

    if (withId) {
      json.addEntries([MapEntry('id', id)]);
    }

    return json;
  }

  ServiceType copyWith({
    int? id,
    String? name,
    double? defaultValue,
    double? discountPercent,
    int? userId,
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
