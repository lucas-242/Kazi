import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kazi/app/models/service.dart';
import 'package:kazi/app/shared/extensions/extensions.dart';
import 'package:kazi/app/shared/l10n/generated/l10n.dart';
import 'package:kazi/app/shared/themes/themes.dart';
import 'package:kazi/app/shared/utils/number_format_helper.dart';
import 'package:kazi/app/shared/widgets/buttons/buttons.dart';
import 'package:kazi/app/shared/widgets/layout/layout.dart';
import 'package:kazi/app/shared/widgets/texts/row_text/row_text.dart';
import 'package:kazi/app/views/services/services.dart';

class ServiceDetailsPage extends StatelessWidget {
  const ServiceDetailsPage({super.key, required this.service});
  final Service service;

  @override
  Widget build(BuildContext context) {
    Future<void> onDelete(Service service) async {
      context.back();
      final cubit = context.read<ServiceLandingCubit>();
      await cubit.deleteService(service).then((_) {
        if (context.mounted) context.navigateTo(AppPage.services);
      });
    }

    void onTapDelete() {
      showDialog(
        context: context,
        builder: (context) => ConfirmationDialog(
          message: AppLocalizations.current
              .wouldYouLikeDelete(AppLocalizations.current.thisService),
          confirmText: AppLocalizations.current.delete,
          onCancel: () => context.back(),
          onConfirm: () => onDelete(service),
        ),
      );
    }

    return CustomSafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            BackAndPills(
              text: AppLocalizations.current.details,
              pills: [
                PillButton(
                  onTap: () =>
                      context.navigateTo(AppPage.addServices, service: service),
                  child: Text(AppLocalizations.current.edit),
                ),
                AppSizeConstants.tinyHorizontalSpacer,
                PillButton(
                  backgroundColor: context.colorsScheme.error,
                  onTap: onTapDelete,
                  child: Text(AppLocalizations.current.delete),
                ),
              ],
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
                                  ),
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
      ),
    );
  }
}
