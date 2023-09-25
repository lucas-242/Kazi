import 'package:flutter_modular/flutter_modular.dart';
import 'package:kazi/app/core/routes/app_router.dart';
import 'package:kazi/app/features/login/login_module.dart';

export 'forgot_password/pages/forgot_password_page.dart';
export 'pages/privacy_policy_page.dart';
export 'pages/reset_password_page.dart';
export 'sign_in/pages/sign_in_page.dart';
export 'sign_up/pages/sign_up_page.dart';
export 'widgets/login_shell.dart';
export 'widgets/login_sign_in_changer.dart';
export 'widgets/login_terms_policies.dart';
export 'widgets/text_button_link.dart';

class LoginModule extends Module {
  @override
  void routes(r) {
    r.child(
      AppRouter.initial,
      child: (context) => const LoginShell(),
      children: [
        ChildRoute(AppRouter.signIn, child: (context) => const SignInPage()),
        ChildRoute(AppRouter.signUp, child: (context) => const SignUpPage()),
        ChildRoute(AppRouter.resetPassword,
            child: (context) => const ResetPasswordPage()),
        ChildRoute(
          AppRouter.forgotPassword,
          child: (context) => const ForgotPasswordPage(),
        ),
        ChildRoute(
          AppRouter.privacyPolicy,
          child: (context) => const PrivacyPolicyPage(),
        ),
      ],
    );
  }
}
