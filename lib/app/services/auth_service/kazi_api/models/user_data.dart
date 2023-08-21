// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:kazi/app/models/enums.dart';

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

  // factory UserData.fromJson(Map<String, dynamic> json) => UserData(
  //       id: json['id'] as int,
  //       name: json['name'] as String,
  //       email: json['email'] as String,
  //       userType: $enumDecode(_$UserTypeEnumMap, json['userType']),
  //       authExpires: json['expires'] as DateTime,
  //       authToken: json['authenticationToken'] as String,
  //       refreshToken: json['refreshToken'] as String,
  //       authExpiresDate:
  //           DateTime.now().add(Duration(milliseconds: json['expires'])),
  //     );

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
