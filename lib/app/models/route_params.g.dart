// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteParams _$RouteParamsFromJson(Map<String, dynamic> json) => RouteParams(
      lastPage: $enumDecode(_$AppPageEnumMap, json['lastPage']),
      service: json['service'] == null
          ? null
          : Service.fromJson(json['service'] as Map<String, dynamic>),
      objects: json['objects'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$RouteParamsToJson(RouteParams instance) =>
    <String, dynamic>{
      'lastPage': _$AppPageEnumMap[instance.lastPage]!,
      'service': instance.service,
      'objects': instance.objects,
    };

const _$AppPageEnumMap = {
  AppPage.onboarding: 'onboarding',
  AppPage.home: 'home',
  AppPage.services: 'services',
  AppPage.serviceDetails: 'serviceDetails',
  AppPage.profile: 'profile',
  AppPage.addServices: 'addServices',
  AppPage.servicesType: 'servicesType',
  AppPage.addServiceType: 'addServiceType',
  AppPage.signIn: 'signIn',
  AppPage.signUp: 'signUp',
  AppPage.forgotPassword: 'forgotPassword',
  AppPage.resetPassword: 'resetPassword',
  AppPage.profileResetPassword: 'profileResetPassword',
  AppPage.privacyPolicy: 'privacyPolicy',
  AppPage.privacyPolicyWebView: 'privacyPolicyWebView',
};
