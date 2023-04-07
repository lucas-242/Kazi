import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_services/app/shared/routes/router.dart';
import 'package:my_services/app/views/services/services.dart';

import '/injector_container.dart';
import 'app_cubit.dart';
import 'repositories/service_type_repository/service_type_repository.dart';
import 'repositories/services_repository/services_repository.dart';
import 'services/auth_service/auth_service.dart';
import 'services/time_service/time_service.dart';
import 'shared/l10n/generated/l10n.dart';
import 'shared/themes/settings/theme_settings.dart';
import 'views/home/cubit/home_cubit.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override

  //TODO: Check if blocs need to be here globally
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
          create: (_) => AppCubit(serviceLocator.get<AuthService>()),
        ),
        BlocProvider<HomeCubit>(
          create: (_) => HomeCubit(
            serviceLocator.get<ServicesRepository>(),
            serviceLocator.get<ServiceTypeRepository>(),
            serviceLocator.get<AuthService>(),
            serviceLocator.get<TimeService>(),
          ),
        ),
        BlocProvider<ServiceFormCubit>(
          create: (_) => ServiceFormCubit(
            serviceLocator.get<ServicesRepository>(),
            serviceLocator.get<ServiceTypeRepository>(),
            serviceLocator.get<AuthService>(),
          ),
        ),
        BlocProvider<ServiceLandingCubit>(
          create: (_) => ServiceLandingCubit(
            serviceLocator.get<ServicesRepository>(),
            serviceLocator.get<ServiceTypeRepository>(),
            serviceLocator.get<AuthService>(),
            serviceLocator.get<TimeService>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'Korbi',
        debugShowCheckedModeBanner: false,
        theme: ThemeSettings.light(),
        darkTheme: ThemeSettings.dark(),
        themeMode: ThemeMode.light,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.delegate.supportedLocales,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
