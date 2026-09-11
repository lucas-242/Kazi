import 'package:flutter/material.dart';
import 'package:kazi_core/shared/themes/themes.dart';

/// Adds padding to the [child].
///
/// When the sceen size hits a xxLg width, it fixes a padding to the screen considering [wideDevicesPaddingTop].
class KaziPaddingWrap extends StatelessWidget {
  const KaziPaddingWrap({
    super.key,
    this.child,
    this.paddingLeft,
    this.paddingRight,
    this.paddingTop,
    this.paddingBottom,
  });

  final Widget? child;
  final double? paddingLeft;
  final double? paddingRight;
  final double? paddingTop;
  final double? paddingBottom;

  /// The padding this widget applies, for a scroll view that has to carry it
  /// inside itself — as a `SliverPadding` — rather than be wrapped in it.
  static EdgeInsets paddingOf(
    BuildContext context, {
    double? left,
    double? right,
    double? top,
    double? bottom,
  }) {
    return context.whenScreenSize(
      xs: EdgeInsets.only(
        left: left ?? KaziInsets.lg,
        right: right ?? KaziInsets.lg,
        top: top ?? KaziInsets.lg,
        bottom: bottom ?? 0,
      ),
      xxLg: EdgeInsets.only(
        left: context.width * .06,
        right: context.width * .06,
        top: top ?? 0,
        bottom: bottom ?? 0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingOf(
        context,
        left: paddingLeft,
        right: paddingRight,
        top: paddingTop,
        bottom: paddingBottom,
      ),
      child: child,
    );
  }
}
