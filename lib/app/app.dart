import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kazi/app/core/routes/routes.dart';
import 'package:kazi/app/features/services/services.dart';
import 'package:kazi/app/services/services_service/services_service.dart';

import '../service_locator.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
          create: (_) => AppCubit(),
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
            ServiceLocator.get<Auth>(),
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
            ServiceLocator.get<Auth>(),
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
        routerConfig: AppRouterConfig.init(),
      ),
    );
  }
}
