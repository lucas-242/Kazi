import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kazi/core/constants/storage_keys.dart';
import 'package:kazi/core/routes/app_pages.dart';
import 'package:kazi/core/utils/base_state.dart';
import 'package:kazi/features/app_update/app_update.dart';
import 'package:kazi/features/auth/presenter/widgets/sign_out_dialog.dart';
import 'package:kazi/features/onboarding/domain/models/onboarding_hint.dart';
import 'package:kazi/features/onboarding/presenter/controllers/checklist_controller.dart';
import 'package:kazi/features/onboarding/presenter/controllers/onboarding_controller.dart';
import 'package:kazi/features/onboarding/presenter/pages/whats_new_page.dart';
import 'package:kazi/features/onboarding/presenter/widgets/replay_consent_sheet.dart';
import 'package:kazi/features/services/presenter/controllers/catalog_controller.dart';
import 'package:kazi/features/settings/domain/models/privacy_settings.dart';
import 'package:kazi/features/settings/presenter/controllers/billing_cycle_controller.dart';
import 'package:kazi/features/settings/presenter/controllers/privacy_controller.dart';
import 'package:kazi/features/settings/presenter/widgets/billing_cycle_l10n.dart';
import 'package:kazi/features/settings/presenter/widgets/currency_bottom_sheet.dart';
import 'package:kazi/features/settings/presenter/widgets/language_bottom_sheet.dart';
import 'package:kazi/features/settings/presenter/widgets/settings_group.dart';
import 'package:kazi/features/settings/presenter/widgets/settings_option_button.dart';
import 'package:kazi/features/settings/presenter/widgets/settings_switch_button.dart';
import 'package:kazi/features/settings/presenter/widgets/theme_bottom_sheet.dart';
import 'package:kazi/features/subscription/subscription.dart';
import 'package:kazi/injector.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

/// The menu: what defines the earnings, what adjusts the app, what talks about
/// the app — in that order. Clients are a bottom-bar destination, not a
/// setting: consulted daily, not configured monthly.
class SettingsOptions extends ConsumerWidget {
  const SettingsOptions({super.key, required this.onRateApp});
  final VoidCallback onRateApp;

  void _showSheet(BuildContext context, Widget sheet) {
    KaziNavigator.showBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (_) => sheet,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPremium = ref.watch(isPremiumProvider);
    final isPaymentsEnabled = ref.watch(isPaymentsEnabledProvider);

    final currency = ref.watch(kaziDefaultCurrencyProvider);
    final cycle = ref.watch(billingCycleProvider);
    final locale = ref.watch(kaziEffectiveLocaleProvider);
    final themeMode =
        ref.watch(kaziThemeControllerProvider).asData?.value ??
        ThemeMode.system;

    final privacy =
        ref.watch(privacyControllerProvider).asData?.value ??
        const PrivacySettings();
    final catalog = ref.watch(catalogControllerProvider);
    final catalogCount = switch (catalog.status) {
      BaseStateStatus.loading || BaseStateStatus.error => null,
      _ => catalog.activeCatalogItems.length,
    };

    return Column(
      children: [
        if (isPaymentsEnabled && !isPremium)
          SettingsOptionButton(
            onTap: () => showPaywall(context),
            text: KaziLocalizations.current.goPremium,
            icon: Icons.workspace_premium_outlined,
            isHighlighted: true,
          ),
        SettingsGroup(
          title: KaziLocalizations.current.myWork,
          children: [
            SettingsOptionButton(
              text: KaziLocalizations.current.serviceCatalog,
              icon: Icons.sell_outlined,
              value: catalogCount == null
                  ? null
                  : KaziLocalizations.current.itemsCount(catalogCount),
              onTap: () => KaziNavigator.push(AppPage.serviceCatalog),
            ),
            SettingsOptionButton(
              // Here and not under Preferences: the cycle is what defines your
              // earnings — it decides the big number on the home — and a
              // preference is something that only changes how the app looks.
              // A page, not a sheet: it carries a picker of its own.
              text: KaziLocalizations.current.billingCycle,
              icon: Icons.event_repeat_outlined,
              value: cycle.type.label,
              subValue: cycle.anchorLabel(context),
              onTap: () => KaziNavigator.push(AppPage.billingCycle),
            ),
          ],
        ),
        SettingsGroup(
          title: KaziLocalizations.current.preferences,
          children: [
            SettingsOptionButton(
              text: KaziLocalizations.current.defaultCurrency,
              icon: Icons.payments_outlined,
              value: '${currency.isoCode} · ${currency.symbol}',
              onTap: () => _showSheet(context, const CurrencyBottomSheet()),
            ),
            SettingsOptionButton(
              text: KaziLocalizations.current.language,
              icon: Icons.language,
              value: _languageLabel(locale.languageCode),
              onTap: () => _showSheet(context, const LanguageBottomSheet()),
            ),
            SettingsOptionButton(
              text: KaziLocalizations.current.theme,
              icon: Icons.dark_mode_outlined,
              value: _themeLabel(themeMode),
              onTap: () => _showSheet(context, const ThemeBottomSheet()),
            ),
          ],
        ),
        SettingsGroup(
          title: KaziLocalizations.current.privacy,
          children: [
            SettingsSwitchButton(
              value: privacy.isAnalyticsAllowed,
              onChanged: (enabled) => ref
                  .read(privacyControllerProvider.notifier)
                  .setAnalyticsEnabled(enabled),
              text: KaziLocalizations.current.privacyUsageData,
              description:
                  KaziLocalizations.current.privacyUsageDataDescription,
              icon: Icons.insights_outlined,
            ),
            SettingsSwitchButton(
              value: privacy.isReplayAllowed,
              onChanged: (consented) => ref
                  .read(privacyControllerProvider.notifier)
                  .setSessionReplayConsent(consented),
              text: KaziLocalizations.current.privacySessionRecording,
              description:
                  KaziLocalizations.current.privacySessionRecordingDescription,
              icon: Icons.videocam_outlined,
            ),
            SettingsOptionButton(
              onTap: () => KaziNavigator.push(AppPage.privacyPolicy),
              text: KaziLocalizations.current.privacyPolicy,
              icon: Icons.policy_outlined,
            ),
          ],
        ),
        SettingsGroup(
          title: KaziLocalizations.current.about,
          children: [
            SettingsOptionButton(
              onTap: () => KaziNavigator.push(AppPage.howToUse),
              text: KaziLocalizations.current.howToUseKazi,
              icon: Icons.help_outline,
            ),
            SettingsOptionButton(
              onTap: onRateApp,
              text: KaziLocalizations.current.rateApp,
              icon: Icons.star_outline,
            ),
            SettingsOptionButton(
              onTap: () => showSignOutDialog(context, ref),
              text: KaziLocalizations.current.signOut,
              icon: Icons.logout,
              isDestructive: true,
            ),
          ],
        ),
        // Debug only, so the label is not translated: this row never ships.
        if (kDebugMode)
          SettingsGroup(
            title: 'Debug',
            children: [
              SettingsOptionButton(
                onTap: () => KaziNavigator.push(AppPage.themeGallery),
                text: 'Design tokens',
                icon: Icons.palette_outlined,
              ),
              SettingsOptionButton(
                onTap: () => _resetOnboarding(ref),
                text: 'Reset onboarding',
                icon: Icons.restart_alt,
              ),
              SettingsOptionButton(
                onTap: () => _resetCoachMarks(context, ref),
                text: 'Reset coach marks',
                icon: Icons.lightbulb_outline,
              ),
              SettingsOptionButton(
                onTap: () => KaziNavigator.push(AppPage.forcedUpdate),
                text: 'Forced update screen',
                icon: Icons.system_update,
              ),
              SettingsOptionButton(
                onTap: () => KaziNavigator.showDialog(
                  context: context,
                  builder: (_) => const OptionalUpdateDialog(storeUrl: ''),
                ),
                text: 'Optional update dialog',
                icon: Icons.system_update_alt,
              ),
              SettingsOptionButton(
                onTap: () => KaziNavigator.showBottomSheet<bool>(
                  context: context,
                  useRootNavigator: true,
                  isScrollControlled: true,
                  builder: (_) => const ReplayConsentSheet(),
                ),
                text: 'Replay consent sheet',
                icon: Icons.videocam_outlined,
              ),
              SettingsOptionButton(
                onTap: () => _showWhatsNew(context, ref),
                text: 'What\'s new screen',
                icon: Icons.auto_awesome_outlined,
              ),
            ],
          ),
      ],
    );
  }

