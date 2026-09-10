import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:kazi/features/onboarding/domain/models/setup_catalog_item.dart';
import 'package:kazi/features/onboarding/presenter/controllers/guided_setup_controller.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

/// Edits one catalog line — or adds a new one — over the list itself.
///
/// A sheet rather than a screen: the point of the catalog step is that it is
/// one surface you correct in place. Sending someone to another page to fix a
/// price turns two taps into a journey.
Future<void> openSetupItemSheet(
  BuildContext context,
  WidgetRef ref, {
  required SupportedCurrency currency,
  SetupCatalogItem? item,
}) => KaziNavigator.showBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  backgroundColor: context.colors.card,
  builder: (_) => _SetupItemSheet(currency: currency, item: item),
);

class _SetupItemSheet extends ConsumerStatefulWidget {
  const _SetupItemSheet({required this.currency, this.item});

  final SupportedCurrency currency;
  final SetupCatalogItem? item;

  @override
  ConsumerState<_SetupItemSheet> createState() => _SetupItemSheetState();
}

class _SetupItemSheetState extends ConsumerState<_SetupItemSheet> {
  late final TextEditingController _nameController;
  late final MoneyMaskedTextController _valueController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item?.name ?? '');
    _valueController = MoneyMaskedTextController(
      initialValue: widget.item?.value ?? 0,
      leftSymbol: '${widget.currency.symbol} ',
      decimalSeparator: NumberFormatUtils.getDecimalSeparator(),
      thousandSeparator: NumberFormatUtils.getThousandSeparator(),
      precision: widget.currency.decimalDigits,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void _save() {
    final controller = ref.read(guidedSetupControllerProvider.notifier);
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    // Zero means "not priced", not "free": the mask cannot express an empty
    // amount, and a service worth nothing is not a thing anyone sells.
    final raw = _valueController.numberValue;
    final value = raw <= 0 ? null : raw;

    final item = widget.item;
    if (item == null) {
      controller.addItem(name: name, value: value);
    } else {
      controller.editItem(item.id, name: name, value: value);
    }
    KaziNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = KaziLocalizations.current;
    final item = widget.item;

    return Padding(
      padding: EdgeInsets.only(
        left: KaziInsets.lg,
        right: KaziInsets.lg,
        // The keyboard, while up, covers the foot of the sheet and its button.
        bottom: KaziInsets.lg + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item?.name ?? l10n.setupCatalogAddAnother,
            style: KaziTextStyles.titleMedium,
          ),
          KaziSpacings.verticalMd,
          KaziFieldInput(
            label: l10n.setupPriceSheetName,
            controller: _nameController,
            autofocus: item == null,
          ),
          KaziSpacings.verticalXs,
          KaziFieldInput(
            label: l10n.setupPriceSheetValue,
            controller: _valueController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            autofocus: item != null,
          ),
          if (item != null) ...[
            KaziSpacings.verticalSm,
            Text(
              '${l10n.setupPriceSheetKeep}: '
              '${NumberFormatUtils.formatPercent(item.commissionPercent)}',
              style: KaziTextStyles.bodySmall.copyWith(
                color: context.colors.textMuted,
              ),
            ),
          ],
          KaziSpacings.verticalLg,
          SizedBox(
            width: double.infinity,
            child: KaziElevatedButton.label(label: l10n.save, onTap: _save),
          ),
        ],
      ),
    );
  }
}

/// Confirms leaving the setup, naming what is left pending.
///
/// It exists so the exit is a decision rather than a slip, and it does not
/// argue — someone who wants out gets out, and what they answered is kept.
Future<void> showSetupExitDialog(BuildContext context, WidgetRef ref) async {
  final l10n = KaziLocalizations.current;

  final leave = await KaziNavigator.showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      backgroundColor: context.colors.card,
      title: Text(l10n.setupExitTitle, style: KaziTextStyles.titleMedium),
      content: Text(l10n.setupExitMessage, style: KaziTextStyles.bodyMedium),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: Text(l10n.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(true),
          child: Text(l10n.exit),
        ),
      ],
    ),
  );

  if (leave ?? false) {
    await ref.read(guidedSetupControllerProvider.notifier).exit();
  }
}
