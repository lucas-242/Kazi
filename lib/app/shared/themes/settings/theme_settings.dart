import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    final textTheme = GoogleFonts.outfitTextTheme();

    return ThemeData.light().copyWith(
      pageTransitionsTheme: pageTransitionsTheme,
      colorScheme: colors,
      appBarTheme: _appBarTheme(colors),
      cardTheme: _cardTheme(),
      listTileTheme: _listTileTheme(colors),
      bottomAppBarTheme: _bottomAppBarTheme(colors),
      bottomNavigationBarTheme: _bottomNavigationBarTheme(colors),
      bottomSheetTheme: _bottomSheetTheme(colors),
      floatingActionButtonTheme: _floatingActionButtonTheme(colors),
      dividerTheme: _dividerTheme(colors),
      navigationRailTheme: _navigationRailTheme(colors),
      tabBarTheme: _tabBarTheme(colors),
      drawerTheme: _drawerTheme(colors),
      inputDecorationTheme: _inputDecorationTheme(colors),
      textTheme: textTheme,
      scaffoldBackgroundColor: colors.background,
      useMaterial3: false,
    );
  }

  static ThemeData dark() {
    final colors = _getColorScheme(Brightness.dark);
    final textTheme = GoogleFonts.outfitTextTheme();

    return ThemeData.dark().copyWith(
      pageTransitionsTheme: pageTransitionsTheme,
      colorScheme: colors,
      appBarTheme: _appBarTheme(colors),
      cardTheme: _cardTheme(),
      listTileTheme: _listTileTheme(colors),
      bottomAppBarTheme: _bottomAppBarTheme(colors),
      bottomNavigationBarTheme: _bottomNavigationBarTheme(colors),
      bottomSheetTheme: _bottomSheetTheme(colors),
      floatingActionButtonTheme: _floatingActionButtonTheme(colors),
      dividerTheme: _dividerTheme(colors),
      navigationRailTheme: _navigationRailTheme(colors),
      tabBarTheme: _tabBarTheme(colors),
      drawerTheme: _drawerTheme(colors),
      inputDecorationTheme: _inputDecorationTheme(colors),
      textTheme: textTheme,
      scaffoldBackgroundColor: colors.background,
      useMaterial3: false,
    );
  }

  static ColorScheme _getColorScheme(Brightness brightness) {
    return ColorScheme.fromSeed(
      brightness: brightness,
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      background: AppColors.background,
      surface: AppColors.white,
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
      color: colors.surface,
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

  static BottomSheetThemeData _bottomSheetTheme(ColorScheme colors) {
    return BottomSheetThemeData(
      backgroundColor: colors.surface,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
    );
  }

  static FloatingActionButtonThemeData _floatingActionButtonTheme(
      ColorScheme colors) {
    return FloatingActionButtonThemeData(
      elevation: 0,
      highlightElevation: 0,
      backgroundColor: colors.primary,
      foregroundColor: colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }

  static DividerThemeData _dividerTheme(ColorScheme colors) {
    return const DividerThemeData(
      color: AppColors.lightGrey,
      indent: 0,
      endIndent: 0,
      space: 0,
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

  static InputDecorationTheme _inputDecorationTheme(ColorScheme colors) {
    return InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: colors.onSurface),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: colors.onSurface),
      ),
    );
  }
}
