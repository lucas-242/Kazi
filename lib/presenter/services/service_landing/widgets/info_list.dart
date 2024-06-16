import 'package:flutter/material.dart';
import 'package:kazi/core/l10n/generated/l10n.dart';
import 'package:kazi/core/utils/number_format_utils.dart';
import 'package:kazi/presenter/services/components/info_card.dart';
import 'package:kazi_design_system/themes/themes.dart';

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
        left: KaziInsets.lg,
        right: KaziInsets.lg,
      ),
      children: [
        InfoCard(
          title: NumberFormatUtils.formatCurrency(context, totalWithDiscount),
          subtitle: AppLocalizations.current.myBalance,
          icon: KaziAssets.services,
          color: KaziColors.green,
          width: cardWidth,
        ),
        KaziSpacings.horizontalSm,
        InfoCard(
          title: NumberFormatUtils.formatCurrency(context, totalDiscounted),
          subtitle: AppLocalizations.current.discounts,
          icon: KaziAssets.fire,
          color: KaziColors.orange,
          width: cardWidth,
        ),
        KaziSpacings.horizontalSm,
        InfoCard(
          title: NumberFormatUtils.formatCurrency(context, totalValue),
          subtitle: AppLocalizations.current.totalReceived,
          icon: KaziAssets.rocket,
          color: KaziColors.blue,
          width: cardWidth,
        ),
      ],
    );
  }
}
