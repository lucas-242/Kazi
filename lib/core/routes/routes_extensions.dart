import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kazi/core/constants/app_keys.dart';
import 'package:kazi/core/l10n/generated/l10n.dart';
import 'package:kazi/core/routes/routes.dart';
import 'package:kazi/domain/services/local_storage.dart';
import 'package:kazi/service_locator.dart';
import 'package:kazi_core/kazi_core.dart';
import 'package:kazi_design_system/kazi_design_system.dart';

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

  void navigateBack() => RoutesService.navigateBack(this);

  void navigateToAddServices([Service? service]) =>
      RoutesService.navigateToAddServices(this, service);

  void closeModal<T extends Object>([T? result]) => pop(result);

  void showSnackBar(
    String message, {
    SnackBarType type = SnackBarType.error,
    bool hasBottomNavigation = true,
    bool horizontalMargin = true,
  }) =>
      showKaziSnackBar(
        this,
        message,
        horizontalMargin: horizontalMargin,
        hasBottomNavigation: hasBottomNavigation,
        type: type,
      );

  Future<bool?> showLeftBottomSheet() => showModalBottomSheet<bool>(
        context: this,
        useRootNavigator: true,
        builder: (context) => KaziBottomSheet(
          title: AppLocalizations.current.leaveApp,
          backText: AppLocalizations.current.back,
          onBack: () => context.closeModal(false),
          exitText: AppLocalizations.current.exit,
          onClose: () {
            context.closeModal(true);
            context.navigateBack();
          },
        ),
      );
}
