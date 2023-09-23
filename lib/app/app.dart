import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kazi/app/core/routes/app_router.dart';
import 'package:kazi/app/features/services/service_types/cubit/service_types_cubit.dart';
import 'package:kazi/app/features/services/services_module.dart';
import 'package:kazi/app/services/services_service/services_service.dart';

import '/injector_container.dart';
import 'app_cubit.dart';
import 'core/auth/auth.dart';
import 'core/l10n/generated/l10n.dart';
import 'core/themes/settings/theme_settings.dart';
import 'data/repositories/service_type_repository/service_type_repository.dart';
import 'data/repositories/services_repository/services_repository.dart';
import 'features/home/cubit/home_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(AppRouter.splash);

    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
          create: (_) => AppCubit(serviceLocator.get<Auth>()),
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
            serviceLocator.get<Auth>(),
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
            serviceLocator.get<Auth>(),
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
        routerConfig: Modular.routerConfig,
      ),
    );
  }
}
