import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kazi/app_shell.dart';
import 'package:kazi/core/components/reset_password/pages/reset_password_page.dart';
import 'package:kazi/core/routes/app_routes.dart';
import 'package:kazi/presenter/home/home.dart';
import 'package:kazi/presenter/initial/intial.dart';
import 'package:kazi/presenter/login/login.dart';
import 'package:kazi/presenter/profile/profile.dart';
import 'package:kazi/presenter/services/services.dart';
import 'package:kazi_core/kazi_core.dart';
import 'package:kazi_design_system/kazi_design_system.dart';

abstract class RoutesConfig {
  static final router = GoRouter(
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
    builder: (context, state, child) => AppShell(child: child),
    routes: [
      GoRoute(
        path: AppRoutes.home,
        pageBuilder: (context, state) => _customTransition(
          state,
          // HomePage(showOnboarding: AppRouter.showOnboarding),
          const HomePage(),
        ),
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
          GoRoute(
            path: AppRoutes.add,
            pageBuilder: (context, state) {
              final params = state.extra as RouteParams;
              return _customTransition(
                state,
                ServiceFormPage(service: params.service),
              );
            },
          ),
          GoRoute(
            path: ':serviceId',
            pageBuilder: (context, state) => _customTransition(
              state,
              ServiceDetailsPage(
                service: (state.extra as RouteParams).service!,
              ),
            ),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const ProfilePage(),
        routes: [
          GoRoute(
            path: AppRoutes.resetPassword,
            pageBuilder: (context, state) => _customTransition(
              state,
              const ResetPasswordPage(),
            ),
          ),
        ],
      ),
    ],
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
