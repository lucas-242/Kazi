import 'package:flutter/material.dart';
import 'package:kazi_core/kazi_core.dart';

/// One fact on a detail screen: its name on the left, its value at the end of
/// the row, inside a bordered card.
///
/// The same shape on every detail screen — a client, a catalogue item — so that
/// reading one teaches how to read the next.
class DetailInfoRow extends StatelessWidget {
  const DetailInfoRow({
    super.key,
    required this.label,
    required String this.value,
    this.icon,
    this.onTap,
  }) : trailing = null;

  /// For a value no sentence can carry — a colour, a mark.
  const DetailInfoRow.trailing({
    super.key,
    required this.label,
    required Widget this.trailing,
    this.icon,
  }) : value = null,
       onTap = null;

  final String label;
  final String? value;
  final Widget? trailing;

  final IconData? icon;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.only(bottom: KaziInsets.xs),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: colors.card,
          borderRadius: KaziRadii.smBorder,
          border: Border.all(color: colors.border),
        ),
        child: Material(
          type: MaterialType.transparency,
          borderRadius: KaziRadii.smBorder,
          child: InkWell(
            onTap: onTap,
            borderRadius: KaziRadii.smBorder,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: KaziInsets.md,
                vertical: KaziInsets.sm,
              ),
              child: Row(
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      size: KaziSizings.iconSm,
                      color: colors.textMuted,
                    ),
                    KaziSpacings.horizontalXs,
                  ],
                  Expanded(
                    flex: 2,
                    child: Text(
                      label,
                      style: KaziTextStyles.bodySmall.copyWith(
                        color: colors.textMuted,
                      ),
                    ),
                  ),
                  KaziSpacings.horizontalSm,
                  if (trailing != null)
                    trailing!
                  else
                    Expanded(
                      flex: 3,
                      child: Text(
                        value!,
                        style: KaziTextStyles.labelLarge.copyWith(
                          fontWeight: FontWeight.w600,
                          color: onTap == null ? null : colors.brand.text,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
