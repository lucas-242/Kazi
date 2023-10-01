import 'package:kazi/app/core/routes/app_router.dart';

enum AppPage {
  onboarding(-1),
  home(0),
  services(1),
  serviceDetails(1),
  profile(2),
  addServices(3),
  servicesType(4),
  addServiceType(5),
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
        return '${AppRouter.home}/';
      case AppPage.services:
        return AppRouter.services;
      case AppPage.addServices:
        return AppRouter.services + AppRouter.add;
      case AppPage.profile:
        return '${AppRouter.profile}/';
      case AppPage.serviceDetails:
        return '${AppRouter.services}/$id';
      case AppPage.servicesType:
        return AppRouter.services + AppRouter.type;
      case AppPage.addServiceType:
        return AppRouter.services + AppRouter.type + AppRouter.add;
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
        return AppRouter.profile + AppRouter.resetPassword;
      case AppPage.privacyPolicy:
        return AppRouter.login + AppRouter.privacyPolicy;
      case AppPage.privacyPolicyWebView:
        return AppRouter.login + AppRouter.privacyPolicy + AppRouter.webView;
    }
  }
}
