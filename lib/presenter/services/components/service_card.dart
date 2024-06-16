import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kazi/core/extensions/extensions.dart';
import 'package:kazi/core/utils/number_format_utils.dart';
import 'package:kazi_core/kazi_core.dart';
import 'package:kazi_design_system/themes/themes.dart';

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
      splashColor: KaziColors.lightGrey,
      highlightColor: KaziColors.lightGrey,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: KaziInsets.lg),
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
              style: context.titleSmall!.copyWith(color: KaziColors.green),
            ),
            KaziSpacings.horizontalLg,
            const Icon(
              Icons.chevron_right,
              color: KaziColors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
