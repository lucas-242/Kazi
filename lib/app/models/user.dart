// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:kazi/app/models/enums/user_type.dart';

part 'user.g.dart';

@JsonSerializable(constructor: '_')
class User {
  User._({
    required this.name,
    required this.email,
    this.photoUrl,
    required this.id,
    required this.password,
    required this.userType,
    required this.authToken,
    required this.refreshToken,
    required this.authExpires,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  User.toCreate({
    this.name = '',
    this.email = '',
    this.photoUrl,
    this.id = 0,
    this.password = '',
    this.userType = UserType.selfEmployed,
  })  : refreshToken = '',
        authToken = '',
        authExpires = DateTime(1999);

  User.fromSignIn({
    required this.name,
    required this.email,
    this.photoUrl,
    required this.id,
    required this.userType,
    required this.authToken,
    required this.refreshToken,
    required this.authExpires,
  }) : password = '';

  final String name;
  final String email;
  final String? photoUrl;
  final int id;
  @JsonKey(defaultValue: '')
  final String password;
  final UserType userType;
  @JsonKey(name: 'authenticationToken')
  final String authToken;
  final String refreshToken;
  @JsonKey(name: 'expires')
  final DateTime authExpires;

  String get shortName => name.length > 18 ? name.split('').first : name;

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? name,
    String? email,
    String? photoUrl,
    int? id,
    String? password,
    UserType? userType,
    String? authToken,
    String? refreshToken,
    DateTime? authExpires,
  }) {
    return User._(
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      id: id ?? this.id,
      password: password ?? this.password,
      userType: userType ?? this.userType,
      authToken: authToken ?? this.authToken,
      authExpires: authExpires ?? this.authExpires,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}
