import 'package:flutter/material.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/themes/themes.dart';

import 'package:my_services/app/models/enums.dart';

class OrderByBottomSheet extends StatelessWidget {
  Map<OrderBy, String> get orderOptions => {
        OrderBy.typeAsc: AppLocalizations.current.orderTypeAsc,
        OrderBy.typeDesc: AppLocalizations.current.orderTypeDesc,
        OrderBy.dateDesc: AppLocalizations.current.orderDateDesc,
        OrderBy.dateAsc: AppLocalizations.current.orderDateAsc,
        OrderBy.valueDesc: AppLocalizations.current.orderValueDesc,
        OrderBy.valueAsc: AppLocalizations.current.orderValueAsc,
      };

  final Function(OrderBy) onPressed;
  const OrderByBottomSheet({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        Text(AppLocalizations.current.orderBy, style: context.titleLarge),
        const SizedBox(height: 15),
        ListView.builder(
          shrinkWrap: true,
          itemCount: orderOptions.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => onPressed(orderOptions.keys.elementAt(index)),
              child: ListTile(
                title: Text(orderOptions.values.elementAt(index)),
              ),
            );
          },
        ),
      ],
    );
  }
}
