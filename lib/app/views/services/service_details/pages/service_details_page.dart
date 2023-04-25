import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:my_services/app/app_cubit.dart';
import 'package:my_services/app/models/service.dart';
import 'package:my_services/app/shared/extensions/extensions.dart';
import 'package:my_services/app/shared/routes/app_routes.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/utils/number_format_helper.dart';
import 'package:my_services/app/shared/widgets/buttons/buttons.dart';
import 'package:my_services/app/shared/widgets/layout/layout.dart';
import 'package:my_services/app/shared/widgets/texts/row_text/row_text.dart';
import 'package:my_services/app/views/services/services.dart';

class ServiceDetailsPage extends StatelessWidget {
  final Service service;
  const ServiceDetailsPage({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    Future<void> onDelete(Service service) async {
      context.pop();
      final cubit = context.read<ServiceLandingCubit>();
      await cubit
          .deleteService(service)
          .then((value) => context.go(AppRoutes.services));
    }

    void onTapDelete() {
      showDialog(
        context: context,
        builder: (context) => ConfirmationDialog(
          message: context.appLocalizations
              .wouldYouLikeDelete(context.appLocalizations.thisService),
          confirmText: context.appLocalizations.delete,
          onCancel: () => context.pop(),
          onConfirm: () => onDelete(service),
        ),
      );
    }

    void onTapUpdate() {
      context.read<AppCubit>().changeToAddServicePage();
      context.go(AppRoutes.addServices, extra: service);
    }

    return CustomScaffold(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircularButton(
                      onTap: () => context.pop(),
                      child: const Icon(Icons.chevron_left),
                    ),
                    Text(
                      context.appLocalizations.serviceDetails,
                      style: context.titleMedium,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PillButton(
                      onTap: onTapUpdate,
                      child: Text(context.appLocalizations.edit),
                    ),
                    AppSizeConstants.tinyHorizontalSpacer,
                    PillButton(
                      backgroundColor: context.colorsScheme.error,
                      onTap: onTapDelete,
                      child: Text(context.appLocalizations.delete),
                    ),
                  ],
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
                      leftText: context.appLocalizations.myBalance,
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
                      leftText: context.appLocalizations.discount,
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
                      leftText: context.appLocalizations.totalReceived,
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
                                    context.appLocalizations.description,
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
    );
  }
}
