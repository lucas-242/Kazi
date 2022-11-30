import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_services/models/service_type.dart';

import '../../../shared/widgets/custom_slidable/custom_slidable.dart';

class ServiceTypeCard extends StatelessWidget {
  final Function(ServiceType) onTapDelete;
  final Function(ServiceType) onTapEdit;
  final ServiceType serviceType;

  const ServiceTypeCard({
    super.key,
    required this.serviceType,
    required this.onTapDelete,
    required this.onTapEdit,
  });

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
            Text(serviceType.name),
            Text(NumberFormat.currency(symbol: 'R\$')
                .format(serviceType.defaultValue)),
          ],
        ),
        subtitle: Text('${serviceType.discountPercent ?? 0}%'),
      ),
    );
  }
}
