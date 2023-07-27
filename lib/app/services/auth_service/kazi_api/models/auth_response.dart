// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
final class AuthResponse {
  AuthResponse({required this.authenticationToken, required this.refreshToken});

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
  final String authenticationToken;
  final String refreshToken;

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
