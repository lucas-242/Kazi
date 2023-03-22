import 'package:flutter/material.dart';

import '../animations/no_animation_page_transition.dart';
import 'app_colors.dart';

abstract class ThemeSettings {
  static const pageTransitionsTheme = PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.fuchsia: NoAnimationPageTransitionsBuilder(),
      TargetPlatform.linux: NoAnimationPageTransitionsBuilder(),
      TargetPlatform.macOS: NoAnimationPageTransitionsBuilder(),
      TargetPlatform.windows: NoAnimationPageTransitionsBuilder(),
    },
  );

  static ShapeBorder get defaultShape => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      );

  static ThemeData light() {
    final colors = _getColorScheme(Brightness.light);
    return ThemeData.light().copyWith(
      pageTransitionsTheme: pageTransitionsTheme,
      colorScheme: colors,
      appBarTheme: _appBarTheme(colors),
      cardTheme: _cardTheme(),
      listTileTheme: _listTileTheme(colors),
      bottomAppBarTheme: _bottomAppBarTheme(colors),
      bottomNavigationBarTheme: _bottomNavigationBarTheme(colors),
      navigationRailTheme: _navigationRailTheme(colors),
      tabBarTheme: _tabBarTheme(colors),
      drawerTheme: _drawerTheme(colors),
      inputDecorationTheme: _inputDecorationTheme(),
      scaffoldBackgroundColor: colors.background,
      useMaterial3: false,
    );
  }

  static ThemeData dark() {
    final colors = _getColorScheme(Brightness.dark);
    return ThemeData.dark().copyWith(
      pageTransitionsTheme: pageTransitionsTheme,
      colorScheme: colors,
      appBarTheme: _appBarTheme(colors),
      cardTheme: _cardTheme(),
      listTileTheme: _listTileTheme(colors),
      bottomAppBarTheme: _bottomAppBarTheme(colors),
      bottomNavigationBarTheme: _bottomNavigationBarTheme(colors),
      navigationRailTheme: _navigationRailTheme(colors),
      tabBarTheme: _tabBarTheme(colors),
      drawerTheme: _drawerTheme(colors),
      inputDecorationTheme: _inputDecorationTheme(),
      scaffoldBackgroundColor: colors.background,
      useMaterial3: true,
    );
  }

  static ColorScheme _getColorScheme(Brightness brightness) {
    return ColorScheme.fromSeed(
      brightness: brightness,
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      background: AppColors.background,
      onSurface: AppColors.black,
    );
  }

  static CardTheme _cardTheme() {
    return CardTheme(
      elevation: 0,
      shape: defaultShape,
      margin: const EdgeInsets.only(bottom: 10),
      clipBehavior: Clip.antiAlias,
    );
  }

  static ListTileThemeData _listTileTheme(ColorScheme colors) {
    return ListTileThemeData(
      shape: defaultShape,
      selectedColor: colors.secondary,
    );
  }

  static AppBarTheme _appBarTheme(ColorScheme colors) {
    return AppBarTheme(
      elevation: 0,
      backgroundColor: colors.primary,
      // foregroundColor: colors.onSurface,
    );
  }

  static TabBarTheme _tabBarTheme(ColorScheme colors) {
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

  static BottomAppBarTheme _bottomAppBarTheme(ColorScheme colors) {
    return BottomAppBarTheme(
      color: colors.background,
      elevation: 0,
      height: 75,
    );
  }

  static BottomNavigationBarThemeData _bottomNavigationBarTheme(
      ColorScheme colors) {
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

  static NavigationRailThemeData _navigationRailTheme(ColorScheme colors) {
    return const NavigationRailThemeData();
  }

  static DrawerThemeData _drawerTheme(ColorScheme colors) {
    return DrawerThemeData(
      backgroundColor: colors.surface,
    );
  }

  static InputDecorationTheme _inputDecorationTheme() {
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
}
