import 'package:kazi/app/shared/routes/app_router.dart';

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
  login(10);

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

  static String getRoute(AppPage page, {String id = ''}) {
    switch (page) {
      case AppPage.home:
        return '${AppRouter.home}/$id';
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
      case AppPage.login:
        return AppRouter.login;
      case AppPage.onboarding:
        return AppRouter.onboarding;
    }
  }
}
