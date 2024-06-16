import 'package:kazi/core/routes/app_routes.dart';

enum AppPages {
  onboarding(-1),
  home(0),
  services(1),
  serviceDetails(1),
  addServices(2),
  servicesType(3),
  addServiceType(4),
  profile(5),
  signIn(10),
  signUp(11),
  forgotPassword(12),
  resetPassword(13),
  profileResetPassword(14),
  privacyPolicy(15),
  privacyPolicyWebView(16);

  const AppPages(this.value);

  final int value;

  static AppPages fromIndex(int value) {
    for (AppPages page in AppPages.values) {
      if (page.value == value) {
        return page;
      }
    }

    return home;
  }

  static String getRoute(AppPages page, {int? id}) {
    switch (page) {
      case AppPages.onboarding:
        return AppRoutes.onboarding;
      case AppPages.home:
        return AppRoutes.home;
      case AppPages.services:
        return AppRoutes.services;
      case AppPages.addServices:
        return '${AppRoutes.services}/${AppRoutes.add}';
      case AppPages.serviceDetails:
        return '${AppRoutes.services}/$id';
      case AppPages.servicesType:
        return '${AppRoutes.services}/${AppRoutes.type}';
      case AppPages.addServiceType:
        return '${AppRoutes.services}/${AppRoutes.type}/${AppRoutes.add}';
      case AppPages.profile:
        return AppRoutes.profile;
      case AppPages.signIn:
        return AppRoutes.signIn;
      case AppPages.signUp:
        return AppRoutes.signUp;
      case AppPages.forgotPassword:
        return AppRoutes.forgotPassword;
      case AppPages.resetPassword:
        return '/${AppRoutes.resetPassword}';
      case AppPages.profileResetPassword:
        return '${AppRoutes.profile}/${AppRoutes.resetPassword}';
      case AppPages.privacyPolicy:
        return AppRoutes.privacyPolicy;
      case AppPages.privacyPolicyWebView:
        return '${AppRoutes.privacyPolicy}/${AppRoutes.webView}';
    }
  }
}
