import 'package:flutter/material.dart';
import 'package:my_services/models/service_type.dart';

import '../../../shared/widgets/custom_slidable/custom_slidable.dart';

class ServiceTypeCard extends StatelessWidget {
  final Function(ServiceType) onTapDelete;
  final ServiceType serviceType;

  const ServiceTypeCard({
    super.key,
    required this.serviceType,
    required this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    return CustomSlidable(
      leftPanel: true,
      rightPanel: true,
      onRightSlide: () => onTapDelete(serviceType),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(serviceType.name),
            Text('${serviceType.defaultValue}'),
          ],
        ),
        subtitle: Text('${serviceType.discountPercent ?? 0}%'),
      ),
    );
  }
}
