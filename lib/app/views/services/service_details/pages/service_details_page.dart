import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:my_services/app/models/service.dart';
import 'package:my_services/app/shared/extensions/extensions.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/utils/number_format_helper.dart';
import 'package:my_services/app/shared/widgets/buttons/pills/back_and_pill.dart';

class ServiceDetailsPage extends StatelessWidget {
  final Service service;
  const ServiceDetailsPage({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: BackAndPill(
                pillText: AppLocalizations.current.share,
                onTapBack: () => context.pop(),
                onTapPill: () => null,
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${service.type?.name}',
                      style: context.titleMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      DateFormat.yMd().format(service.date).normalizeDate(),
                      style: context.labelMedium,
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.current.myBalance,
                          style: context.titleSmall,
                        ),
                        Text(
                          NumberFormatHelper.formatCurrency(
                            context,
                            service.value,
                          ),
                          style: context.titleSmall!
                              .copyWith(color: AppColors.green),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.current.discount,
                          style: context.titleSmall,
                        ),
                        Text(
                          NumberFormatHelper.formatCurrency(
                            context,
                            service.valueDiscounted,
                          ),
                          style: context.titleSmall!
                              .copyWith(color: AppColors.orange),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.current.totalReceived,
                          style: context.titleSmall,
                        ),
                        Text(
                          NumberFormatHelper.formatCurrency(
                            context,
                            service.valueWithDiscount,
                          ),
                          style: context.titleSmall,
                        )
                      ],
                    ),
                    service.description != null
                        ? Column(
                            children: [
                              const SizedBox(height: 20),
                              const Divider(),
                              const SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.current.description,
                                    style: context.titleSmall,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    service.description!,
                                    style: context.bodyMedium,
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          )
                        : const SizedBox.shrink()
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
