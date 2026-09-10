import 'package:flutter/material.dart';
import 'package:kazi/features/onboarding/presenter/controllers/guided_setup_controller.dart';
import 'package:kazi/features/onboarding/presenter/controllers/guided_setup_state.dart';
import 'package:kazi/features/onboarding/presenter/widgets/setup_item_sheet.dart';
import 'package:kazi/core/widgets/option_tile.dart';
import 'package:kazi/features/onboarding/presenter/widgets/setup_scaffold.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

/// Screen 3 — the commission, which is the app's entire calculation.
///
/// One percentage for everything, exceptions by tap. The question is phrased
/// as what the user *keeps*, never as what is withheld: it is their money the
/// number describes.
class SetupCommissionStep extends ConsumerWidget {
  const SetupCommissionStep({super.key, required this.state});

  final GuidedSetupState state;

  /// The four answers that cover almost everyone. Anything else is set on the
  /// service itself.
  static const List<double> _presets = [30, 40, 50, 100];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = KaziLocalizations.current;
    final controller = ref.read(guidedSetupControllerProvider.notifier);
    final items = state.selectedItems;

    // The shared percentage is whatever the untouched items agree on; once
    // they disagree, no chip is shown as active.
    final shared = _sharedPercent(state);

    return SetupScaffold(
      step: SetupStep.commission,
      onClose: () => showSetupExitDialog(context, ref),
      title: l10n.setupCommissionTitle,
      subtitle: l10n.setupCommissionSubtitle,
      action: KaziElevatedButton.label(
        label: l10n.setupContinue,
        onTap: () => controller.goToStep(SetupStep.cycle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: KaziInsets.xs,
            runSpacing: KaziInsets.xs,
            children: [
              for (final percent in _presets)
                KaziChip(
                  label: NumberFormatUtils.formatPercent(percent),
                  isSelected: shared == percent,
                  onTap: () => controller.setCommissionForAll(percent),
                ),
            ],
          ),
          KaziSpacings.verticalMd,
          for (final item in items)
            OptionTile(
              label: item.name,
              mark: OptionMark.none,
              detail: NumberFormatUtils.formatPercent(item.commissionPercent),
              onTap: () => _editOne(context, ref, item.id),
            ),
          KaziSpacings.verticalXs,
          Text(
            l10n.setupCommissionPerItem,
            style: KaziTextStyles.bodySmall.copyWith(
              color: context.colors.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  static double? _sharedPercent(GuidedSetupState state) {
    final open = state.selectedItems
        .where((item) => !item.hasCustomCommission)
        .toList();
    if (open.isEmpty) return null;

    final first = open.first.commissionPercent;
    return open.every((item) => item.commissionPercent == first)
        ? first
        : null;
  }

  Future<void> _editOne(
    BuildContext context,
    WidgetRef ref,
    String itemId,
  ) async {
    final controller = ref.read(guidedSetupControllerProvider.notifier);

    final picked = await KaziNavigator.showBottomSheet<double>(
      context: context,
      backgroundColor: context.colors.card,
      builder: (sheetContext) => Padding(
        padding: const EdgeInsets.fromLTRB(
          KaziInsets.lg,
          KaziInsets.zero,
          KaziInsets.lg,
          KaziInsets.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              KaziLocalizations.current.setupPriceSheetKeep,
              style: KaziTextStyles.titleMedium,
            ),
            KaziSpacings.verticalMd,
            Wrap(
              spacing: KaziInsets.xs,
              runSpacing: KaziInsets.xs,
              children: [
                for (final percent in _presets)
                  KaziChip(
                    label: NumberFormatUtils.formatPercent(percent),
                    onTap: () => Navigator.of(sheetContext).pop(percent),
                  ),
              ],
            ),
          ],
        ),
      ),
    );

    if (picked != null) controller.setCommissionFor(itemId, picked);
  }
}
