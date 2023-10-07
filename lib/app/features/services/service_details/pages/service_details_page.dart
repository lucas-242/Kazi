import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kazi/app/core/extensions/extensions.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/routes/routes.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/utils/number_format_utils.dart';
import 'package:kazi/app/core/widgets/buttons/buttons.dart';
import 'package:kazi/app/core/widgets/layout/layout.dart';
import 'package:kazi/app/core/widgets/texts/row_text/row_text.dart';
import 'package:kazi/app/features/services/services.dart';
import 'package:kazi/app/models/service.dart';

class ServiceDetailsPage extends StatelessWidget {
  const ServiceDetailsPage({super.key, required this.service});
  final Service service;

  @override
  Widget build(BuildContext context) {
    Future<void> onDelete(Service service) async {
      context.navigateBack();
      final cubit = context.read<ServiceLandingCubit>();
      await cubit
          .deleteService(service)
          .then((_) => context.navigateTo(AppPages.services));
    }

    void onTapDelete() {
      showDialog(
        context: context,
        builder: (context) => ConfirmationDialog(
          message: AppLocalizations.current
              .wouldYouLikeDelete(AppLocalizations.current.thisService),
          confirmText: AppLocalizations.current.delete,
          onCancel: () => context.navigateBack(),
          onConfirm: () => onDelete(service),
        ),
      );
    }

    return BlocBuilder<ServiceLandingCubit, ServiceLandingState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) => state.when(
        onLoading: () => const Loading(),
        onState: (_) => CustomSafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                BackAndPills(
                  text: AppLocalizations.current.details,
                  pills: [
                    PillButton(
                      onTap: () => context.navigateTo(AppPages.addServices,
                          service: service),
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
                          '${service.serviceType?.name}',
                          style: context.titleMedium,
                        ),
                        AppSizeConstants.smallVerticalSpacer,
                        Text(
                          DateFormat.yMd()
                              .format(service.scheduledToStartAt)
                              .normalizeDate(),
                          style: context.labelMedium,
                        ),
                        AppSizeConstants.bigVerticalSpacer,
                        RowText(
                          leftText: AppLocalizations.current.myBalance,
                          rightText: NumberFormatUtils.formatCurrency(
                            context,
                            service.finalValue,
                          ),
                          rightTextStyle: context.titleSmall!
                              .copyWith(color: AppColors.green),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: AppSizeConstants.largeSpace,
                          ),
                          child: Divider(),
                        ),
                        RowText(
                          leftText: AppLocalizations.current.discount,
                          rightText: NumberFormatUtils.formatCurrency(
                            context,
                            service.discountValue,
                          ),
                          rightTextStyle: context.titleSmall!
                              .copyWith(color: AppColors.orange),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: AppSizeConstants.largeSpace,
                          ),
                          child: Divider(),
                        ),
                        RowText(
                          leftText: AppLocalizations.current.totalReceived,
                          rightText: NumberFormatUtils.formatCurrency(
                            context,
                            service.value,
                          ),
                        ),
                        service.description?.isNotEmpty ?? false
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
          ),
        ),
      ),
    );
  }
}
