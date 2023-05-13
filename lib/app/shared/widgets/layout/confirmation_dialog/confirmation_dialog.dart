import 'package:flutter/material.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/themes/extensions/theme_extension.dart';
import 'package:my_services/app/shared/themes/extensions/typography_extension.dart';
import 'package:my_services/app/shared/widgets/buttons/buttons.dart';

class ConfirmationDialog extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onConfirm;
  final String? title;
  final String message;
  final String? cancelText;
  final String? confirmText;

  const ConfirmationDialog({
    Key? key,
    required this.onConfirm,
    required this.onCancel,
    this.title,
    required this.message,
    this.cancelText,
    this.confirmText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key ?? const Key('AlertDialog'),
      title: Text(title ?? AppLocalizations.current.confirmAction,
          style: context.titleMedium),
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
