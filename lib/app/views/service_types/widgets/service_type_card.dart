import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/routes/app_routes.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/utils/number_format_helper.dart';
import 'package:my_services/app/models/service_type.dart';
import 'package:my_services/app/shared/widgets/buttons/buttons.dart';

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
      title: Text(serviceType.name, style: context.titleSmall),
      subtitle: Text(
        '${NumberFormatHelper.formatPercent(serviceType.discountPercent)} ${AppLocalizations.current.discount.toLowerCase()}',
        style: context.labelSmall,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            NumberFormatHelper.formatCurrency(
                context, serviceType.defaultValue),
            style: context.titleSmall,
          ),
          AppSizeConstants.largeHorizontalSpacer,
          CircularButton(
            onTap: () => context.go(AppRoutes.addServiceType),
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
