import 'package:kazi/app/core/routes/app_router.dart';

enum AppPage {
  onboarding(-1),
  home(0),
  services(1),
  serviceDetails(1),
  calculator(2),
  profile(3),
  addServices(4),
  servicesType(6),
  addServiceType(7),
  signIn(10),
  signUp(11),
  forgotPassword(12),
  resetPassword(13),
  profileResetPassword(14),
  privacyPolicy(15),
  privacyPolicyWebView(16);

  const AppPage(this.value);

  final int value;

  static AppPage fromIndex(int value) {
    for (AppPage page in AppPage.values) {
      if (page.value == value) {
        return page;
      }
    }

    return home;
  }

  static String getRoute(AppPage page, {int? id}) {
    switch (page) {
      case AppPage.home:
        return AppRouter.home;
      case AppPage.services:
        return AppRouter.services;
      case AppPage.addServices:
        return AppRouter.addServices;
      case AppPage.calculator:
        return AppRouter.calculator;
      case AppPage.profile:
        return AppRouter.profile;
      case AppPage.serviceDetails:
        return '${AppRouter.services}/$id';
      case AppPage.servicesType:
        return AppRouter.servicesType;
      case AppPage.addServiceType:
        return AppRouter.addServiceType;
      case AppPage.onboarding:
        return AppRouter.onboarding;
      case AppPage.signIn:
        return AppRouter.login + AppRouter.signIn;
      case AppPage.signUp:
        return AppRouter.login + AppRouter.signUp;
      case AppPage.forgotPassword:
        return AppRouter.login + AppRouter.forgotPassword;
      case AppPage.resetPassword:
        return AppRouter.login + AppRouter.resetPassword;
      case AppPage.profileResetPassword:
        return AppRouter.profileResetPassword;
      case AppPage.privacyPolicy:
        return AppRouter.login + AppRouter.privacyPolicy;
      case AppPage.privacyPolicyWebView:
        return AppRouter.login + AppRouter.privacyPolicy + AppRouter.webView;
    }
  }
}
