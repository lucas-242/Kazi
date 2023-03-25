import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_services/app/app_scaffold.dart';
import 'package:my_services/app/models/service.dart';
import 'package:my_services/app/shared/routes/app_routes.dart';
import 'package:my_services/app/views/calendar/calendar.dart';
import 'package:my_services/app/views/home/home.dart';
import 'package:my_services/app/views/services/add_services/add_services.dart';
import 'package:my_services/app/views/services/service_details/pages/service_details_page.dart';
import 'package:my_services/app/views/splash/splash.dart';

final router = GoRouter(
  initialLocation: AppRoutes.initial,
  routes: [
    GoRoute(
      path: AppRoutes.initial,
      pageBuilder: (context, state) =>
          _customTransition(state, const SplashPage()),
    ),
    ShellRoute(
      builder: (context, state, child) => AppScaffold(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          pageBuilder: (context, state) =>
              _customTransition(state, const HomePage()),
        ),
        GoRoute(
            path: AppRoutes.services,
            pageBuilder: (context, state) =>
                _customTransition(state, const CalendarPage()),
            routes: [
              GoRoute(
                path: AppRoutes.add,
                pageBuilder: (context, state) =>
                    _customTransition(state, const AddServicesPage()),
              ),
              GoRoute(
                path: ':serviceId',
                pageBuilder: (context, state) => _customTransition(
                    state, ServiceDetailsPage(service: state.extra as Service)),
              ),
            ]),
        GoRoute(
          path: AppRoutes.calculator,
          builder: (context, state) => Container(
            color: Colors.blue,
          ),
        ),
        GoRoute(
          path: AppRoutes.profile,
          builder: (context, state) => Container(
            color: Colors.red,
          ),
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
