import 'package:flutter/material.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/utils/number_format_utils.dart';
import 'package:kazi/app/features/services/widgets/info_card.dart';

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
          title: NumberFormatUtils.formatCurrency(context, totalWithDiscount),
          subtitle: AppLocalizations.current.myBalance,
          icon: AppAssets.services,
          color: AppColors.green,
          width: cardWidth,
        ),
        AppSizeConstants.smallHorizontalSpacer,
        InfoCard(
          title: NumberFormatUtils.formatCurrency(context, totalDiscounted),
          subtitle: AppLocalizations.current.discounts,
          icon: AppAssets.fire,
          color: AppColors.orange,
          width: cardWidth,
        ),
        AppSizeConstants.smallHorizontalSpacer,
        InfoCard(
          title: NumberFormatUtils.formatCurrency(context, totalValue),
          subtitle: AppLocalizations.current.totalReceived,
          icon: AppAssets.rocket,
          color: AppColors.blue,
          width: cardWidth,
        ),
      ],
    );
  }
}
