// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
final class AuthResponse {
  AuthResponse({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.authExpires,
    required this.authToken,
    required this.refreshToken,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  final String authToken;
  final String refreshToken;
  final int userId;
  final String userName;
  final String userEmail;
  final int authExpires;

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
