import 'package:flutter/material.dart';
import 'package:kazi/app/core/themes/extensions/theme_extension.dart';

class Loading extends StatelessWidget {
  const Loading({
    super.key,
    this.color,
    this.height,
    this.expanded = false,
  });

  final Color? color;
  final double? height;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    if (expanded) {
      return Expanded(
        child: Center(
          child: CircularProgressIndicator(
            color: color,
          ),
        ),
      );
    }

    return SizedBox(
      height: height ?? context.height,
      child: Center(
        child: CircularProgressIndicator(
          color: color,
        ),
      ),
    );
  }
}
