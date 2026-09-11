import 'package:flutter/material.dart';

/// Hands the keyboard's insets to [child] only while its route is the one on
/// top. A route covered by a form, a sheet or a dialog would otherwise rebuild
/// and lay itself out, behind it, on every frame of that keyboard's animation.
class KeyboardWhileOnTop extends StatelessWidget {
  const KeyboardWhileOnTop({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Always wrapped, even while on top: swapping the wrapper in and out would
    // remount the child and lose its state.
    return MediaQuery.removeViewInsets(
      context: context,
      removeBottom: !(ModalRoute.isCurrentOf(context) ?? true),
      child: child,
    );
  }
}
