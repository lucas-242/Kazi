import 'package:flutter/material.dart';
import 'package:kazi/app/core/themes/themes.dart';

class CustomSingleScrollView extends StatelessWidget {
  const CustomSingleScrollView({
    super.key,
    required this.children,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: MainAxisSize.min,
        children: [
          ...children,
          AppSizeConstants.bottomAppSpacer,
        ],
      ),
    );
  }
}
