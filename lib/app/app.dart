import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kazi/app/core/routes/routes.dart';
import 'package:kazi/app/features/services/services.dart';

import 'app_cubit.dart';
import 'core/l10n/generated/l10n.dart';
import 'core/themes/settings/theme_settings.dart';
import 'features/home/cubit/home_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(create: (_) => AppCubit()),
        BlocProvider<HomeCubit>(create: (_) => HomeCubit()),
        BlocProvider<ServiceFormCubit>(create: (_) => ServiceFormCubit()),
        BlocProvider<ServiceLandingCubit>(create: (_) => ServiceLandingCubit()),
        BlocProvider<ServiceTypesCubit>(
          create: (context) => ServiceTypesCubit(),
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
        routerConfig: AppRouterConfig.router,
      ),
    );
  }
}
