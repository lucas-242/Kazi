import 'package:flutter_modular/flutter_modular.dart';
import 'package:kazi/app/app_shell.dart';
import 'package:kazi/app/core/extensions/extensions.dart';
import 'package:kazi/app/core/routes/app_router.dart';
import 'package:kazi/app/features/home/home_module.dart';
import 'package:kazi/app/features/initial/intial.dart';
import 'package:kazi/app/features/login/login_module.dart';
import 'package:kazi/app/features/profile/profile_module.dart';
import 'package:kazi/app/models/route_params.dart';
import 'package:kazi/app/models/service.dart';

class AppModule extends Module {
  @override
  void routes(r) {
    r.child(AppRouter.splash, child: (_) => const SplashPage());
    r.child(AppRouter.onboarding, child: (_) => const OnboardingPage());
    r.module(AppRouter.login, module: LoginModule());
    r.child(
      AppRouter.initial,
      //TODO: Validate Params in appShell
      //TODO: Remove GetIt binding services in the modules
      child: (_) => AppShell(
        params: RouteParams(
          lastPage: AppPage.forgotPassword,
          service: Service.toCreate(employeeId: 1),
        ),
      ),
      children: [
        ModuleRoute(AppRouter.home, module: HomeModule()),
        // ModuleRoute(AppRouter.services, module: ServicesModule()),
        ModuleRoute(AppRouter.profile, module: ProfileModule()),
      ],
    );
  }
}
