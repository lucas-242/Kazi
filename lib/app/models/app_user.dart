// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:kazi/app/models/enums.dart';

part 'app_user.g.dart';

@JsonSerializable(constructor: '_')
class AppUser {
  AppUser._({
    required this.name,
    required this.email,
    this.photoUrl,
    required this.uid,
    required this.password,
    this.userType = UserType.selfEmployed,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  AppUser.toCreate({
    this.name = '',
    this.email = '',
    this.photoUrl,
    this.uid = '',
    this.password = '',
    this.userType = UserType.selfEmployed,
  });

  AppUser.fromSignIn({
    required this.name,
    required this.email,
    this.photoUrl,
    required this.uid,
    required this.userType,
  }) : password = '';

  final String name;
  final String email;
  final String? photoUrl;
  final String uid;
  final String password;
  final UserType userType;

  String get shortName => name.length > 18 ? name.split('').first : name;

  Map<String, dynamic> toJson() => _$AppUserToJson(this);

  AppUser copyWith({
    String? name,
    String? email,
    String? photoUrl,
    String? uid,
    String? password,
    UserType? userType,
  }) {
    return AppUser._(
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      uid: uid ?? this.uid,
      password: password ?? this.password,
      userType: userType ?? this.userType,
    );
  }
}
