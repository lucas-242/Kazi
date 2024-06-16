import 'package:flutter/material.dart';
import 'package:kazi/core/l10n/generated/l10n.dart';
import 'package:kazi/core/utils/number_format_utils.dart';
import 'package:kazi_core/kazi_core.dart';
import 'package:kazi_design_system/kazi_design_system.dart';
import 'package:kazi_design_system/themes/themes.dart';

class ServiceTypeCard extends StatelessWidget {
  const ServiceTypeCard({
    super.key,
    required this.serviceType,
    required this.onTapEdit,
  });
  final Function(ServiceType) onTapEdit;
  final ServiceType serviceType;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(serviceType.name, style: context.titleSmall),
      subtitle: Text(
        '${NumberFormatUtils.formatPercent(serviceType.discountPercent)} ${AppLocalizations.current.discount.toLowerCase()}',
        style: context.labelSmall,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            NumberFormatUtils.formatCurrency(context, serviceType.defaultValue),
            style: context.titleSmall,
          ),
          KaziSpacings.horizontalLg,
          KaziCircularButton(
            onTap: () => onTapEdit(serviceType),
            child: const Icon(
              Icons.edit,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
