import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

import 'core/routes/app_routes.dart';
import 'views/login/login.dart';
import 'views/splash/pages/splash_page.dart';

import 'shared/themes/themes.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return ThemeProvider(
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
                home: const SplashPage(),
                routes: {AppRoutes.login: (context) => const LoginPage()},
              );
            }),
          ),
        );
      },
    );
  }
}
