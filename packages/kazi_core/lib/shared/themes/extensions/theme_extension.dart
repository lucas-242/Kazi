import 'package:flutter/material.dart';
import 'package:kazi_core/shared/themes/kazi_colors.dart';
import 'package:kazi_core/shared/themes/settings/kazi_breakpoints.dart';

/// Theme and media-query shortcuts on [BuildContext].
///
/// Named `KaziThemeExtension` rather than `ThemeExtension` because the barrel
/// re-exports this alongside `package:flutter/material.dart`, where
/// [ThemeExtension] is Material's own class. Extension members are resolved
/// implicitly, so the name never appears at a call site.
extension KaziThemeExtension on BuildContext {
  ThemeData get _theme => Theme.of(this);

  /// Every Kazi colour, already resolved for the current brightness.
  ///
  /// This is the only colour accessor a screen needs — see [KaziColors] for
  /// the "I want to paint X, which token?" table. There is deliberately no
  /// shortcut to [ColorScheme]: reaching for it is how yellow ends up as ink
  /// on a light surface.
  ///
  /// Falls back to the light set when the ambient theme was not built by
  /// `KaziThemeSettings` — a bare [MaterialApp] in a widget test, for
  /// instance — so reading this can never throw.
  KaziColors get colors =>
      _theme.extension<KaziColors>() ?? KaziColors.light;

  /// The type scale with theme colours already applied.
  ///
  /// Use this when you want the text to take its colour from the theme;
  /// `KaziTextStyles.*` are colourless and inherit from the ambient
  /// `DefaultTextStyle`, which is usually what you want inside a `Text`.
  TextTheme get text => _theme.textTheme;

  // Aspect lookups, never `MediaQuery.of`: the keyboard changes the view
  // insets on every frame of its animation, and a full dependency rebuilds
  // every reader of these — the tabs kept offstage included.
  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;

  double get topPadding => MediaQuery.viewPaddingOf(this).top;
  double get bottomPadding => MediaQuery.viewPaddingOf(this).bottom;

  /// Returns T according to the screen size.
  ///
  /// If the screen size is not provided,
  /// it will use the next lowest screen size provided.
  T whenScreenSize<T>({
    T? xxxLg,
    T? xxLg,
    T? xLg,
    T? lg,
    T? md,
    T? sm,
    required T xs,
  }) {
    switch (width) {
      case >= KaziBreakpoints.xxxLg:
        return xxxLg ?? xxLg ?? xLg ?? lg ?? md ?? sm ?? xs;
      case >= KaziBreakpoints.xxLg:
        return xxLg ?? xLg ?? lg ?? md ?? sm ?? xs;
      case >= KaziBreakpoints.xLg:
        return xLg ?? lg ?? md ?? sm ?? xs;
      case >= KaziBreakpoints.lg:
        return lg ?? md ?? sm ?? xs;
      case >= KaziBreakpoints.md:
        return md ?? sm ?? xs;
      case >= KaziBreakpoints.sm:
        return sm ?? xs;
      default:
        return xs;
    }
  }
}
