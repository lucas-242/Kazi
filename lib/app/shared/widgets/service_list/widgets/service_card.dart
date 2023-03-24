import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_services/app/shared/extensions/extensions.dart';

import 'package:my_services/app/models/service.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/utils/number_format_helper.dart';

class ServiceCard extends StatelessWidget {
  final VoidCallback onTap;
  final Service service;

  const ServiceCard({
    super.key,
    required this.onTap,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text('${service.type?.name}', style: context.titleSmall),
      subtitle: Text(
        DateFormat.yMd().format(service.date).normalizeDate(),
        style: context.labelSmall,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            NumberFormatHelper.formatCurrency(
                context, service.valueWithDiscount),
            style: context.titleSmall!.copyWith(color: AppColors.green),
          ),
          const SizedBox(width: 25),
          IconButton(
            onPressed: onTap,
            icon: const Icon(
              Icons.chevron_right,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
