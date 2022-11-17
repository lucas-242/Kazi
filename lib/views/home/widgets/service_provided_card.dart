import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_services/models/service_provided.dart';

import '../../../shared/widgets/custom_slidable/custom_slidable.dart';

class ServiceProvidedCard extends StatelessWidget {
  final Function(ServiceProvided) onTapDelete;
  final Function(ServiceProvided) onTapEdit;
  final ServiceProvided serviceType;

  const ServiceProvidedCard(
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
