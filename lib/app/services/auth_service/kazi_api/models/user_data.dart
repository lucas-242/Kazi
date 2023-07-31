import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'user_data.g.dart';

@JsonSerializable()
final class UserData {
  UserData({
    required this.authToken,
    required this.authExpireDate,
    required this.authExpireMiliseconds,
    required this.refreshToken,
    required this.userId,
    required this.userName,
    required this.userEmail,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  final String authToken;
  final String refreshToken;
  final int userId;
  final String userName;
  final String userEmail;
  final int authExpireMiliseconds;
  final DateTime authExpireDate;

  String toJson() => jsonEncode(_$UserDataToJson(this));
}
