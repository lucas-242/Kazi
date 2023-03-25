import 'package:flutter/material.dart';
import 'package:my_services/app/shared/utils/number_format_helper.dart';
import 'package:my_services/app/models/service_type.dart';

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
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(serviceType.name),
          Text(NumberFormatHelper.formatCurrency(
              context, serviceType.defaultValue)),
        ],
      ),
      subtitle: Text('${serviceType.discountPercent ?? 0}%'),
    );
  }
}
