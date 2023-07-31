// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      authToken: json['authToken'] as String,
      authExpireDate: DateTime.parse(json['authExpireDate'] as String),
      authExpireMiliseconds: json['authExpireMiliseconds'] as int,
      refreshToken: json['refreshToken'] as String,
      userId: json['userId'] as int,
      userName: json['userName'] as String,
      userEmail: json['userEmail'] as String,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'authToken': instance.authToken,
      'refreshToken': instance.refreshToken,
      'userId': instance.userId,
      'userName': instance.userName,
      'userEmail': instance.userEmail,
      'authExpireMiliseconds': instance.authExpireMiliseconds,
      'authExpireDate': instance.authExpireDate.toIso8601String(),
    };
