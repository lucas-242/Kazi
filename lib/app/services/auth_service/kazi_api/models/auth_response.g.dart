// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
      userId: json['userId'] as int,
      userName: json['userName'] as String,
      userEmail: json['userEmail'] as String,
      authExpires: json['authExpires'] as int,
      authToken: json['authToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{
      'authToken': instance.authToken,
      'refreshToken': instance.refreshToken,
      'userId': instance.userId,
      'userName': instance.userName,
      'userEmail': instance.userEmail,
      'authExpires': instance.authExpires,
    };