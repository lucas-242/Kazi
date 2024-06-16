import 'package:flutter/material.dart';
import 'package:kazi/core/l10n/generated/l10n.dart';
import 'package:kazi_core/kazi_core.dart';
import 'package:kazi_design_system/themes/themes.dart';

class OrderByBottomSheet extends StatelessWidget {
  const OrderByBottomSheet({
    super.key,
    required this.onPressed,
    required this.selectedOption,
  });
  final Function(OrderBy) onPressed;
  final OrderBy selectedOption;

  Map<OrderBy, String> get orderOptions => {
        OrderBy.alphabetical: AppLocalizations.current.orderAlphabetical,
        OrderBy.dateDesc: AppLocalizations.current.orderDateDesc,
        OrderBy.dateAsc: AppLocalizations.current.orderDateAsc,
        OrderBy.valueDesc: AppLocalizations.current.orderValueDesc,
        OrderBy.valueAsc: AppLocalizations.current.orderValueAsc,
      };

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: KaziInsets.xLg,
            left: KaziInsets.xLg,
            right: KaziInsets.xLg,
            bottom: KaziInsets.xxxLg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.current.orderBy,
                style: context.titleMedium,
              ),
              KaziSpacings.verticalXLg,
              ListView.separated(
                shrinkWrap: true,
                itemCount: orderOptions.length,
                itemBuilder: (context, index) {
                  final orderBy = orderOptions.keys.elementAt(index);
                  final isSelected = selectedOption == orderBy;
                  return GestureDetector(
                    onTap: () => onPressed(orderBy),
                    child: ListTile(
                      title: Text(
                        orderOptions.values.elementAt(index),
                        style: isSelected
                            ? context.titleMedium
                            : context.bodyMedium,
                      ),
                      trailing: Visibility(
                        visible: isSelected,
                        child: Icon(
                          Icons.check,
                          color: context.colorsScheme.primary,
                        ),
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
