import 'package:flutter/material.dart';
import 'package:kazi/app/core/widgets/layout/custom_scaffold/widgets/custom_scroll_behavior.dart';
import 'package:kazi/app/core/widgets/layout/custom_scaffold/widgets/padding_wrap.dart';

class CustomSafeArea extends StatelessWidget {
  const CustomSafeArea({
    super.key,
    this.onRefresh,
    this.child,
    this.padding,
  });

  final Future<void> Function()? onRefresh;
  final Widget? child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScrollConfiguration(
        behavior: CustomScrollBehavior(),
        child: onRefresh != null
            ? RefreshIndicator(
                onRefresh: onRefresh!,
                child: PaddingWrap(
                  padding: padding,
                  child: child,
                ),
              )
            : PaddingWrap(
                padding: padding,
                child: child,
              ),
      ),
    );
  }
}
