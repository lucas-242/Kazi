import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:my_services/shared/themes/themes.dart';

import '../../../models/service_provided.dart';
import '../service_card/service_card.dart';

class ServiceList extends StatelessWidget {
  final List<ServiceProvided> services;
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
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: services.length,
          itemBuilder: (context, index) => ServiceCard(
            serviceType: services[index],
            onTapEdit: onTapEdit,
            onTapDelete: onTapDelete,
          ),
        ),
        const SizedBox(height: 25),
        Text(
            'Valor total: ${NumberFormat.currency(symbol: 'R\$').format(totalValue)}',
            style: context.bodyMedium),
        const SizedBox(height: 15),
        Text(
            'Valor recebido: ${NumberFormat.currency(symbol: 'R\$').format(totalWithDiscount)}',
            style: context.bodyMedium),
        const SizedBox(height: 15),
        Text(
            'Valor descontado: ${NumberFormat.currency(symbol: 'R\$').format(totalDiscounted)}',
            style: context.bodyMedium)
      ],
    );
  }
}
