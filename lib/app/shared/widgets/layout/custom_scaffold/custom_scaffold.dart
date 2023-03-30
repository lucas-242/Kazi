import 'package:flutter/material.dart';
import 'package:my_services/app/shared/themes/themes.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    this.onRefresh,
    this.child,
  });

  final Future<void> Function()? onRefresh;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: onRefresh != null ? onRefresh! : () => Future.value(),
          child: Padding(
            padding: const EdgeInsets.only(
              left: AppSizeConstants.mediumSpace,
              right: AppSizeConstants.mediumSpace,
              top: AppSizeConstants.mediumSpace,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
