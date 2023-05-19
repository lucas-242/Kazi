import 'package:flutter/material.dart';
import 'package:kazi/app/shared/themes/themes.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
