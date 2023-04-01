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
    return InkWell(
      onTap: onTap,
      child: ListTile(
        contentPadding:
            const EdgeInsets.only(top: 15, bottom: 10, left: 20, right: 20),
        title: Text('${service.type?.name}', style: context.titleSmall),
        subtitle: Text(
          DateFormat.yMd().format(service.date).normalizeDate(),
          style: context.labelSmall,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              NumberFormatHelper.formatCurrency(
                  context, service.valueWithDiscount),
              style: context.titleSmall!.copyWith(color: AppColors.green),
            ),
            AppSizeConstants.mediumHorizontalSpacer,
            const Icon(
              Icons.chevron_right,
              color: AppColors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
