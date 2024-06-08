import 'package:flutter/material.dart';
import 'package:kazi/app/core/themes/themes.dart';

class PaddingWrap extends StatelessWidget {
  const PaddingWrap({
    super.key,
    this.child,
    this.padding,
  });

  final Widget? child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          const EdgeInsets.only(
            left: AppInsets.lg,
            right: AppInsets.lg,
            top: AppInsets.lg,
          ),
      child: child,
    );
  }
}
