import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kazi/app/app_shell.dart';
import 'package:kazi/app/core/routes/app_routes.dart';
import 'package:kazi/app/core/widgets/layout/layout.dart';
import 'package:kazi/app/features/home/home.dart';
import 'package:kazi/app/features/initial/intial.dart';
import 'package:kazi/app/features/login/login.dart';
import 'package:kazi/app/features/profile/profile.dart';
import 'package:kazi/app/features/services/services.dart';
import 'package:kazi/app/models/route_params.dart';

import 'app_pages.dart';

abstract class AppRouterConfig {
  static GoRouter init() => GoRouter(
        initialLocation: AppRoutes.initial,
        routes: [
          ..._initialRoutes,
          _appShellRoutes,
          _loginShellRoutes,
        ],
      );

  static final _initialRoutes = [
    GoRoute(
      path: AppRoutes.initial,
      pageBuilder: (context, state) =>
          _customTransition(state, const SplashPage()),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      pageBuilder: (context, state) =>
          _customTransition(state, const OnboardingPage()),
    ),
  ];

  static final _appShellRoutes = ShellRoute(
    builder: (context, state, child) => AppShell(
      params: state.extra != null
          ? (state.extra as RouteParams)
          : const RouteParams(lastPage: AppPages.home),
      child: child,
    ),
    routes: [
      GoRoute(
        path: AppRoutes.home,
        pageBuilder: (context, state) => _customTransition(
          state,
          // HomePage(showOnboarding: AppRouter.showOnboarding),
          const HomePage(),
        ),
        routes: [_addService, _serviceDetails],
      ),
      GoRoute(
        path: AppRoutes.services,
        pageBuilder: (context, state) => _customTransition(
          state,
          const ServiceLandingPage(),
          // ServiceLandingPage(showOnboarding: AppRouter.showOnboarding),
        ),
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
        path: AppRoutes.profile,
        builder: (context, state) => const ProfilePage(),
        routes: [
          _addService,
          GoRoute(
            path: AppRoutes.resetPassword,
            pageBuilder: (context, state) => _customTransition(
              state,
              ResetPasswordPage(
                  resetPasswordToken: state.uri.queryParameters['token']),
            ),
          ),
        ],
      ),
    ],
  );

  static final _addService = GoRoute(
    path: AppRoutes.add,
    pageBuilder: (context, state) => _customTransition(
      state,
      ServiceFormPage(service: (state.extra as RouteParams).service),
    ),
  );

  static final _serviceDetails = GoRoute(
    path: ':serviceId',
    pageBuilder: (context, state) => _customTransition(
      state,
      ServiceDetailsPage(
        service: (state.extra as RouteParams).service!,
      ),
    ),
  );

  static final _loginShellRoutes = ShellRoute(
    builder: (context, state, child) => LoginShell(child: child),
    routes: [
      GoRoute(
        path: AppRoutes.signIn,
        pageBuilder: (context, state) =>
            _customTransition(state, const SignInPage()),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        pageBuilder: (context, state) =>
            _customTransition(state, const ForgotPasswordPage()),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        pageBuilder: (context, state) =>
            _customTransition(state, const SignUpPage()),
      ),
      GoRoute(
        path: '/${AppRoutes.resetPassword}',
        pageBuilder: (context, state) => _customTransition(
          state,
          ResetPasswordPage(
              resetPasswordToken: state.uri.queryParameters['token']),
        ),
      ),
      GoRoute(
        path: AppRoutes.privacyPolicy,
        pageBuilder: (context, state) =>
            _customTransition(state, const PrivacyPolicyPage()),
        routes: [
          GoRoute(
            path: AppRoutes.webView,
            pageBuilder: _navigateToPrivacyPoliceWebView,
          )
        ],
      )
    ],
  );

  static Page<dynamic> _navigateToPrivacyPoliceWebView(
      BuildContext context, GoRouterState state) {
    try {
      var title = 'Error';
      var url = '';
      if (state.extra != null) {
        final params = (state.extra as RouteParams);
        title = params.webViewParams!.title;
        url = params.webViewParams!.url;
      }
      return _customTransition(state, WebView(title: title, url: url));
    } catch (error) {
      return _customTransition(state, const PrivacyPolicyPage());
    }
  }

  static CustomTransitionPage<Widget> _customTransition(
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
}
