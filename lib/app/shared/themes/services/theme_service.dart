import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:material_color_utilities/material_color_utilities.dart';

import '../animations/no_animation_page_transition.dart';
import '../models/custom_color.dart';
import '../models/theme_settings.dart';
import '../settings/themes_definitions.dart';

class ThemeService extends InheritedWidget {
  const ThemeService({
    Key? key,
    required this.settings,
    required Widget child,
  }) : super(key: key, child: child);

  final ThemeSettings settings;

  final pageTransitionsTheme = const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.fuchsia: NoAnimationPageTransitionsBuilder(),
      TargetPlatform.linux: NoAnimationPageTransitionsBuilder(),
      TargetPlatform.macOS: NoAnimationPageTransitionsBuilder(),
      TargetPlatform.windows: NoAnimationPageTransitionsBuilder(),
    },
  );

  ShapeBorder get shapeMedium => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      );

  ThemeData light([Color? targetColor]) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _colors = colors(Brightness.light, targetColor);
    return ThemeData.light().copyWith(
      pageTransitionsTheme: pageTransitionsTheme,
      colorScheme: _colors,
      appBarTheme: appBarTheme(_colors),
      cardTheme: cardTheme(),
      listTileTheme: listTileTheme(_colors),
      bottomAppBarTheme: bottomAppBarTheme(_colors),
      bottomNavigationBarTheme: bottomNavigationBarTheme(_colors),
      navigationRailTheme: navigationRailTheme(_colors),
      tabBarTheme: tabBarTheme(_colors),
      drawerTheme: drawerTheme(_colors),
      inputDecorationTheme: inputDecorationTheme(),
      scaffoldBackgroundColor: _colors.background,
      useMaterial3: false,
    );
  }

  ThemeData dark([Color? targetColor]) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _colors = colors(Brightness.dark, targetColor);
    return ThemeData.dark().copyWith(
      pageTransitionsTheme: pageTransitionsTheme,
      colorScheme: _colors,
      appBarTheme: appBarTheme(_colors),
      cardTheme: cardTheme(),
      listTileTheme: listTileTheme(_colors),
      bottomAppBarTheme: bottomAppBarTheme(_colors),
      bottomNavigationBarTheme: bottomNavigationBarTheme(_colors),
      navigationRailTheme: navigationRailTheme(_colors),
      tabBarTheme: tabBarTheme(_colors),
      drawerTheme: drawerTheme(_colors),
      inputDecorationTheme: inputDecorationTheme(),
      scaffoldBackgroundColor: _colors.background,
      useMaterial3: true,
    );
  }

  ColorScheme colors(Brightness brightness, Color? targetColor) {
    final dynamicPrimary = brightness == Brightness.light
        ? lightThemeSettings.sourceColor
        : darkThemeSettings.sourceColor;
    return ColorScheme.fromSeed(
      seedColor: dynamicPrimary,
      // seedColor: dynamicPrimary ?? source(targetColor),
      brightness: brightness,
      primary: dynamicPrimary,
      background: settings.backgroundColor,
      onSurface: settings.textColor,
    );
  }

  Color source(Color? target) {
    Color source = settings.sourceColor;
    if (target != null) {
      source = blend(target);
    }
    return source;
  }

  Color blend(Color targetColor) {
    return Color(
        Blend.harmonize(targetColor.value, settings.sourceColor.value));
  }

  Color customizeColor(CustomColor custom) {
    if (custom.blend) {
      return blend(custom.color);
    } else {
      return custom.color;
    }
  }

  CardTheme cardTheme() {
    return CardTheme(
      elevation: 0,
      shape: shapeMedium,
      margin: const EdgeInsets.only(bottom: 10),
      clipBehavior: Clip.antiAlias,
    );
  }

  ListTileThemeData listTileTheme(ColorScheme colors) {
    return ListTileThemeData(
      shape: shapeMedium,
      selectedColor: colors.secondary,
    );
  }

  AppBarTheme appBarTheme(ColorScheme colors) {
    return AppBarTheme(
      elevation: 0,
      backgroundColor: colors.primary,
      // foregroundColor: colors.onSurface,
    );
  }

  TabBarTheme tabBarTheme(ColorScheme colors) {
    return TabBarTheme(
      labelColor: colors.secondary,
      unselectedLabelColor: colors.onSurfaceVariant,
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colors.secondary,
            width: 2,
          ),
        ),
      ),
    );
  }

  BottomAppBarTheme bottomAppBarTheme(ColorScheme colors) {
    return BottomAppBarTheme(
      color: colors.background,
      elevation: 0,
      height: 75,
    );
  }

  BottomNavigationBarThemeData bottomNavigationBarTheme(ColorScheme colors) {
    return BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: colors.background,
      selectedItemColor: colors.primary,
      unselectedItemColor: colors.onPrimaryContainer,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      elevation: 0,
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
    );
  }

  NavigationRailThemeData navigationRailTheme(ColorScheme colors) {
    return const NavigationRailThemeData();
  }

  DrawerThemeData drawerTheme(ColorScheme colors) {
    return DrawerThemeData(
      backgroundColor: colors.surface,
    );
  }

  InputDecorationTheme inputDecorationTheme() {
    return const InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: EdgeInsets.symmetric(horizontal: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
      ),
    );
  }

  ThemeData theme(BuildContext context,
      [Color? targetColor, Brightness? brightness]) {
    brightness ?? MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.light
        ? light(targetColor)
        : dark(targetColor);
  }

  static ThemeService of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeService>()!;
  }

  @override
  bool updateShouldNotify(covariant ThemeService oldWidget) {
    return oldWidget.settings != settings;
  }
}