  static void _showWhatsNew(BuildContext context, WidgetRef ref) {
    final info = ref.read(appUpdateControllerProvider).info;

    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (routeContext) => WhatsNewPage(
          version: info.currentVersion.isEmpty ? '0.0.0' : info.currentVersion,
          entries: info.whatsNew.isNotEmpty ? info.whatsNew : _sampleWhatsNew,
          onClose: () => Navigator.of(routeContext).pop(),
        ),
      ),
    );
  }

  static const _sampleWhatsNew = [
    WhatsNewEntry(
      title: 'Test 1',
      description:
          'The top total now follows the day you get paid, not the calendar.',
    ),
    WhatsNewEntry(
      title: 'Test 2',
      description: 'The same list, seen by type and by client.',
    ),
    WhatsNewEntry(
      title: 'Test 3',
      description:
          'Anyone starting now comes in with their services already in.',
    ),
  ];

  /// The hints alone, with no user document written: each one is owed again
  /// the next time its anchor is on screen, without a restart.
  static Future<void> _resetCoachMarks(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final storage = await ref.read(localStorageProvider.future);
    for (final hint in OnboardingHint.values) {
      await storage.remove(hint.storageKey);
    }

    if (context.mounted) {
      KaziSnackbar.show(context, 'Coach marks reset.');
    }
  }

  /// No restart needed: the router follows the replayed segment straight into
  /// the setup, which disposes this widget — so the replay has to come last.
  static Future<void> _resetOnboarding(WidgetRef ref) async {
    final storage = await ref.read(localStorageProvider.future);
    for (final hint in OnboardingHint.values) {
      await storage.remove(hint.storageKey);
    }
    await storage.remove(StorageKeys.whatsNewSeenVersion);

    ref.invalidate(checklistControllerProvider);
    await ref.read(onboardingControllerProvider.notifier).replayForDebug();
  }

  static String _languageLabel(String languageCode) => switch (languageCode) {
    'pt' => 'Português',
    'es' => 'Español',
    _ => 'English',
  };

  static String _themeLabel(ThemeMode mode) => switch (mode) {
    ThemeMode.system => KaziLocalizations.current.themeSystem,
    ThemeMode.light => KaziLocalizations.current.themeLight,
    ThemeMode.dark => KaziLocalizations.current.themeDark,
  };
}
