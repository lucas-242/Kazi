import 'package:flutter/material.dart';
import 'package:my_services/shared/themes/themes.dart';
import 'package:my_services/shared/widgets/service_list_total_card/service_list_total_card.dart';

import '../../../models/service_provided.dart';
import '../service_card/service_card.dart';

class ServiceList extends StatelessWidget {
  final List<ServiceProvided> services;
  final String title;
  final double totalValue;
  final double totalWithDiscount;
  final double totalDiscounted;
  final Function(ServiceProvided) onTapEdit;
  final Function(ServiceProvided) onTapDelete;
  const ServiceList({
    super.key,
    required this.services,
    required this.totalValue,
    required this.totalWithDiscount,
    required this.totalDiscounted,
    required this.onTapEdit,
    required this.onTapDelete,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ServiceListTotalCard(
              title: 'Total',
              value: totalValue,
              icon: Icons.attach_money,
            ),
            ServiceListTotalCard(
              title: 'Recebido',
              value: totalWithDiscount,
              icon: Icons.savings,
            ),
            ServiceListTotalCard(
              title: 'Desconto',
              value: totalDiscounted,
              icon: Icons.money_off,
            ),
          ],
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: context.titleMedium),
            Text(
              '${services.length.toString()} Serviço${services.length > 1 ? "s" : ""}',
              style: context.titleMedium,
            ),
          ],
        ),
        const Divider(),
        const SizedBox(height: 10),
        ListView.separated(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: services.length,
          itemBuilder: (context, index) => ServiceCard(
            service: services[index],
            onTapEdit: onTapEdit,
            onTapDelete: onTapDelete,
          ),
          separatorBuilder: (context, index) => const Divider(),
        ),
      ],
    );
  }
}
