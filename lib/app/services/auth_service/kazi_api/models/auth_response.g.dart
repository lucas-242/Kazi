// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
      id: AuthResponse._idFromJson(json['id'] as int?),
      name: json['name'] as String,
      email: json['email'] as String,
      authExpires: json['expires'] as int,
      authToken: json['authenticationToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{
      'authenticationToken': instance.authToken,
      'refreshToken': instance.refreshToken,
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'expires': instance.authExpires,
    };
