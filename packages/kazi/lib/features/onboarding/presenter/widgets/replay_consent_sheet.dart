import 'package:flutter/material.dart';
import 'package:kazi/core/routes/app_pages.dart';
import 'package:kazi/features/settings/presenter/controllers/privacy_controller.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

/// The one time the app asks to record sessions.
///
/// Placed at the end of the guided setup, on the screen that has just shown
/// someone their first number — not on first launch. Asked before any value is
/// delivered, this reads as a stranger asking for the keys; asked here, it
/// reads as a favour returned, and the people who say yes are the ones whose
/// sessions are actually worth watching.
///
/// It states the masking plainly, because the masking is the only reason the
/// answer can honestly be yes.
class ReplayConsentSheet extends ConsumerWidget {
  const ReplayConsentSheet({super.key});

  static bool _askedThisSession = false;

  @visibleForTesting
  static void resetSessionGuard() => _askedThisSession = false;

  static Future<void> askIfNeeded(BuildContext context, WidgetRef ref) async {
    if (_askedThisSession) return;

    final settings = await ref.read(privacyControllerProvider.future);
    if (!settings.needsReplayPrompt) return;
    if (!context.mounted) return;

    _askedThisSession = true;
    final consented = await KaziNavigator.showBottomSheet<bool>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (_) => const ReplayConsentSheet(),
    );

    await ref
        .read(privacyControllerProvider.notifier)
        .setSessionReplayConsent(consented ?? false);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = KaziLocalizations.current;
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        KaziInsets.lg,
        KaziInsets.zero,
        KaziInsets.lg,
        KaziInsets.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.replayConsentTitle, style: KaziTextStyles.titleMedium),
          KaziSpacings.verticalSm,
          Text(
            l10n.replayConsentBody,
            style: KaziTextStyles.bodyMedium.copyWith(color: colors.textMuted),
          ),
          KaziSpacings.verticalLg,
          KaziElevatedButton.label(
            label: l10n.replayConsentAccept,
            backgroundColor: colors.inverse,
            foregroundColor: colors.onInverse,
            onTap: () => Navigator.of(context).pop(true),
          ),
          KaziSpacings.verticalXs,
          KaziElevatedButton.outlined(
            label: l10n.replayConsentDecline,
            onTap: () => Navigator.of(context).pop(false),
          ),
          KaziTextButton(
            onTap: () => KaziNavigator.push(AppPage.privacyPolicy),
            child: Text(l10n.replayConsentLearnMore),
          ),
        ],
      ),
    );
  }
}
