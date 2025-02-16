import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kazi/app/shared/extensions/extensions.dart';

import 'package:kazi/app/models/service.dart';
import 'package:kazi/app/shared/themes/themes.dart';
import 'package:kazi/app/shared/utils/number_format_helper.dart';

class ServiceCard extends StatelessWidget {

  const ServiceCard({
    super.key,
    required this.onTap,
    required this.service,
  });
  final VoidCallback onTap;
  final Service service;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
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
                  context, service.valueWithDiscount,),
              style: context.titleSmall!.copyWith(color: AppColors.green),
            ),
            AppSizeConstants.largeHorizontalSpacer,
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
