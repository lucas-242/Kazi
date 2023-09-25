import 'package:kazi/app/core/constants/app_keys.dart';
import 'package:kazi/app/data/local_storage/local_storage.dart';
import 'package:kazi/injector_container.dart';

abstract class AppRouter {
  static bool get showOnboarding =>
      serviceLocator
          .get<LocalStorage>()
          .get<bool>(AppKeys.showOnboardingStorage) ??
      true;

  static String initial = '/';
  static String splash = '/splash';
  static String onboarding = '/onboarding';
  static String home = '/home';
  static String login = '/login';
  static String services = '/services';
  static String addServices = '$services$add';
  static String servicesType = '$services$type';
  static String addServiceType = '$servicesType$add';
  static String profile = '/profile';
  static String profileResetPassword = '$profile$resetPassword';

  static String add = '/add';
  static String type = '/type';
  static String privacyPolicy = '/privacy-policy';
  static String signIn = '/sign-in';
  static String signUp = '/sign-up';
  static String forgotPassword = '/forgot-password';
  static String resetPassword = '/reset-password';
  static String webView = '/web-view';
}
