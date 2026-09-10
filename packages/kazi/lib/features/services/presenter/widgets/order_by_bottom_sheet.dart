import 'package:flutter/material.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;
import 'package:kazi_core/kazi_core.dart';

class OrderByBottomSheet extends StatelessWidget {
  const OrderByBottomSheet({
    super.key,
    required this.onPressed,
    required this.selectedOption,
  });
  final Function(OrderBy) onPressed;
  final OrderBy selectedOption;

  Map<OrderBy, String> get orderOptions => {
    OrderBy.dateDesc: KaziLocalizations.current.orderDateDesc,
    OrderBy.dateAsc: KaziLocalizations.current.orderDateAsc,
    OrderBy.valueDesc: KaziLocalizations.current.orderValueDesc,
    OrderBy.valueAsc: KaziLocalizations.current.orderValueAsc,
    OrderBy.alphabetical: KaziLocalizations.current.orderAlphabetical,
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
                KaziLocalizations.current.orderBy,
                style: KaziTextStyles.titleMedium,
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
                            ? KaziTextStyles.titleMedium
                            : KaziTextStyles.bodyMedium,
                      ),
                      trailing: Visibility(
                        visible: isSelected,
                        child: Icon(
                          Icons.check,
                          color: context.colors.brand.text,
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
