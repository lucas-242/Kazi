import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_services/app/shared/extensions/extensions.dart';

import '../../../models/service.dart';
import '../../themes/themes.dart';
import '../../utils/number_format_helper.dart';

class ServiceCard extends StatelessWidget {
  final Function(Service) onTapDelete;
  final Function(Service) onTapEdit;
  final Service service;

  const ServiceCard({
    super.key,
    required this.onTapDelete,
    required this.onTapEdit,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text('${service.type?.name}', style: context.tileTitle),
      subtitle: Text(
        DateFormat.yMd().format(service.date).normalizeDate(),
        style: context.bodySmall,
      ),
      // trailing: Icon(
      //   Icons.chevron_right,
      //   color: AppColors.grey,

      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            NumberFormatHelper.formatCurrency(
                context, service.valueWithDiscount),
            style: context.tileTitle!.copyWith(color: AppColors.green),
          ),
          const SizedBox(width: 25),
          const Icon(
            Icons.chevron_right,
            color: AppColors.grey,
          ),
        ],
      ),
    );
  }
}
