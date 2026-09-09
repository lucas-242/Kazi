import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kazi_core/shared/themes/themes.dart';

/// The Kazi [ThemeData], built once per brightness.
///
/// Both themes come from the same [_build], so light and dark can never drift
/// apart structurally — only the [KaziColors] passed in differs. No component
/// theme names a hex; everything is a role, which is what makes dark mode a
/// configuration rather than a rewrite.
///
/// This builder is the one place allowed to speak Material: it reads the raw
/// [ColorScheme] because that is what Flutter component themes take. Screens
/// read `context.colors` instead.
///
/// The design is flat by brandbook rule ("sem gradientes"): elevations are 0
/// and surfaces separate through the tonal ladder plus a 1px outline. Shadows
/// are near-invisible on graphite, so they cannot be the separator in dark.
abstract class KaziThemeSettings {
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

  // Built once. Both apps call light() inside build(), so constructing the
  // theme there would rebuild every component theme and invalidate the whole
  // InheritedTheme subtree on each frame.
  static final ThemeData _light = _build(
    KaziColors.light.scheme,
    KaziColors.light,
  );

  static final ThemeData _dark = _build(
    KaziColors.dark.scheme,
    KaziColors.dark,
  );

  static ThemeData light() => _light;

  static ThemeData dark() => _dark;

  // The ThemeData constructor, not ThemeData.light().copyWith(...): copyWith
  // assigns verbatim, while the constructor is what derives the legacy colour
  // fields (canvasColor, cardColor, dividerColor...) from the ColorScheme and
  // merges the text theme against the brightness-appropriate typography.
  static ThemeData _build(ColorScheme colors, KaziColors kazi) =>
      ThemeData(
        colorScheme: colors,
        extensions: <ThemeExtension<dynamic>>[kazi],
        pageTransitionsTheme: pageTransitionsTheme,
        scaffoldBackgroundColor: colors.surface,
        dividerColor: colors.outlineVariant,
        // The coloured copy: the static styles are colourless so call sites
        // inherit from the theme, but ThemeData itself must carry colours.
        textTheme: KaziTextStyles.themed(colors),
        iconTheme: IconThemeData(color: colors.onSurface),
        appBarTheme: _appBarTheme(colors),
        cardTheme: _cardTheme(colors),
        listTileTheme: _listTileTheme(colors),
        bottomAppBarTheme: _bottomAppBarTheme(colors),
        bottomNavigationBarTheme: _bottomNavigationBarTheme(colors, kazi),
        bottomSheetTheme: _bottomSheetTheme(colors),
        floatingActionButtonTheme: _floatingActionButtonTheme(colors, kazi),
        outlinedButtonTheme: _outlinedButtonTheme(colors),
        filledButtonTheme: _filledButtonTheme(kazi),
        textButtonTheme: _textButtonTheme(kazi),
        dividerTheme: _dividerTheme(colors),
        navigationRailTheme: _navigationRailTheme(colors, kazi),
        tabBarTheme: _tabBarTheme(colors, kazi),
        drawerTheme: _drawerTheme(colors),
        inputDecorationTheme: _inputDecorationTheme(colors, kazi),
        dataTableTheme: _dataTableTheme(colors),
        chipTheme: _choiceChipTheme(colors),
        progressIndicatorTheme: _progressIndicatorTheme(colors),
        datePickerTheme: _datePickerTheme(colors, kazi),
        dialogTheme: _dialogTheme(colors),
        snackBarTheme: _snackBarTheme(colors),
      );

