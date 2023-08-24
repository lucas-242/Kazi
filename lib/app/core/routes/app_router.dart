import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kazi/app/app_shell.dart';
import 'package:kazi/app/core/constants/app_keys.dart';
import 'package:kazi/app/data/local_storage/local_storage.dart';
import 'package:kazi/app/features/home/home.dart';
import 'package:kazi/app/features/initial/intial.dart';
import 'package:kazi/app/features/login/login.dart';
import 'package:kazi/app/features/profile/profile.dart';
import 'package:kazi/app/features/service_types/service_types.dart';
import 'package:kazi/app/features/services/services.dart';
import 'package:kazi/app/models/enums/app_page.dart';
import 'package:kazi/app/models/route_params.dart';
import 'package:kazi/injector_container.dart';

abstract class AppRouter {
  static GoRouter get router => _router;

  static bool get showOnboarding =>
      serviceLocator
          .get<LocalStorage>()
          .get<bool>(AppKeys.showOnboardingStorage) ??
      true;

  static String initial = '/';
  static String onboarding = '/onboarding';
  static String home = '/home';
  static String login = '/login';
  static String loginPrivacyPolicy = '$login/privacy-policy';
  static String loginForgotPassword = '$login/forgot-password';
  static String services = '/services';
  static String addServices = '$services/$add';
  static String servicesType = '$services/$type';
  static String addServiceType = '$servicesType/$add';
  static String calculator = '/calculator';
  static String profile = '/profile';

  static String add = 'add';
  static String type = 'type';
  static String privacyPolicy = 'privacy-policy';
  static String forgotPassword = 'forgot-password';
}

final _router = GoRouter(
  initialLocation: AppRouter.initial,
  routes: [
    GoRoute(
      path: AppRouter.initial,
      pageBuilder: (context, state) =>
          _customTransition(state, const SplashPage()),
    ),
    GoRoute(
      path: AppRouter.onboarding,
      redirect: (context, state) {
        if (AppRouter.showOnboarding) return null;
        return AppRouter.home;
      },
      pageBuilder: (context, state) =>
          _customTransition(state, const OnboardingPage()),
    ),
    GoRoute(
        path: AppRouter.login,
        pageBuilder: (context, state) =>
            _customTransition(state, const LoginLandingPage()),
        routes: [_privacyPolicy, _forgotPassword]),
    ShellRoute(
      builder: (context, state, child) => AppShell(
        params: state.extra != null
            ? (state.extra as RouteParams)
            : const RouteParams(lastPage: AppPage.home),
        child: child,
      ),
      routes: [
        GoRoute(
          path: AppRouter.home,
          pageBuilder: (context, state) => _customTransition(
            state,
            // HomePage(showOnboarding: AppRouter.showOnboarding),
            const HomePage(),
          ),
          routes: [_addService, _serviceDetails],
        ),
        GoRoute(
          path: AppRouter.services,
          pageBuilder: (context, state) => _customTransition(
            state,
            const ServiceLandingPage(),
            // ServiceLandingPage(showOnboarding: AppRouter.showOnboarding),
          ),
          routes: [
            GoRoute(
              path: AppRouter.type,
              pageBuilder: (context, state) =>
                  _customTransition(state, const ServiceTypesPage()),
              routes: [
                GoRoute(
                  path: AppRouter.add,
                  pageBuilder: (context, state) => _customTransition(
                    state,
                    const ServiceTypeFormPage(),
                  ),
                ),
              ],
            ),
            _addService,
            _serviceDetails,
          ],
        ),
        GoRoute(
          path: AppRouter.profile,
          builder: (context, state) => const ProfilePage(),
          routes: [_addService],
        ),
      ],
    ),
  ],
);

final _privacyPolicy = GoRoute(
  path: AppRouter.privacyPolicy,
  pageBuilder: (context, state) =>
      _customTransition(state, const PrivacyPolicyPage()),
);

final _forgotPassword = GoRoute(
  path: AppRouter.forgotPassword,
  pageBuilder: (context, state) =>
      _customTransition(state, const ForgotPasswordPage()),
);

final _serviceDetails = GoRoute(
  path: ':serviceId',
  pageBuilder: (context, state) => _customTransition(
    state,
    ServiceDetailsPage(
      service: (state.extra as RouteParams).service!,
    ),
  ),
);

final _addService = GoRoute(
  path: AppRouter.add,
  pageBuilder: (context, state) => _customTransition(
    state,
    ServiceFormPage(service: (state.extra as RouteParams).service),
  ),
);

CustomTransitionPage<Widget> _customTransition(
    GoRouterState state, Widget child) {
  final Tween<Offset> bottomUpTween = Tween<Offset>(
    begin: const Offset(0.0, 0.25),
    end: Offset.zero,
  );
  final Animatable<double> fastOutSlowInTween =
      CurveTween(curve: Curves.fastOutSlowIn);
  final Animatable<double> easeInTween = CurveTween(curve: Curves.easeIn);

  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: animation.drive(bottomUpTween.chain(fastOutSlowInTween)),
        child: FadeTransition(
          opacity: easeInTween.animate(animation),
          child: child,
        ),
      );
    },
  );
}
