// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:kazi/app/models/enums/user_type.dart';

part 'user_data.g.dart';

@JsonSerializable()
final class UserData {
  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.userType,
    required this.authExpires,
    required this.authToken,
    required this.refreshToken,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  @JsonKey(name: 'authenticationToken')
  final String authToken;
  final String refreshToken;
  final int id;
  final String name;
  final String email;
  @JsonKey(name: 'expires')
  final DateTime authExpires;
  final UserType userType;

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
