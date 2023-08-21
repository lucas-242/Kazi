import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kazi/app/core/routes/app_router.dart';
import 'package:kazi/app/features/service_types/service_types.dart';
import 'package:kazi/app/features/services/services.dart';
import 'package:kazi/app/services/services_service/services_service.dart';

import '/injector_container.dart';
import 'app_cubit.dart';
import 'core/l10n/generated/l10n.dart';
import 'core/themes/settings/theme_settings.dart';
import 'features/home/cubit/home_cubit.dart';
import 'repositories/service_type_repository/service_type_repository.dart';
import 'repositories/services_repository/services_repository.dart';
import 'services/auth_service/auth_service.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
          create: (_) => AppCubit(serviceLocator.get<AuthService>()),
        ),
        BlocProvider<HomeCubit>(
          create: (_) => HomeCubit(
            serviceLocator.get<ServicesRepository>(),
            serviceLocator.get<ServicesService>(),
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
            serviceLocator.get<ServicesService>(),
          ),
        ),
        BlocProvider<ServiceTypesCubit>(
          create: (context) => ServiceTypesCubit(
            serviceLocator.get<ServiceTypeRepository>(),
            serviceLocator.get<AuthService>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'Kazi',
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
