import 'dart:math' show min;

import 'package:flutter/material.dart';
import 'package:kazi/core/widgets/option_tile.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

/// Lets the user pick the profile default currency
class CurrencyBottomSheet extends ConsumerStatefulWidget {
  const CurrencyBottomSheet({super.key});

  @override
  ConsumerState<CurrencyBottomSheet> createState() =>
      _CurrencyBottomSheetState();
}

class _CurrencyBottomSheetState extends ConsumerState<CurrencyBottomSheet> {
  String _query = '';

  List<SupportedCurrency> get _filtered =>
      SupportedCurrency.values.where((c) => c.matchesSearch(_query)).toList();

  Future<void> _onSelect(SupportedCurrency currency) async {
    await ref
        .read(kaziCurrencyControllerProvider.notifier)
        .selectCurrency(currency);
    if (mounted) KaziNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final selected = ref.watch(kaziDefaultCurrencyProvider);
    final currencies = _filtered;
    final keyboard = MediaQuery.viewInsetsOf(context).bottom;

    // The sheet is anchored to the bottom of the screen, so the keyboard covers
    // its last `keyboard` pixels. The padding lifts the whole thing clear of
    // that, and the cap is the smaller of "never swallow the screen" and the
    // room actually left above the keyboard — capping on the full height alone
    // renders the end of the list underneath the keyboard, out of reach, and
    // overflows the column by whatever does not fit.
    return Padding(
      padding: EdgeInsets.only(bottom: keyboard),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: min(context.height * 0.7, context.height - keyboard),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: KaziInsets.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                KaziLocalizations.current.defaultCurrency,
                style: KaziTextStyles.titleMedium,
              ),
              KaziSpacings.verticalLg,
              KaziTextFormField(
                labelText: KaziLocalizations.current.search,
                hintText: KaziLocalizations.current.search,
                prefixIcon: const Icon(Icons.search),
                onChanged: (value) => setState(() => _query = value),
              ),
              KaziSpacings.verticalSm,
              KaziNote.emphasizing(
                KaziLocalizations.current.currencyChangeNote,
                emphasis: KaziLocalizations.current.currencyChangeNoteEmphasis,
              ),
              KaziSpacings.verticalMd,
              if (currencies.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: KaziInsets.md),
                  child: Text(
                    KaziLocalizations.current.noResults,
                    style: KaziTextStyles.titleSmall,
                  ),
                )
              else
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(bottom: KaziInsets.md),
                    itemCount: currencies.length,
                    itemBuilder: (_, index) {
                      final currency = currencies[index];
                      return OptionTile(
                        label: currency.localizedName,
                        detail: '${currency.isoCode} · ${currency.symbol}',
                        mark: OptionMark.radio,
                        selected: currency == selected,
                        onTap: () => _onSelect(currency),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
