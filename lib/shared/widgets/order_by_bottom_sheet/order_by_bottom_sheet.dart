import 'package:flutter/material.dart';
import 'package:my_services/shared/themes/themes.dart';

import '../../../models/enums.dart';

class OrderByBottomSheet extends StatelessWidget {
  Map<OrderBy, String> get orderOptions => {
        OrderBy.typeAsc: 'Tipo: De A à Z',
        OrderBy.typeDesc: 'Tipo: De Z à A',
        OrderBy.dateDesc: 'Data: Mais atual para menos atual',
        OrderBy.dateAsc: 'Data: Menos atual para mais atual',
        OrderBy.valueDesc: 'Valor: Maior para menor',
        OrderBy.valueAsc: 'Valor: Menor para maior',
      };

  final Function(OrderBy) onPressed;
  const OrderByBottomSheet({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        Text('Ordernar por', style: context.titleLarge),
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
