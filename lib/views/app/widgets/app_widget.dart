import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/routes/app_routes.dart';
import '../../../shared/themes/themes.dart';
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
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<AppViewModel>(create: (_) => AppViewModel()),
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
                    AppRoutes.app: (context) => AppScaffold(),
                    AppRoutes.login: (context) => const LoginPage(),
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
