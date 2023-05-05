import 'package:flutter/material.dart';
import 'package:my_services/app/shared/extensions/extensions.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/utils/number_format_helper.dart';
import 'package:my_services/app/views/services/widgets/info_card.dart';

class InfoList extends StatelessWidget {
  const InfoList(
      {super.key,
      required this.totalValue,
      required this.totalDiscounted,
      required this.totalWithDiscount});
  final double totalValue;
  final double totalDiscounted;
  final double totalWithDiscount;

  @override
  Widget build(BuildContext context) {
    final cardWidth = context.width * .57;
    return ListView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(
        left: AppSizeConstants.largeSpace,
        right: AppSizeConstants.largeSpace,
      ),
      children: [
        InfoCard(
          title: NumberFormatHelper.formatCurrency(context, totalWithDiscount),
          subtitle: context.appLocalizations.myBalance,
          icon: AppAssets.services,
          color: AppColors.green,
          width: cardWidth,
        ),
        AppSizeConstants.mediumHorizontalSpacer,
        InfoCard(
          title: NumberFormatHelper.formatCurrency(context, totalDiscounted),
          subtitle: context.appLocalizations.discounts,
          icon: AppAssets.fire,
          color: AppColors.orange,
          width: cardWidth,
        ),
        AppSizeConstants.mediumHorizontalSpacer,
        InfoCard(
          title: NumberFormatHelper.formatCurrency(context, totalValue),
          subtitle: context.appLocalizations.totalReceived,
          icon: AppAssets.rocket,
          color: AppColors.blue,
          width: cardWidth,
        ),
      ],
    );
  }
}