  static CardThemeData _cardTheme(ColorScheme colors) => CardThemeData(
        elevation: 0,
        color: colors.surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: KaziRadii.mdBorder,
          side: BorderSide(color: colors.outlineVariant),
        ),
        margin: const EdgeInsets.only(bottom: KaziInsets.sm),
        clipBehavior: Clip.antiAlias,
      );

  static ListTileThemeData _listTileTheme(ColorScheme colors) =>
      ListTileThemeData(
        iconColor: colors.onSurfaceVariant,
        textColor: colors.onSurface,
        selectedColor: colors.onSurface,
        selectedTileColor: colors.primaryContainer,
        shape: const RoundedRectangleBorder(
          borderRadius: KaziRadii.smBorder,
        ),
      );

  static AppBarTheme _appBarTheme(ColorScheme colors) => AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        foregroundColor: colors.onSurface,
        iconTheme: IconThemeData(color: colors.onSurface),
        actionsIconTheme: IconThemeData(color: colors.onSurface),
        // The colour must be set on the style itself: AppBar only applies
        // foregroundColor when it falls back to its own defaults, and it
        // installs titleTextStyle as a DefaultTextStyle by replacement rather
        // than by merge. A colourless style here renders black on both
        // brightnesses.
        titleTextStyle: KaziTextStyles.headlineLarge.copyWith(
          color: colors.onSurface,
        ),
      );

  static TabBarThemeData _tabBarTheme(
    ColorScheme colors,
    KaziColors kazi,
  ) =>
      TabBarThemeData(
        labelColor: kazi.brand.text,
        unselectedLabelColor: colors.onSurfaceVariant,
        dividerColor: colors.outlineVariant,
        indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: kazi.brand.text,
              width: 2,
            ),
          ),
        ),
      );

  static BottomAppBarThemeData _bottomAppBarTheme(ColorScheme colors) =>
      BottomAppBarThemeData(
        color: colors.surfaceContainer,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        height: KaziSizings.bottomAppBarHeight,
      );

  static BottomNavigationBarThemeData _bottomNavigationBarTheme(
    ColorScheme colors,
    KaziColors kazi,
  ) =>
      BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: colors.surfaceContainer,
        // brand.text, not scheme.primary: a yellow label on Névoa is 1.4:1.
        selectedItemColor: kazi.brand.text,
        unselectedItemColor: colors.onSurfaceVariant,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 0,
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      );

  static BottomSheetThemeData _bottomSheetTheme(ColorScheme colors) =>
      BottomSheetThemeData(
        backgroundColor: colors.surfaceContainerLow,
        modalBackgroundColor: colors.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
        dragHandleColor: colors.outlineVariant,
        elevation: 0,
        modalElevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: KaziRadii.xlTopBorder,
        ),
      );

  static FloatingActionButtonThemeData _floatingActionButtonTheme(
    ColorScheme colors,
    KaziColors kazi,
  ) =>
      FloatingActionButtonThemeData(
        // The one place yellow is allowed to be a fill: "amarelo em um único
        // ponto — a ação de registrar". The icon is graphite (12.4:1), never
        // the surface colour.
        backgroundColor: kazi.brand.fill,
        foregroundColor: kazi.brand.onFill,
        // Elevation is brightness-aware: a graphite shadow on a graphite page
        // is invisible, so dark leans on the yellow itself to separate.
        elevation: colors.brightness == Brightness.light ? 3 : 0,
        highlightElevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: KaziRadii.fullBorder,
        ),
      );

  static OutlinedButtonThemeData _outlinedButtonTheme(ColorScheme colors) =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.onSurface,
          side: BorderSide(color: colors.outline),
          shape: const RoundedRectangleBorder(
            borderRadius: KaziRadii.smBorder,
          ),
        ),
      );

  static FilledButtonThemeData _filledButtonTheme(KaziColors kazi) =>
      FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: kazi.brand.fill,
          foregroundColor: kazi.brand.onFill,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: KaziRadii.smBorder,
          ),
        ),
      );

  static TextButtonThemeData _textButtonTheme(KaziColors kazi) =>
      TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: kazi.brand.text),
      );

  static DividerThemeData _dividerTheme(ColorScheme colors) =>
      DividerThemeData(
        color: colors.outlineVariant,
        thickness: 1,
        indent: 0,
        endIndent: 0,
        space: 0,
      );

  static NavigationRailThemeData _navigationRailTheme(
    ColorScheme colors,
    KaziColors kazi,
  ) =>
      NavigationRailThemeData(
        backgroundColor: colors.surface,
        indicatorColor: colors.primaryContainer,
        selectedIconTheme: IconThemeData(color: kazi.brand.text),
        unselectedIconTheme: IconThemeData(color: colors.onSurfaceVariant),
        selectedLabelTextStyle: KaziTextStyles.titleSmall.copyWith(
          color: kazi.brand.text,
        ),
        unselectedLabelTextStyle: KaziTextStyles.bodySmall.copyWith(
          color: colors.onSurfaceVariant,
        ),
      );

  static DrawerThemeData _drawerTheme(ColorScheme colors) => DrawerThemeData(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      );

  static InputDecorationTheme _inputDecorationTheme(
    ColorScheme colors,
    KaziColors kazi,
  ) {
    const borderRadius = KaziRadii.xsBorder;

    OutlineInputBorder border(Color color, {double width = 1}) =>
        OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: color, width: width),
        );

    return InputDecorationTheme(
      labelStyle: KaziTextStyles.labelLarge.copyWith(
        color: colors.onSurfaceVariant,
      ),
      hintStyle: KaziTextStyles.labelLarge.copyWith(
        color: colors.onSurfaceVariant,
      ),
      errorStyle: KaziTextStyles.labelSmall.copyWith(color: colors.error),
      iconColor: colors.onSurfaceVariant,
      prefixIconColor: colors.onSurfaceVariant,
      suffixIconColor: colors.onSurfaceVariant,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      filled: true,
      fillColor: colors.surfaceContainerLowest,
      contentPadding: const EdgeInsets.symmetric(horizontal: KaziInsets.md),
      // Each state gets its own border. They used to be identical, which made
      // the error state invisible.
      enabledBorder: border(colors.outlineVariant),
      disabledBorder: border(colors.outlineVariant),
      focusedBorder: border(kazi.focusRing, width: 1.5),
      errorBorder: border(colors.error),
      focusedErrorBorder: border(colors.error, width: 1.5),
    );
  }

  static DataTableThemeData _dataTableTheme(ColorScheme colors) =>
      DataTableThemeData(
        headingRowHeight: KaziSizings.tableRowHeight,
        dataRowMaxHeight: KaziSizings.tableRowHeight,
        dataRowMinHeight: KaziSizings.tableRowMinHeight,
        horizontalMargin: KaziInsets.md,
        columnSpacing: KaziInsets.md,
        dividerThickness: 1,
        headingTextStyle: KaziTextStyles.titleSmall.copyWith(
          color: colors.onSurfaceVariant,
        ),
        // DataTable force-unwraps this style's colour for placeholder cells,
        // so it must never be null.
        dataTextStyle: KaziTextStyles.bodyMedium.copyWith(color: colors.onSurface),
      );

  static ChipThemeData _choiceChipTheme(ColorScheme colors) => ChipThemeData(
        showCheckmark: false,
        padding: const EdgeInsets.all(KaziInsets.sm),
        backgroundColor: colors.surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        selectedColor: colors.primaryContainer,
        side: BorderSide(color: colors.outlineVariant),
        shape: const StadiumBorder(),
        // Chip uses these styles raw, so both need an explicit colour.
        labelStyle: KaziTextStyles.bodyMedium.copyWith(color: colors.onSurface),
        secondaryLabelStyle: KaziTextStyles.titleSmall.copyWith(
          color: colors.onPrimaryContainer,
        ),
      );

  static ProgressIndicatorThemeData _progressIndicatorTheme(
    ColorScheme colors,
  ) =>
      ProgressIndicatorThemeData(
        // The track used to be the same colour as the bar, so linear progress
        // showed nothing at all.
        color: colors.primary,
        linearTrackColor: colors.surfaceContainerHighest,
        circularTrackColor: colors.surfaceContainerHighest,
        refreshBackgroundColor: colors.surfaceContainerLowest,
      );

  static DatePickerThemeData _datePickerTheme(
    ColorScheme colors,
    KaziColors kazi,
  ) =>
      DatePickerThemeData(
        backgroundColor: colors.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
        headerBackgroundColor: colors.surface,
        headerForegroundColor: colors.onSurface,
        todayBorder: BorderSide(color: kazi.focusRing),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: KaziRadii.lgBorder,
        ),
      );

  static DialogThemeData _dialogTheme(ColorScheme colors) => DialogThemeData(
        backgroundColor: colors.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: KaziTextStyles.headlineSmall.copyWith(
          color: colors.onSurface,
        ),
        contentTextStyle: KaziTextStyles.bodyMedium.copyWith(color: colors.onSurface),
        shape: const RoundedRectangleBorder(
          borderRadius: KaziRadii.lgBorder,
        ),
      );

  static SnackBarThemeData _snackBarTheme(ColorScheme colors) =>
      SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: colors.inverseSurface,
        actionTextColor: colors.inversePrimary,
        elevation: 0,
        contentTextStyle: KaziTextStyles.bodyMedium.copyWith(
          color: colors.onInverseSurface,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: KaziRadii.smBorder,
        ),
      );
}
