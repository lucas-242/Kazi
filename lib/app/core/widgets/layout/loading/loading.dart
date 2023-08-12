import 'package:flutter/material.dart';
import 'package:kazi/app/core/themes/themes.dart';

class Loading extends StatelessWidget {
  const Loading({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height,
      child: Center(
        child: CircularProgressIndicator(
          color: color,
        ),
      ),
    );
  }
}
