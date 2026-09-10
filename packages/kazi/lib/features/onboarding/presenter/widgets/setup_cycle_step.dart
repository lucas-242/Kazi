import 'package:flutter/material.dart';
import 'package:kazi/features/onboarding/presenter/controllers/guided_setup_controller.dart';
import 'package:kazi/features/onboarding/presenter/controllers/guided_setup_state.dart';
import 'package:kazi/features/onboarding/presenter/widgets/setup_item_sheet.dart';
import 'package:kazi/core/widgets/option_tile.dart';
import 'package:kazi/features/onboarding/presenter/widgets/setup_scaffold.dart';
import 'package:kazi/features/settings/domain/models/billing_cycle.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

/// Screen 4 — when the money arrives, and in what.
///
/// The only screen that asks two things, and it gets away with it because the
/// currency comes pre-answered from the device: it needs a confirmation, not a
/// decision. Getting the cycle wrong at the start contaminates every total the
/// home will ever show, which is why it is asked here and not left to settings.
class SetupCycleStep extends ConsumerWidget {
  const SetupCycleStep({super.key, required this.state});

  final GuidedSetupState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = KaziLocalizations.current;
    final controller = ref.read(guidedSetupControllerProvider.notifier);
    final cycle = state.billingCycle;

    return SetupScaffold(
      step: SetupStep.cycle,
      onClose: () => showSetupExitDialog(context, ref),
      title: l10n.setupCycleTitle,
      subtitle: l10n.setupCycleSubtitle,
      action: KaziElevatedButton.label(
        label: l10n.setupContinue,
        onTap: () => controller.goToStep(SetupStep.firstService),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OptionTile(
            label: l10n.billingCycleMonthly,
            selected: cycle.type == BillingCycleType.monthly,
            detail: cycle is MonthlyCycle
                ? l10n.setupCycleMonthlyDetail(cycle.anchorDay)
                : null,
            onTap: () =>
                controller.setBillingCycle(BillingCycle.monthlyDefault),
          ),
          OptionTile(
            label: l10n.billingCycleFortnightly,
            selected: cycle.type == BillingCycleType.fortnightly,
            onTap: () => controller.setBillingCycle(
              const FortnightlyCycle(anchorDay: 15),
            ),
          ),
          OptionTile(
            label: l10n.billingCycleWeekly,
            selected: cycle.type == BillingCycleType.weekly,
            onTap: () => controller.setBillingCycle(
              const WeeklyCycle(anchorWeekday: DateTime.friday),
            ),
          ),
          KaziSpacings.verticalMd,
          Text(l10n.currency, style: KaziTextStyles.titleSmall),
          KaziSpacings.verticalXs,
          OptionTile(
            label: state.currency.isoCode,
            detail: state.currency.symbol,
            mark: OptionMark.none,
            selected: true,
            onTap: () => _pickCurrency(context, ref),
          ),
        ],
      ),
    );
  }

  Future<void> _pickCurrency(BuildContext context, WidgetRef ref) async {
    final controller = ref.read(guidedSetupControllerProvider.notifier);

    final picked = await KaziNavigator.showBottomSheet<SupportedCurrency>(
      context: context,
      backgroundColor: context.colors.card,
      builder: (sheetContext) => ListView(
        shrinkWrap: true,
        children: [
          for (final currency in SupportedCurrency.values)
            ListTile(
              title: Text(currency.localizedName),
              trailing: Text(currency.symbol),
              selected: currency == state.currency,
              onTap: () => Navigator.of(sheetContext).pop(currency),
            ),
        ],
      ),
    );

    if (picked != null) controller.setCurrency(picked);
  }
}
