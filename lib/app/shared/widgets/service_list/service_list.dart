import 'package:flutter/material.dart';

import '../ads/ad_block.dart';
import '../../../models/service.dart';
import '../service_card/service_card.dart';

class ServiceList extends StatelessWidget {
  final List<Service> services;
  final Function(Service) onTapEdit;
  final Function(Service) onTapDelete;

  const ServiceList({
    super.key,
    required this.services,
    required this.onTapEdit,
    required this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: services.length,
            itemBuilder: (context, index) {
              if (index != 0 && index % 2 == 0) {
                return AdBlock(
                  child: ServiceCard(
                    service: services[index],
                    onTapEdit: onTapEdit,
                    onTapDelete: onTapDelete,
                  ),
                );
              }
              return ServiceCard(
                service: services[index],
                onTapEdit: onTapEdit,
                onTapDelete: onTapDelete,
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          ),
        ),
      ),
    );
  }
}
