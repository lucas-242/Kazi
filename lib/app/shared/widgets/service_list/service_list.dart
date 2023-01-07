import 'package:flutter/material.dart';
import 'package:my_services/app/shared/extensions/extensions.dart';
import '../../l10n/generated/l10n.dart';
import '../../themes/themes.dart';
import '../service_list_total_card/service_list_total_card.dart';

import '../../../models/service.dart';
import '../service_card/service_card.dart';

class ServiceList extends StatelessWidget {
  final List<Service> services;
  final String title;
  final double totalValue;
  final double totalWithDiscount;
  final double totalDiscounted;
  final Function(Service) onTapEdit;
  final Function(Service) onTapDelete;
  final bool showDate;

  const ServiceList({
    super.key,
    required this.services,
    required this.totalValue,
    required this.totalWithDiscount,
    required this.totalDiscounted,
    required this.onTapEdit,
    required this.onTapDelete,
    required this.title,
    this.showDate = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ServiceListTotalCard(
                title: AppLocalizations.current.myBalance.capitalize(),
                value: totalWithDiscount,
                icon: Icons.savings,
              ),
              ServiceListTotalCard(
                title: AppLocalizations.current.discounts.capitalize(),
                value: totalDiscounted,
                icon: Icons.money_off,
              ),
              ServiceListTotalCard(
                title: AppLocalizations.current.totalReceived.capitalize(),
                value: totalValue,
                icon: Icons.attach_money,
              ),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: context.titleMedium),
              Text(
                '${services.length.toString()} ${services.length > 1 ? AppLocalizations.current.services : AppLocalizations.current.service}',
                style: context.titleMedium,
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: services.length,
              itemBuilder: (context, index) => ServiceCard(
                service: services[index],
                onTapEdit: onTapEdit,
                onTapDelete: onTapDelete,
                showDate: showDate,
              ),
              separatorBuilder: (context, index) => const Divider(),
            ),
          ),
        ],
      ),
    );
  }
}
