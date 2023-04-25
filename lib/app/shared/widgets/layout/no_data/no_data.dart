import 'package:flutter/material.dart';
import 'package:my_services/app/shared/themes/themes.dart';

class NoData extends StatelessWidget {
  final String message;
  final Widget? navbar;

  const NoData({
    super.key,
    required this.message,
    this.navbar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (navbar != null) navbar!,
        if (navbar != null) SizedBox(height: context.height * 0.12),
        Image.asset(AppAssets.noData),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSizeConstants.largeSpace),
          child: Text(
            message,
            style: context.headlineSmall,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
