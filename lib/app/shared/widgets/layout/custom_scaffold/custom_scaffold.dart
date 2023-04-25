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
    return SafeArea(
      child: onRefresh != null
          ? RefreshIndicator(
              onRefresh: onRefresh!,
              child: DefaultPadding(child: child),
            )
          : DefaultPadding(child: child),
    );
  }
}

class DefaultPadding extends StatelessWidget {
  const DefaultPadding({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSizeConstants.largeSpace,
        right: AppSizeConstants.largeSpace,
        top: AppSizeConstants.largeSpace,
      ),
      child: child,
    );
  }
}
