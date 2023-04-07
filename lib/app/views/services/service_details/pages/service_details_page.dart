import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_services/app/models/service.dart';
import 'package:my_services/app/shared/extensions/extensions.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/utils/number_format_helper.dart';
import 'package:my_services/app/shared/widgets/buttons/pills/back_and_pill.dart';
import 'package:my_services/app/shared/widgets/layout/layout.dart';
import 'package:my_services/app/shared/widgets/texts/row_text/row_text.dart';

class ServiceDetailsPage extends StatelessWidget {
  final Service service;
  const ServiceDetailsPage({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          BackAndPill(
            pillText: AppLocalizations.current.share,
            onTapPill: () => null,
          ),
          AppSizeConstants.largeVerticalSpacer,
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSizeConstants.largeSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${service.type?.name}',
                    style: context.titleMedium,
                  ),
                  AppSizeConstants.smallVerticalSpacer,
                  Text(
                    DateFormat.yMd().format(service.date).normalizeDate(),
                    style: context.labelMedium,
                  ),
                  AppSizeConstants.bigVerticalSpacer,
                  RowText(
                    leftText: AppLocalizations.current.myBalance,
                    rightText: NumberFormatHelper.formatCurrency(
                      context,
                      service.valueWithDiscount,
                    ),
                    rightTextStyle:
                        context.titleSmall!.copyWith(color: AppColors.green),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppSizeConstants.largeSpace,
                    ),
                    child: Divider(),
                  ),
                  RowText(
                    leftText: AppLocalizations.current.discount,
                    rightText: NumberFormatHelper.formatCurrency(
                      context,
                      service.valueDiscounted,
                    ),
                    rightTextStyle:
                        context.titleSmall!.copyWith(color: AppColors.orange),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppSizeConstants.largeSpace,
                    ),
                    child: Divider(),
                  ),
                  RowText(
                    leftText: AppLocalizations.current.totalReceived,
                    rightText: NumberFormatHelper.formatCurrency(
                      context,
                      service.value,
                    ),
                  ),
                  service.description != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: AppSizeConstants.largeSpace,
                              ),
                              child: Divider(),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.current.description,
                                  style: context.titleSmall,
                                ),
                                AppSizeConstants.smallVerticalSpacer,
                                Text(
                                  service.description!,
                                  style: context.bodySmall,
                                )
                              ],
                            ),
                            AppSizeConstants.smallVerticalSpacer,
                          ],
                        )
                      : AppSizeConstants.smallVerticalSpacer,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
