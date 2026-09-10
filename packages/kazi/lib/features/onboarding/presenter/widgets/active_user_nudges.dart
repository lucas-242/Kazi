import 'package:flutter/material.dart';
import 'package:kazi/core/routes/app_pages.dart';
import 'package:kazi/features/onboarding/presenter/controllers/active_user_nudges_controller.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

/// What the home shows someone who already uses the app.
///
/// Both cards are dismissible, neither blocks anything, and each one carries
/// the consequence of ignoring it — a request without a reason is ignored, and
/// rightly so.
class ActiveUserNudges extends ConsumerWidget {
  const ActiveUserNudges({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(activeUserNudgesControllerProvider).asData?.value;
    if (state == null) return const SizedBox.shrink();

    return Column(
      children: [
        if (state.askCycleConfirmation) const _CycleConfirmation(),
        if (state.hasCommissionGaps)
          _CommissionGaps(count: state.itemsMissingCommission.length),
      ],
    );
  }
}

class _NudgeCard extends StatelessWidget {
  const _NudgeCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: KaziInsets.md),
    padding: const EdgeInsets.all(KaziInsets.md),
    decoration: BoxDecoration(
      color: context.colors.money.surface,
      borderRadius: KaziRadii.mdBorder,
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
  );
}

/// Light on the graphite rather than brand yellow: on the home, yellow belongs
/// to the button that registers a service.
class _NudgeButton extends StatelessWidget {
  const _NudgeButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return SizedBox(
      width: double.infinity,
      child: KaziElevatedButton.label(
        label: label,
        onTap: onTap,
        backgroundColor: colors.money.onSurface,
        foregroundColor: colors.money.surface,
      ),
    );
  }
}

/// The one question worth asking an active user, phrased as a confirmation of
/// what the app is already doing rather than as a blank form.
class _CycleConfirmation extends ConsumerWidget {
  const _CycleConfirmation();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = KaziLocalizations.current;
    final colors = context.colors;
    final controller = ref.read(activeUserNudgesControllerProvider.notifier);

    return _NudgeCard(
      children: [
        Text(
          l10n.cycleConfirmTitle,
          style: KaziTextStyles.titleSmall.copyWith(
            color: colors.money.onSurface,
          ),
        ),
        KaziSpacings.verticalXs,
        Text(
          l10n.cycleConfirmBody,
          style: KaziTextStyles.bodySmall.copyWith(
            color: colors.money.onSurface.withValues(alpha: 0.8),
          ),
        ),
        KaziSpacings.verticalSm,
        _NudgeButton(
          label: l10n.cycleConfirmYes,
          onTap: controller.confirmCycle,
        ),
        Center(
          child: KaziTextButton(
            color: colors.money.onSurface,
            onTap: () {
              // Dismissed first: the settings screen writes the cycle
              // explicitly, which is what stops the card coming back.
              controller.dismissCycle();
              KaziNavigator.push(AppPage.billingCycle);
            },
            child: Text(l10n.cycleConfirmNo),
          ),
        ),
      ],
    );
  }
}

/// Shown only when there is something to fix. Someone whose items all have a
/// commission never sees it.
class _CommissionGaps extends ConsumerWidget {
  const _CommissionGaps({required this.count});

  final int count;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = KaziLocalizations.current;
    final colors = context.colors;
    final controller = ref.read(activeUserNudgesControllerProvider.notifier);

    return _NudgeCard(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.commissionGapsTitle(count),
                style: KaziTextStyles.titleSmall.copyWith(
                  color: colors.money.onSurface,
                ),
              ),
            ),
            IconButton(
              onPressed: controller.dismissGaps,
              icon: const Icon(Icons.close, size: 18),
              color: colors.money.onSurface.withValues(alpha: 0.6),
              visualDensity: VisualDensity.compact,
              tooltip: l10n.cancel,
            ),
          ],
        ),
        Text(
          l10n.commissionGapsBody,
          style: KaziTextStyles.bodySmall.copyWith(
            color: colors.money.onSurface.withValues(alpha: 0.8),
          ),
        ),
        KaziSpacings.verticalSm,
        _NudgeButton(
          label: l10n.commissionGapsCta,
          // The existing catalog screen is already the right form for this;
          // a second one would be a second place to keep correct.
          onTap: () => KaziNavigator.push(AppPage.serviceCatalog),
        ),
      ],
    );
  }
}
