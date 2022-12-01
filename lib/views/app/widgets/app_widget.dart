import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_services/injector_container.dart';
import 'package:my_services/repositories/service_type_repository/service_type_repository.dart';
import 'package:my_services/services/auth_service/auth_service.dart';
import 'package:my_services/views/calendar/calendar.dart';
import 'package:my_services/views/home/cubit/home_cubit.dart';
import 'package:my_services/views/settings/settings.dart';

import '../../../core/routes/app_routes.dart';
import '../../../repositories/service_provided_repository/service_provided_repository.dart';
import '../../../shared/themes/themes.dart';
import '../../add_services/cubit/add_services_cubit.dart';
import '../../add_services/pages/add_services_page.dart';
import '../../login/login.dart';
import '../../splash/splash.dart';
import '../app.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AppCubit>(create: (_) => AppCubit()),
            BlocProvider<SettingsCubit>(
              create: (_) => SettingsCubit(
                locator.get<ServiceTypeRepository>(),
                locator.get<ServiceProvidedRepository>(),
                locator.get<AuthService>(),
              ),
            ),
            BlocProvider<HomeCubit>(
              create: (_) => HomeCubit(
                locator.get<ServiceProvidedRepository>(),
                locator.get<ServiceTypeRepository>(),
                locator.get<AuthService>(),
              ),
              lazy: true,
            ),
            BlocProvider<AddServicesCubit>(
              create: (_) => AddServicesCubit(
                locator.get<ServiceProvidedRepository>(),
                locator.get<ServiceTypeRepository>(),
                locator.get<AuthService>(),
              ),
              lazy: true,
            ),
            BlocProvider<CalendarCubit>(
              create: (_) => CalendarCubit(
                locator.get<ServiceProvidedRepository>(),
                locator.get<ServiceTypeRepository>(),
                locator.get<AuthService>(),
              ),
              lazy: true,
            ),
          ],
          child: ThemeProvider(
            lightDynamic: lightDynamic,
            darkDynamic: darkDynamic,
            settings: defaultThemeSettings,
            child: Builder(
              builder: ((context) {
                var appTheme = ThemeProvider.of(context);
                return MaterialApp(
                  title: 'My Services',
                  debugShowCheckedModeBanner: false,
                  theme: appTheme.light(defaultThemeSettings.sourceColor),
                  darkTheme: appTheme.dark(defaultThemeSettings.sourceColor),
                  themeMode: defaultThemeSettings.themeMode,
                  initialRoute: AppRoutes.splash,
                  routes: {
                    AppRoutes.splash: (context) => const SplashPage(),
                    AppRoutes.app: (context) => const AppScaffold(),
                    AppRoutes.login: (context) => const LoginPage(),
                    AppRoutes.addServiceType: (context) =>
                        const AddServiceTypePage(),
                    AppRoutes.addServiceProvided: (context) =>
                        const AddServicesPage(),
                  },
                );
              }),
            ),
          ),
        );
      },
    );
  }
}