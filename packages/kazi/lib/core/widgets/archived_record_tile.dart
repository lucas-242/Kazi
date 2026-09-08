import 'package:flutter/material.dart';
import 'package:kazi_core/kazi_core.dart';

/// One row of an archive screen, for a client or a catalog item alike — and for
/// an archived item a search turned up.
///
/// It offers one thing: bringing the record back. Deleting is not here; it
/// lives in the "delete permanently" section further down the archive screen,
/// which is the only place in the app where something is erased for good. See
/// core/archiving.md.
class ArchivedRecordTile extends StatelessWidget {
  const ArchivedRecordTile({
    super.key,
    required this.name,
    required this.subtitle,
    required this.onRestore,
    this.color,
  });

  final String name;

  /// What it did and when it was put away — "12 services · Archived on 03/08".
  final String subtitle;

  final VoidCallback onRestore;

  /// The category colour, on the rows that carry one. Clients have no type, so
  /// they pass null and get the neutral edge.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Material(
      color: colors.card,
      clipBehavior: Clip.antiAlias,
      shape: KaziCategoryBorder(
        color: colors.border,
        categoryColor: color ?? colors.surfaceStrong,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: KaziInsets.md,
          vertical: KaziInsets.sm,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    style: KaziTextStyles.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  KaziSpacings.verticalXxs,
                  // Wraps rather than truncates: the line carries two facts,
                  // and an ellipsis eats the second one whole.
                  Text(
                    subtitle,
                    style: KaziTextStyles.labelSmall.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            KaziSpacings.horizontalSm,
            KaziTextButton(
              onTap: onRestore,
              color: colors.brand.text,
              child: Text(
                KaziLocalizations.current.restore,
                style: KaziTextStyles.labelMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
