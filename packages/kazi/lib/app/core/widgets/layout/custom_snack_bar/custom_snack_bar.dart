import 'package:flutter/material.dart';
import 'package:kazi/app/core/themes/themes.dart';

enum SnackBarType { success, error }

void showCustomSnackBar(
  BuildContext context,
  String message, {
  bool hasBottomNavigation = true,
  bool horizontalMargin = true,
  SnackBarType type = SnackBarType.error,
}) {
  final finalHorizontalBorder = horizontalMargin ? AppInsets.lg : 0.0;
  final backgroundColor =
      type == SnackBarType.error ? AppColors.red : AppColors.green;

  final OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: (hasBottomNavigation ? AppSizings.bottomAppBarHeight : 0) +
          AppInsets.xs,
      left: finalHorizontalBorder,
      right: finalHorizontalBorder,
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(8),
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(AppInsets.md),
          child: Text(
            message,
            style: context.titleSmall!.copyWith(color: AppColors.white),
          ),
        ),
      ),
    ),
  );

  Overlay.of(context).insert(overlayEntry);

  Future.delayed(const Duration(seconds: 5)).then((value) {
    overlayEntry.remove();
  });
}
