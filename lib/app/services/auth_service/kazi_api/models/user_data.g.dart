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
      authExpires: json['expires'] as int,
      authToken: json['authenticationToken'] as String,
      refreshToken: json['refreshToken'] as String,
      authExpiresDate: DateTime.parse(json['authExpiresDate'] as String),
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'authenticationToken': instance.authToken,
      'refreshToken': instance.refreshToken,
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'expires': instance.authExpires,
      'userType': _$UserTypeEnumMap[instance.userType]!,
    };

const _$UserTypeEnumMap = {
  UserType.administrator: 'administrator',
  UserType.manager: 'manager',
  UserType.selfEmployed: 'selfEmployed',
  UserType.employee: 'employee',
};
