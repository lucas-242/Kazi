import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_services/app/shared/routes/router.dart';
import 'package:my_services/app/views/services/services.dart';

import 'shared/themes/settings/theme_settings.dart';
import 'shared/widgets/custom_app_bar/cubit/custom_app_bar_cubit.dart';
import '/injector_container.dart';
import 'repositories/service_type_repository/service_type_repository.dart';
import 'services/auth_service/auth_service.dart';
import 'services/time_service/time_service.dart';
import 'views/home/cubit/home_cubit.dart';
import 'views/settings/settings.dart';
import 'app_cubit.dart';
import 'repositories/services_repository/services_repository.dart';
import 'shared/l10n/generated/l10n.dart';

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
            create: (_) => AppCubit(injector.get<AuthService>())),
        BlocProvider<CustomAppBarCubit>(
            create: (_) => CustomAppBarCubit(injector.get<AuthService>())),
        BlocProvider<SettingsCubit>(
          create: (_) => SettingsCubit(
            injector.get<ServiceTypeRepository>(),
            injector.get<ServicesRepository>(),
            injector.get<AuthService>(),
          ),
        ),
        BlocProvider<HomeCubit>(
          create: (_) => HomeCubit(
            injector.get<ServicesRepository>(),
            injector.get<ServiceTypeRepository>(),
            injector.get<AuthService>(),
          ),
        ),
        BlocProvider<AddServicesCubit>(
          create: (_) => AddServicesCubit(
            injector.get<ServicesRepository>(),
            injector.get<ServiceTypeRepository>(),
            injector.get<AuthService>(),
          ),
        ),
        BlocProvider<CalendarCubit>(
          create: (_) => CalendarCubit(
            injector.get<ServicesRepository>(),
            injector.get<ServiceTypeRepository>(),
            injector.get<AuthService>(),
            injector.get<TimeService>(),
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
        routerConfig: router,
      ),
    );
  }
}
