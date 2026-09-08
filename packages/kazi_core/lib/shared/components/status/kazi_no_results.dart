import 'package:flutter/material.dart';
import 'package:kazi_core/shared/components/buttons/kazi_elevated_button.dart';
import 'package:kazi_core/shared/themes/themes.dart';

/// A search or a filter that matched nothing — data missing from *this* cut,
/// not from the account.
///
/// It hands control back rather than inviting: it repeats what was looked for
/// and offers the way out, whether that is creating the thing under the name
/// typed or clearing the filters. It carries **no** brand block — that belongs
/// to `KaziEmpty`, and here it would read as an account with nothing in it.
class KaziNoResults extends StatelessWidget {
  const KaziNoResults({
    super.key,
    required this.message,
    this.icon,
    this.description,
    this.actionLabel,
    this.onAction,
    this.scrollable = false,
  });

  /// The headline, with the term quoted back: `Nada encontrado para "gel"`.
  final String message;

  /// A glyph above the headline, in a muted disc — the magnifier over a search
  /// that found nothing. Left null where the cut was made by filters rather
  /// than by a term, which has no single mark to carry.
  final IconData? icon;

  /// What was searched, in one sentence. Optional.
  final String? description;

  /// The way out: create what was looked for, or clear the filters.
  ///
  /// Given as a label rather than a button, because the button is not the
  /// caller's decision: every no-result screen carries the same square ghost
  /// CTA, one weight below the invitation `KaziEmpty` ends with.
  final String? actionLabel;

  final VoidCallback? onAction;

  /// See `KaziEmpty.scrollable` — same reason, same requirement.
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final content = Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: KaziInsets.lg,
          vertical: KaziInsets.xLg,
        ),
        // The same block as `KaziEmpty`, at the same rhythm: one gap between
        // every part, the headline at the same size. What separates the two
        // states is the mark at the top and the weight of the button, not a
        // second set of measurements.
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: KaziInsets.md,
          children: [
            if (icon case final IconData glyph)
              Container(
                width: 80,
                height: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colors.surfaceMuted,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  glyph,
                  size: KaziSizings.iconLg,
                  color: colors.textMuted,
                ),
              ),
            Text(
              message,
              style: KaziTextStyles.titleMedium.copyWith(color: colors.text),
              textAlign: TextAlign.center,
            ),
            if (description case final String text)
              Text(
                text,
                style: KaziTextStyles.bodyMedium.copyWith(
                  color: colors.textMuted,
                ),
                textAlign: TextAlign.center,
              ),
            if (actionLabel case final String label)
              KaziElevatedButton.outlined(
                onTap: onAction,
                label: label,
                labelStyle: KaziTextStyles.labelLarge,
                foregroundColor: colors.text,
                borderColor: colors.borderStrong,
                padding: const EdgeInsets.symmetric(
                  horizontal: KaziInsets.lg,
                ),
              ),
          ],
        ),
      ),
    );

    if (!scrollable) return content;

    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      slivers: [
        SliverFillRemaining(hasScrollBody: false, child: content),
      ],
    );
  }
}
