// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User._(
      name: json['name'] as String,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String?,
      id: json['id'] as int,
      password: json['password'] as String? ?? '',
      userType: $enumDecode(_$UserTypeEnumMap, json['userType']),
      authToken: json['authenticationToken'] as String,
      refreshToken: json['refreshToken'] as String,
      authExpires: DateTime.parse(json['expires'] as String),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'id': instance.id,
      'password': instance.password,
      'userType': _$UserTypeEnumMap[instance.userType]!,
      'authenticationToken': instance.authToken,
      'refreshToken': instance.refreshToken,
      'expires': instance.authExpires.toIso8601String(),
    };

const _$UserTypeEnumMap = {
  UserType.administrator: 'administrator',
  UserType.manager: 'manager',
  UserType.selfEmployed: 'selfEmployed',
  UserType.employee: 'employee',
};
