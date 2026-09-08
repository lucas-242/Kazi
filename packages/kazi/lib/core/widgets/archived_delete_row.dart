import 'package:flutter/material.dart';
import 'package:kazi_core/kazi_core.dart';

/// One line of an archive screen's "delete permanently" section: a bin, a name,
/// and what stands in the way.
///
/// A record still named by a service reads muted and states its use; deleting
/// it would leave those records pointing at nothing. It stays on screen and
/// tappable anyway — a button that vanishes leaves the person wondering where
/// it went, where a refusal carrying the number closes the question. See
/// core/archiving.md.
class ArchivedDeleteRow extends StatelessWidget {
  const ArchivedDeleteRow({
    super.key,
    required this.name,
    required this.note,
    required this.deletable,
    required this.onTap,
  });

  final String name;

  /// What is holding it, or that nothing is — "used in 12 services" / "free".
  final String note;

  final bool deletable;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final ink = deletable ? colors.danger.onSurface : colors.textMuted;

    return Material(
      color: colors.card,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: KaziRadii.smBorder,
        side: BorderSide(
          color: deletable ? colors.danger.surfaceBorder : colors.border,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: KaziInsets.md,
            vertical: KaziInsets.sm,
          ),
          child: Row(
            children: [
              Icon(Icons.delete_outline, size: KaziSizings.iconSm, color: ink),
              KaziSpacings.horizontalXs,
              Expanded(
                child: Text(
                  name,
                  style: KaziTextStyles.bodyMedium.copyWith(color: ink),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              KaziSpacings.horizontalSm,
              Text(
                note,
                style: KaziTextStyles.labelSmall.copyWith(
                  color: colors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The last confirmation before something is erased for good. The only dialog
/// in the app whose answer cannot be undone, which is why it spells out what
/// survives the deletion rather than only what goes.
Future<void> confirmPermanentDelete(
  BuildContext context, {
  required String name,
  required String message,
  required Future<void> Function() onDelete,
}) {
  return showDialog<void>(
    context: context,
    builder: (_) => KaziDialog(
      title: KaziLocalizations.current.deleteForeverTitle(name),
      message: message,
      confirmText: KaziLocalizations.current.deletePermanently,
      isDestructive: true,
      onCancel: KaziNavigator.pop,
      onConfirm: () async {
        KaziNavigator.pop();
        await onDelete();
      },
    ),
  );
}
