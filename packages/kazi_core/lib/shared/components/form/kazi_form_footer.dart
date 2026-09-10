import 'package:flutter/material.dart';
import 'package:kazi_core/shared/components/buttons/kazi_elevated_button.dart';
import 'package:kazi_core/shared/themes/themes.dart';

/// The bar a screen's one action is taken from: a rule, then one full-width
/// button.
///
/// It sits outside the scroll, so the button is reachable without reading to
/// the end of a form that is taller than the screen. The rule is what makes it
/// read as the page's foot rather than as the last thing in the content — a
/// button floating over the final field looks like it belongs to that field.
class KaziFormFooter extends StatelessWidget {
  const KaziFormFooter({
    super.key,
    required this.label,
    required this.onTap,
    this.isOutlined = false,
    this.child,
  });

  final String label;

  /// Drops the fill for an action that undoes rather than commits. Neutral ink
  /// on purpose: an undo that shouts as loudly as the thing it undoes reads as
  /// the screen's main offer.
  final bool isOutlined;

  /// Null disables the button. A form mid-write passes null, so a second tap
  /// cannot submit it twice.
  final VoidCallback? onTap;

  /// Wraps the button — for the probes and hints that need to sit around it.
  final Widget Function(Widget button)? child;

  @override
  Widget build(BuildContext context) {
    final button = isOutlined
        ? KaziElevatedButton.outlined(onTap: onTap, label: label)
        : KaziElevatedButton.label(
            onTap: onTap,
            label: label,
            backgroundColor: context.colors.money.surface,
            foregroundColor: context.colors.money.onSurface,
          );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.background,
        border: Border(top: BorderSide(color: context.colors.border)),
      ),
      // Padded inside the SafeArea, not through its `minimum`: a minimum yields
      // to the gesture bar's inset instead of adding to it.
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            KaziInsets.lg,
            KaziInsets.sm,
            KaziInsets.lg,
            KaziInsets.md,
          ),
          child: child == null ? button : child!(button),
        ),
      ),
    );
  }
}
