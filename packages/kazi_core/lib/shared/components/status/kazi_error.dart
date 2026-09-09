import 'package:flutter/material.dart';
import 'package:kazi_core/shared/components/buttons/kazi_elevated_button.dart';
import 'package:kazi_core/shared/l10n/generated/l10n.dart';
import 'package:kazi_core/shared/themes/themes.dart';

/// A read that failed. Says what happened, says the data is safe, and offers
/// the one thing worth offering — trying again.
///
/// The reassurance is not decoration: the fear behind a failed load in a money
/// app is that the records are gone, and the screen has to answer it before
/// anything else. [code] is for support, so it is a footnote and never the
/// message.
class KaziError extends StatelessWidget {
  const KaziError({
    super.key,
    required this.message,
    this.description,
    this.onRetry,
    this.code,
    this.scrollable = false,
  });

  /// What failed, in the user's terms: "Não conseguimos carregar seus serviços".
  final String message;

  /// Defaults to the reassurance that nothing was lost.
  final String? description;

  final VoidCallback? onRetry;

  /// A support handle — an error code, a timestamp. Rendered small and last.
  final String? code;

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: KaziInsets.sm,
          children: [
            Text(
              message,
              style: KaziTextStyles.titleSmall.copyWith(color: colors.text),
              textAlign: TextAlign.center,
            ),
            Text(
              description ?? KaziLocalizations.current.errorDataIsSafe,
              style: KaziTextStyles.bodyMedium.copyWith(
                color: colors.textMuted,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry case final VoidCallback retry) ...[
              KaziSpacings.verticalXs,
              KaziElevatedButton.outlined(
                onTap: retry,
                label: KaziLocalizations.current.tryAgain,
                labelStyle: KaziTextStyles.labelLarge,
                foregroundColor: colors.text,
                borderColor: colors.borderStrong,
                padding: const EdgeInsets.symmetric(
                  horizontal: KaziInsets.lg,
                ),
              ),
            ],
            if (code case final String support)
              Text(
                support,
                style: KaziTextStyles.tag.copyWith(color: colors.textMuted),
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
