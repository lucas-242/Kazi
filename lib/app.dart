import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kazi/core/routes/routes.dart';
import 'package:kazi/domain/repositories/service_type_repository.dart';
import 'package:kazi/domain/repositories/services_repository.dart';
import 'package:kazi/domain/services/auth_service.dart';
import 'package:kazi/domain/services/services_service.dart';
import 'package:kazi/presenter/services/services.dart';
import 'package:kazi/service_locator.dart';
import 'package:kazi_design_system/themes/themes.dart';

import 'app_cubit.dart';
import 'core/l10n/generated/l10n.dart';
import 'presenter/home/cubit/home_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
          create: (_) => AppCubit(ServiceLocator.get<AuthService>()),
        ),
        BlocProvider<HomeCubit>(
          create: (_) => HomeCubit(
            ServiceLocator.get<ServicesRepository>(),
            ServiceLocator.get<ServicesService>(),
          ),
        ),
        BlocProvider<ServiceFormCubit>(
          create: (_) => ServiceFormCubit(
            ServiceLocator.get<ServicesRepository>(),
            ServiceLocator.get<ServiceTypeRepository>(),
            ServiceLocator.get<AuthService>(),
          ),
        ),
        BlocProvider<ServiceLandingCubit>(
          create: (_) => ServiceLandingCubit(
            ServiceLocator.get<ServicesRepository>(),
            ServiceLocator.get<ServicesService>(),
          ),
        ),
        BlocProvider<ServiceTypesCubit>(
          create: (context) => ServiceTypesCubit(
            ServiceLocator.get<ServiceTypeRepository>(),
            ServiceLocator.get<AuthService>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'Kazi',
        debugShowCheckedModeBanner: false,
        theme: KaziThemeSettings.light(),
        darkTheme: KaziThemeSettings.dark(),
        themeMode: ThemeMode.light,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.delegate.supportedLocales,
        routerConfig: RoutesConfig.router,
      ),
    );
  }
}
