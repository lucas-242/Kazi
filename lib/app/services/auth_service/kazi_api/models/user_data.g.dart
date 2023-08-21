// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      userType: $enumDecode(_$UserTypeEnumMap, json['userType']),
      authExpires: DateTime.parse(json['expires'] as String),
      authToken: json['authenticationToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'authenticationToken': instance.authToken,
      'refreshToken': instance.refreshToken,
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'expires': instance.authExpires.toIso8601String(),
      'userType': _$UserTypeEnumMap[instance.userType]!,
    };

const _$UserTypeEnumMap = {
  UserType.administrator: 'administrator',
  UserType.manager: 'manager',
  UserType.selfEmployed: 'selfEmployed',
  UserType.employee: 'employee',
};
