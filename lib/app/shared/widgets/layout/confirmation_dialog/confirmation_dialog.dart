import 'package:flutter/material.dart';
import 'package:kazi/app/shared/l10n/generated/l10n.dart';
import 'package:kazi/app/shared/themes/extensions/theme_extension.dart';
import 'package:kazi/app/shared/themes/extensions/typography_extension.dart';
import 'package:kazi/app/shared/widgets/buttons/buttons.dart';

class ConfirmationDialog extends StatelessWidget {

  const ConfirmationDialog({
    super.key,
    required this.onConfirm,
    required this.onCancel,
    this.title,
    required this.message,
    this.cancelText,
    this.confirmText,
  });
  final VoidCallback onCancel;
  final VoidCallback onConfirm;
  final String? title;
  final String message;
  final String? cancelText;
  final String? confirmText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key ?? const Key('AlertDialog'),
      title: Text(title ?? AppLocalizations.current.confirmAction,
          style: context.titleMedium,),
      content: Text(message, style: context.bodyMedium),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      actions: [
        PillButton(
          onTap: onCancel,
          child: Text(cancelText ?? AppLocalizations.current.cancel),
        ),
        PillButton(
          onTap: onConfirm,
          backgroundColor: context.colorsScheme.error,
          child: Text(confirmText ?? AppLocalizations.current.confirm),
        ),
      ],
    );
  }
}
