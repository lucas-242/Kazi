import 'package:flutter/material.dart';
import 'package:kazi/app/core/constants/app_keys.dart';
import 'package:kazi/app/core/routes/routes.dart';
import 'package:kazi/app/data/local_storage/local_storage.dart';
import 'package:kazi/app/models/route_params.dart';
import 'package:kazi/app/models/service.dart';
import 'package:kazi/service_locator.dart';

extension RoutesExtensions on BuildContext {
  bool get showOnboarding =>
      ServiceLocator.get<LocalStorage>()
          .get<bool>(AppKeys.showOnboardingStorage) ??
      true;

  void navigateTo(
    AppPages page, {
    Service? service,
    String? token,
    WebViewParams? webViewParams,
  }) =>
      RoutesService.navigateTo(
        this,
        page,
        service: service,
        token: token,
        webViewParams: webViewParams,
      );

  void pushTo(
    AppPages page, {
    Service? service,
    String? token,
    WebViewParams? webViewParams,
  }) =>
      RoutesService.pushTo(
        this,
        page,
        service: service,
        token: token,
        webViewParams: webViewParams,
      );

  void navigateBack() => RoutesService.navigateBack();

  void floatingActionNavigation() =>
      RoutesService.floatingActionNavigation(this);
}
