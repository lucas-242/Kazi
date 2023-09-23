import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kazi/app/app_shell.dart';
import 'package:kazi/app/core/constants/app_keys.dart';
import 'package:kazi/app/core/widgets/layout/layout.dart';
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
  static String loginForgotPassword = '$login/$forgotPassword';
  static String loginPrivacyPolicy = '$login/$privacyPolicy';
  static String loginPrivacyPolicyWebView = '$login/$privacyPolicy/$webView';
  static String loginResetPassword = '$login/$resetPassword';
  static String loginSignIn = '$login/$signIn';
  static String loginSignUp = '$login/$signUp';
  static String services = '/services';
  static String addServices = '$services/$add';
  static String servicesType = '$services/$type';
  static String addServiceType = '$servicesType/$add';
  static String calculator = '/calculator';
  static String profile = '/profile';
  static String profileResetPassword = '$profile/$resetPassword';

  static String add = 'add';
  static String type = 'type';
  static String privacyPolicy = 'privacy-policy';
  static String signIn = 'sign-in';
  static String signUp = 'sign-up';
  static String forgotPassword = 'forgot-password';
  static String resetPassword = 'reset-password';
  static String webView = 'web-view';
}

final mainNavigatorKey = GlobalKey<NavigatorState>();
final loginNavigatorKey = GlobalKey<NavigatorState>();
final bottomNavigatorKey = GlobalKey<NavigatorState>();

final _router = GoRouter(
  initialLocation: AppRouter.initial,
  navigatorKey: mainNavigatorKey,
  routes: [
    GoRoute(
      path: AppRouter.initial,
      pageBuilder: (context, state) =>
          _customTransition(state, const SplashPage()),
      routes: [
        ShellRoute(
          navigatorKey: loginNavigatorKey,
          builder: (context, state, child) => LoginScaffold(child: child),
          routes: [
            _signIn,
            // _signUp,
            // _forgotPassword,
            // _privacyPolicy,
            // _resetPassword,
          ],
        ),
      ],
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
    // GoRoute(
    //   path: AppRouter.login,
    //   redirect: (context, state) => AppRouter.loginSignIn,
    //   routes: [
    //     ShellRoute(
    //       navigatorKey: loginNavigatorKey,
    //       builder: (context, state, child) => LoginScaffold(child: child),
    //       routes: [
    //         _signIn,
    //         // _signUp,
    //         // _forgotPassword,
    //         // _privacyPolicy,
    //         // _resetPassword,
    //       ],
    //     ),
    //   ],
    // ),
    ShellRoute(
      navigatorKey: bottomNavigatorKey,
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
          routes: [_addService, _resetPassword],
        ),
      ],
    ),
  ],
);

final _privacyPolicy = GoRoute(
  path: AppRouter.loginPrivacyPolicy,
  pageBuilder: (context, state) =>
      _customTransition(state, const PrivacyPolicyPage()),
  routes: [
    GoRoute(
      path: AppRouter.webView,
      pageBuilder: _navigateToPrivacyPoliceWebView,
    )
  ],
);

Page<dynamic> _navigateToPrivacyPoliceWebView(
    BuildContext context, GoRouterState state) {
  try {
    var title = 'Error';
    var url = '';
    if (state.extra != null) {
      final params = (state.extra as RouteParams);
      title = params.objects!['title'];
      url = params.objects!['url'];
    }
    return _customTransition(state, WebView(title: title, url: url));
  } catch (error) {
    return _customTransition(state, const PrivacyPolicyPage());
  }
}

final _resetPassword = GoRoute(
  path: AppRouter.resetPassword,
  pageBuilder: (context, state) => _customTransition(
    state,
    ResetPasswordPage(resetPasswordToken: state.queryParameters['token']),
  ),
);

final _signIn = GoRoute(
  path: AppRouter.signIn,
  pageBuilder: (context, state) => _customTransition(state, const SignInPage()),
);

final _forgotPassword = GoRoute(
  path: AppRouter.loginForgotPassword,
  pageBuilder: (context, state) =>
      _customTransition(state, const ForgotPasswordPage()),
);

final _signUp = GoRoute(
  path: AppRouter.loginSignUp,
  pageBuilder: (context, state) => _customTransition(state, const SignUpPage()),
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
