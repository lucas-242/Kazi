import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kazi/core/components/texts/row_text/row_text.dart';
import 'package:kazi/core/extensions/extensions.dart';
import 'package:kazi/core/l10n/generated/l10n.dart';
import 'package:kazi/core/routes/routes.dart';
import 'package:kazi/core/utils/number_format_utils.dart';
import 'package:kazi/presenter/services/services.dart';
import 'package:kazi_core/kazi_core.dart';
import 'package:kazi_design_system/kazi_design_system.dart';
import 'package:kazi_design_system/themes/themes.dart';

class ServiceDetailsPage extends StatelessWidget {
  const ServiceDetailsPage({super.key, required this.service});
  final Service service;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) => context.navigateBack(),
      child: KaziSafeArea(
        child: KaziSingleScrollView(
          children: [
            KaziBackAndPills(
              text: AppLocalizations.current.details,
              pills: [
                KaziPillButton(
                  onTap: () => context.navigateToAddServices(service),
                  child: Text(AppLocalizations.current.edit),
                ),
                KaziSpacings.horizontalXs,
                KaziPillButton(
                  backgroundColor: context.colorsScheme.error,
                  onTap: () => onTapDelete(context),
                  child: Text(AppLocalizations.current.delete),
                ),
              ],
            ),
            KaziSpacings.verticalLg,
            Card(
              child: Padding(
                padding: const EdgeInsets.all(KaziInsets.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${service.serviceType?.name}',
                      style: context.titleMedium,
                    ),
                    KaziSpacings.verticalSm,
                    Text(
                      DateFormat.yMd()
                          .format(service.scheduledToStartAt)
                          .normalizeDate(),
                      style: context.labelMedium,
                    ),
                    KaziSpacings.verticalXLg,
                    RowText(
                      leftText: AppLocalizations.current.myBalance,
                      rightText: NumberFormatUtils.formatCurrency(
                        context,
                        service.finalValue,
                      ),
                      rightTextStyle:
                          context.titleSmall!.copyWith(color: KaziColors.green),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: KaziInsets.lg,
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
                          .copyWith(color: KaziColors.orange),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: KaziInsets.lg,
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
                                  vertical: KaziInsets.lg,
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
                                  KaziSpacings.verticalSm,
                                  Text(
                                    service.description!,
                                    style: context.bodySmall,
                                  )
                                ],
                              ),
                              KaziSpacings.verticalSm,
                            ],
                          )
                        : KaziSpacings.verticalSm,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTapDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => KaziDialog(
        title: AppLocalizations.current.confirmAction,
        message: AppLocalizations.current
            .wouldYouLikeDelete(AppLocalizations.current.thisService),
        confirmText: AppLocalizations.current.delete,
        cancelText: AppLocalizations.current.cancel,
        onCancel: () => context.navigateBack(),
        onConfirm: () => onDelete(context, service),
      ),
    );
  }

  Future<void> onDelete(BuildContext context, Service service) async {
    context.navigateBack();
    final cubit = context.read<ServiceLandingCubit>();
    await cubit
        .deleteService(service)
        .then((_) => context.navigateTo(AppPages.services));
  }
}
