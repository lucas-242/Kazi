import 'package:flutter/material.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/models/enums/order_by.dart';

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
            top: AppInsets.xLg,
            left: AppInsets.xLg,
            right: AppInsets.xLg,
            bottom: AppInsets.xxxLg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.current.orderBy,
                style: context.titleMedium,
              ),
              AppSpacings.verticalXLg,
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
