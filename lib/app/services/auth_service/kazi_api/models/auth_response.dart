import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
final class AuthResponse {
  final String authenticationToken;
  final String refreshToken;

  AuthResponse({required this.authenticationToken, required this.refreshToken});

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
