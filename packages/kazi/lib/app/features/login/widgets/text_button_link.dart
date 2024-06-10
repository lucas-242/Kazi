import 'package:flutter/material.dart';
import 'package:kazi/app/core/themes/themes.dart';

class TextButtonLink extends StatelessWidget {
  const TextButtonLink({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.centerLeft,
        fixedSize: Size(context.width * 0.7, 15),
        splashFactory: NoSplash.splashFactory,
      ),
      child: child,
    );
  }
}
