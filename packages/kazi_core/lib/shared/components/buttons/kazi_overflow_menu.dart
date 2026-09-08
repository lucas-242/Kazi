import 'package:flutter/material.dart';
import 'package:kazi_core/shared/themes/themes.dart';

/// One entry of a [KaziOverflowMenu].
class KaziOverflowAction {
  const KaziOverflowAction({
    required this.label,
    required this.icon,
    required this.onTap,
    this.isDestructive = false,
    this.trailing,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  /// Draws the entry in the danger ink. Archiving and deleting, and nothing
  /// else — a menu where half the entries are red says nothing.
  final bool isDestructive;

  /// A count or other short qualifier at the end of the row.
  final String? trailing;
}

/// The "…" menu on a detail screen's app bar, holding the rare actions.
///
/// Archiving and deleting live here rather than as a button in the body: a
/// full-width control at the end of the content gives an action performed once
/// a quarter the visual weight of a primary one, and puts it exactly where the
/// thumb stops scrolling. Renders nothing when [actions] is empty, so a menu
/// with nothing left to offer disappears instead of opening empty.
class KaziOverflowMenu extends StatelessWidget {
  const KaziOverflowMenu({super.key, required this.actions, this.semantics});

  final List<KaziOverflowAction> actions;
  final String? semantics;

  @override
  Widget build(BuildContext context) {
    if (actions.isEmpty) return const SizedBox.shrink();

    final colors = context.colors;

    return PopupMenuButton<KaziOverflowAction>(
      icon: Icon(Icons.more_horiz, size: 18, color: colors.text),
      tooltip: semantics,
      // Under the button, not over it: a menu that opens on top of the "…"
      // hides what was tapped and lands its first entry under the thumb.
      position: PopupMenuPosition.under,
      color: colors.card,
      shape: const RoundedRectangleBorder(borderRadius: KaziRadii.smBorder),
      onSelected: (action) => action.onTap(),
      itemBuilder: (context) => [
        for (final action in actions)
          PopupMenuItem<KaziOverflowAction>(
            value: action,
            child: Row(
              children: [
                Icon(
                  action.icon,
                  size: KaziSizings.iconSm,
                  color: action.isDestructive
                      ? colors.danger.onSurface
                      : colors.text,
                ),
                KaziSpacings.horizontalSm,
                // A label long enough to overflow wraps instead: the menu is
                // as wide as its widest entry, and a clipped action is
                // unreadable rather than merely tight.
                Flexible(
                  child: Text(
                    action.label,
                    style: KaziTextStyles.labelLarge.copyWith(
                      color: action.isDestructive
                          ? colors.danger.onSurface
                          : colors.text,
                    ),
                  ),
                ),
                if (action.trailing case final String count) ...[
                  KaziSpacings.horizontalSm,
                  Text(
                    count,
                    style: KaziTextStyles.labelSmall.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  }
}
