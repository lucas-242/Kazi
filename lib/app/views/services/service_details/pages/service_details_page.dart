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
      body: Column(
        children: [
          BackAndPill(
            pillText: AppLocalizations.current.share,
            onTapBack: () => context.pop(),
            onTapPill: () => null,
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text('${service.type?.name}'),
                  Text(
                    DateFormat.yMd().format(service.date).normalizeDate(),
                    style: context.bodySmall,
                  ),
                  Row(
                    children: [
                      Text(AppLocalizations.current.myBalance),
                      Text(
                        NumberFormatHelper.formatCurrency(
                          context,
                          service.value,
                        ),
                      )
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Text(AppLocalizations.current.discount),
                      Text(
                        NumberFormatHelper.formatCurrency(
                          context,
                          service.valueDiscounted,
                        ),
                      )
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Text(AppLocalizations.current.totalReceived),
                      Text(
                        NumberFormatHelper.formatCurrency(
                          context,
                          service.valueWithDiscount,
                        ),
                      )
                    ],
                  ),
                  service.description != null
                      ? Column(
                          children: [
                            const Divider(),
                            Column(
                              children: [
                                Text(AppLocalizations.current.description),
                                Text(service.description!)
                              ],
                            ),
                          ],
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
