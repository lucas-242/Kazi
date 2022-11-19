import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/service_provided.dart';
import '../custom_slidable/custom_slidable.dart';

class ServiceCard extends StatelessWidget {
  final Function(ServiceProvided) onTapDelete;
  final Function(ServiceProvided) onTapEdit;
  final ServiceProvided serviceType;

  const ServiceCard(
      {super.key,
      required this.onTapDelete,
      required this.onTapEdit,
      required this.serviceType});

  @override
  Widget build(BuildContext context) {
    return CustomSlidable(
      leftPanel: true,
      rightPanel: true,
      onLeftSlide: () => onTapEdit(serviceType),
      onRightSlide: () => onTapDelete(serviceType),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${serviceType.type?.name}'),
            Text(NumberFormat.currency(symbol: 'R\$')
                .format(serviceType.valueWithDiscount)),
          ],
        ),
        subtitle: Text(serviceType.description ?? ''),
      ),
    );
  }
}
