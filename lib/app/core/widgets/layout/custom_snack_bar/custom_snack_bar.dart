import 'package:flutter/material.dart';
import 'package:kazi/app/core/themes/themes.dart';

enum SnackBarType { success, error }

ScaffoldFeatureController getCustomSnackBar(
  BuildContext context, {
  required String message,
  SnackBarType type = SnackBarType.error,
  Key? key,
}) {
  final colors = Theme.of(context).colorScheme;
  final textColor =
      type == SnackBarType.error ? colors.error : colors.onBackground;
  final backgroudColor =
      type == SnackBarType.error ? colors.errorContainer : AppColors.green;

  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      key: key,
      content: Text(
        message,
        style: TextStyle(color: textColor),
      ),
      backgroundColor: backgroudColor,
    ),
  );
}
