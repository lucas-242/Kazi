import 'package:flutter/material.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/themes/themes.dart';

import 'package:my_services/app/models/enums.dart';

class OrderByBottomSheet extends StatelessWidget {
  Map<OrderBy, String> get orderOptions => {
        OrderBy.alphabetical: AppLocalizations.current.orderAlphabetical,
        OrderBy.dateDesc: AppLocalizations.current.orderDateDesc,
        OrderBy.dateAsc: AppLocalizations.current.orderDateAsc,
        OrderBy.valueDesc: AppLocalizations.current.orderValueDesc,
        OrderBy.valueAsc: AppLocalizations.current.orderValueAsc,
      };

  final Function(OrderBy) onPressed;
  final OrderBy selectedOption;
  const OrderByBottomSheet({
    super.key,
    required this.onPressed,
    required this.selectedOption,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: AppSizeConstants.largeSpace,
            left: AppSizeConstants.largeSpace,
            right: AppSizeConstants.largeSpace,
            bottom: AppSizeConstants.imenseSpace,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.current.orderBy,
                style: context.titleMedium,
              ),
              AppSizeConstants.largeVerticalSpacer,
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
