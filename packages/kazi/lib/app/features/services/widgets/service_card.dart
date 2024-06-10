import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kazi/app/core/extensions/extensions.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/utils/number_format_utils.dart';
import 'package:kazi/app/models/service.dart';

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
      splashColor: AppColors.lightGrey,
      highlightColor: AppColors.lightGrey,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: AppInsets.lg),
        title: Text('${service.serviceType?.name}', style: context.titleSmall),
        subtitle: Text(
          DateFormat.yMd().format(service.scheduledToStartAt).normalizeDate(),
          style: context.labelSmall,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              NumberFormatUtils.formatCurrency(context, service.finalValue),
              style: context.titleSmall!.copyWith(color: AppColors.green),
            ),
            AppSpacings.horizontalLg,
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
