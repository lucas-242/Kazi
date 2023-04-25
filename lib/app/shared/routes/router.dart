import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_services/app/app_shell.dart';
import 'package:my_services/app/data/local_storage/local_storage.dart';
import 'package:my_services/app/models/service.dart';
import 'package:my_services/app/shared/constants/global_keys.dart';
import 'package:my_services/app/shared/routes/app_routes.dart';
import 'package:my_services/app/views/home/home.dart';
import 'package:my_services/app/views/initial/intial.dart';
import 'package:my_services/app/views/login/login.dart';
import 'package:my_services/app/views/profile/profile.dart';
import 'package:my_services/app/views/service_types/service_types.dart';
import 'package:my_services/app/views/services/services.dart';
import 'package:my_services/injector_container.dart';

abstract class AppRouter {
  static GoRouter get router => _router;
}

final _router = GoRouter(
  initialLocation: AppRoutes.initial,
  routes: [
    GoRoute(
      path: AppRoutes.initial,
      pageBuilder: (context, state) =>
          _customTransition(state, const SplashPage()),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      redirect: (context, state) {
        final showOnboarding = serviceLocator
                .get<LocalStorage>()
                .getBool(GlobalKeys.showOnboardingStorage) ??
            true;

        if (showOnboarding) return null;

        return AppRoutes.home;
      },
      pageBuilder: (context, state) =>
          _customTransition(state, const OnboardingPage()),
    ),
    GoRoute(
      path: AppRoutes.login,
      pageBuilder: (context, state) =>
          _customTransition(state, const LoginPage()),
    ),
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          pageBuilder: (context, state) =>
              _customTransition(state, const HomePage()),
        ),
        GoRoute(
          path: AppRoutes.services,
          pageBuilder: (context, state) =>
              _customTransition(state, const ServiceLandingPage()),
          routes: [
            GoRoute(
              path: AppRoutes.type,
              pageBuilder: (context, state) =>
                  _customTransition(state, const ServiceTypesPage()),
              routes: [
                GoRoute(
                  path: AppRoutes.add,
                  pageBuilder: (context, state) => _customTransition(
                    state,
                    BlocProvider.value(
                      value: state.extra as ServiceTypesCubit,
                      child: const ServiceTypeFormPage(),
                    ),
                  ),
                ),
              ],
            ),
            GoRoute(
              path: AppRoutes.add,
              pageBuilder: (context, state) => _customTransition(
                state,
                ServiceFormPage(service: state.extra as Service?),
              ),
            ),
            GoRoute(
              path: ':serviceId',
              pageBuilder: (context, state) => _customTransition(
                  state, ServiceDetailsPage(service: state.extra as Service)),
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.calculator,
          pageBuilder: (context, state) =>
              _customTransition(state, const ServiceTypesPage()),
        ),
        GoRoute(
          path: AppRoutes.profile,
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
