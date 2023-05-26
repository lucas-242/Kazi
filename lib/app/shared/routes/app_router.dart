import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kazi/app/app_shell.dart';
import 'package:kazi/app/data/local_storage/local_storage.dart';
import 'package:kazi/app/models/service.dart';
import 'package:kazi/app/shared/constants/app_keys.dart';
import 'package:kazi/app/views/home/home.dart';
import 'package:kazi/app/views/initial/intial.dart';
import 'package:kazi/app/views/login/login.dart';
import 'package:kazi/app/views/profile/profile.dart';
import 'package:kazi/app/views/service_types/service_types.dart';
import 'package:kazi/app/views/services/services.dart';
import 'package:kazi/injector_container.dart';
import 'package:showcaseview/showcaseview.dart';

abstract class AppRouter {
  static GoRouter get router => _router;

  static bool get showOnboarding =>
      serviceLocator
          .get<LocalStorage>()
          .getBool(AppKeys.showOnboardingStorage) ??
      true;

  static String initial = '/';
  static String onboarding = '/onboarding';
  static String home = '/home';
  static String login = '/login';
  static String services = '/services';
  static String addServices = '$services/$add';
  static String servicesType = '$services/$type';
  static String addServiceType = '$servicesType/$add';
  static String calculator = '/calculator';
  static String profile = '/profile';

  static String add = 'add';
  static String type = 'type';
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
          _customTransition(state, const LoginPage()),
    ),
    ShellRoute(
      builder: (context, state, child) => ShowCaseWidget(
        disableBarrierInteraction: true,
        disableMovingAnimation: true,
        enableAutoScroll: true,
        builder: Builder(
          builder: (context) => AppShell(child: child),
        ),
      ),
      routes: [
        GoRoute(
          path: AppRouter.home,
          pageBuilder: (context, state) => _customTransition(
            state,
            HomePage(showOnboarding: AppRouter.showOnboarding),
          ),
          routes: [
            GoRoute(
              path: ':serviceId',
              pageBuilder: (context, state) => _customTransition(
                state,
                ServiceDetailsPage(service: state.extra as Service),
              ),
            ),
          ],
        ),
        GoRoute(
          path: AppRouter.services,
          pageBuilder: (context, state) => _customTransition(
            state,
            ServiceLandingPage(showOnboarding: AppRouter.showOnboarding),
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
            GoRoute(
              path: AppRouter.add,
              pageBuilder: (context, state) => _customTransition(
                state,
                ServiceFormPage(service: state.extra as Service?),
              ),
            ),
            GoRoute(
              path: ':serviceId',
              pageBuilder: (context, state) => _customTransition(
                state,
                ServiceDetailsPage(service: state.extra as Service),
              ),
            ),
          ],
        ),
        GoRoute(
          path: AppRouter.calculator,
          pageBuilder: (context, state) =>
              _customTransition(state, const ServiceTypesPage()),
        ),
        GoRoute(
          path: AppRouter.profile,
          builder: (context, state) => const ProfilePage(),
        ),
      ],
    ),
  ],
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
