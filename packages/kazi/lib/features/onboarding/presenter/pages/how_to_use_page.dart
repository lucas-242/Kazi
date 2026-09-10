import 'package:flutter/material.dart';
import 'package:kazi/core/routes/app_pages.dart';
import 'package:kazi/core/widgets/sub_nav_bar.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

/// What "review the tutorial" becomes once the setup exists.
///
/// Replaying the setup on a configured app helps nobody — the catalog is
/// already there, the currency is already chosen. What is actually useful is a
/// short list of topics that each **open the real function**, so the answer is
/// found where the work happens.
class HowToUsePage extends StatelessWidget {
  const HowToUsePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = KaziLocalizations.current;
    final colors = context.colors;

    return Scaffold(
      body: KaziSafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubNavBar(title: l10n.howToUseKazi),
            KaziSpacings.verticalMd,
            _StartHereCard(
              title: l10n.howToUseStartTitle,
              message: l10n.howToUseStartBody,
              destination: AppPage.addServices,
            ),
            KaziSpacings.verticalMd,
            _Topic(
              accent: colors.category(0),
              title: l10n.checklistBuildCatalog,
              message: l10n.setupCatalogSubtitle,
              destination: AppPage.serviceCatalog,
            ),
            _Topic(
              accent: colors.category(1),
              title: l10n.hintReceivedTitle,
              message: l10n.hintReceivedBody,
              destination: AppPage.services,
            ),
            _Topic(
              accent: colors.category(2),
              title: l10n.hintSummaryTitle,
              message: l10n.hintSummaryBody,
              destination: AppPage.services,
            ),
            _Topic(
              accent: colors.category(3),
              title: l10n.billingCycle,
              message: l10n.billingCycleDescription,
              destination: AppPage.billingCycle,
            ),
            _Topic(
              accent: colors.category(4),
              title: l10n.howToUseCloseCycleTitle,
              message: l10n.howToUseCloseCycleBody,
              destination: AppPage.services,
            ),
            _Topic(
              accent: colors.category(5),
              title: l10n.howToUseClientEarningsTitle,
              message: l10n.howToUseClientEarningsBody,
              destination: AppPage.clients,
            ),
            KaziSpacings.verticalMd,
          ],
        ),
      ),
    );
  }
}

/// The one tip promoted above the rest: registering a service is what every
/// other topic on this page assumes has already happened at least once.
class _StartHereCard extends StatelessWidget {
  const _StartHereCard({
    required this.title,
    required this.message,
    required this.destination,
  });

  final String title;
  final String message;
  final AppPage destination;

  @override
  Widget build(BuildContext context) {
    final l10n = KaziLocalizations.current;
    final colors = context.colors;

    return Material(
      color: colors.inverse,
      borderRadius: KaziRadii.mdBorder,
      child: InkWell(
        borderRadius: KaziRadii.mdBorder,
        onTap: () => KaziNavigator.navigate(destination),
        child: Padding(
          padding: const EdgeInsets.all(KaziInsets.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.howToUseStartHere.toUpperCase(),
                style: KaziTextStyles.tag.copyWith(color: colors.inverseAccent),
              ),
              KaziSpacings.verticalXxs,
              Text(
                title,
                style: KaziTextStyles.titleSmall.copyWith(
                  color: colors.onInverse,
                ),
              ),
              KaziSpacings.verticalXxs,
              Text(
                message,
                style: KaziTextStyles.bodySmall.copyWith(
                  color: colors.onInverse.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// One line item, told apart by a colour bar rather than by an icon.
class _Topic extends StatelessWidget {
  const _Topic({
    required this.accent,
    required this.title,
    required this.message,
    required this.destination,
  });

  final Color accent;
  final String title;
  final String message;
  final AppPage destination;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.only(bottom: KaziInsets.xs),
      child: Material(
        color: colors.card,
        clipBehavior: Clip.antiAlias,
        shape: KaziCategoryBorder(color: colors.border, categoryColor: accent),
        child: InkWell(
          onTap: () => KaziNavigator.navigate(destination),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: KaziInsets.sm,
              vertical: KaziInsets.sm,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(title, style: KaziTextStyles.titleSmall),
                      Text(
                        message,
                        style: KaziTextStyles.bodySmall.copyWith(
                          color: colors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                KaziSpacings.horizontalXs,
                Icon(Icons.chevron_right, color: colors.textMuted),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
