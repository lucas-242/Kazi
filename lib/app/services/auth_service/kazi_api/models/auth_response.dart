// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
final class AuthResponse {
  AuthResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.authExpires,
    required this.authToken,
    required this.refreshToken,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  @JsonKey(name: 'authenticationToken')
  final String authToken;
  final String refreshToken;
  @JsonKey(fromJson: _idFromJson)
  final int id;
  final String name;
  final String email;
  @JsonKey(name: 'expires')
  final int authExpires;

  //! Used to avoid a bug - Null is not a subtype of type int. Id could not be null in this response.
  static int _idFromJson(int? value) => value ?? 0;

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
