// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser._(
      name: json['name'] as String,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String?,
      uid: json['uid'] as String,
      password: json['password'] as String,
      userType: $enumDecodeNullable(_$UserTypeEnumMap, json['userType']) ??
          UserType.selfEmployed,
    );

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'uid': instance.uid,
      'password': instance.password,
      'userType': _$UserTypeEnumMap[instance.userType]!,
    };

const _$UserTypeEnumMap = {
  UserType.administrator: 'administrator',
  UserType.manager: 'manager',
  UserType.selfEmployed: 'selfEmployed',
  UserType.employee: 'employee',
};
