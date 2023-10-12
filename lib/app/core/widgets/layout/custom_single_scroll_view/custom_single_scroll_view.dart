import 'package:flutter/material.dart';
import 'package:kazi/app/core/themes/themes.dart';

class CustomSingleScrollView extends StatelessWidget {
  const CustomSingleScrollView({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ...children,
          AppSizeConstants.bottomAppSpacer,
        ],
      ),
    );
  }
}
