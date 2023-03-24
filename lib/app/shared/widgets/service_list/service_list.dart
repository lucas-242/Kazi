import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:my_services/app/models/service.dart';
import 'package:my_services/app/shared/routes/app_routes.dart';
import 'package:my_services/app/shared/widgets/ads/ad_block.dart';
import 'widgets/service_card.dart';

class ServiceList extends StatelessWidget {
  final List<Service> services;

  const ServiceList({
    super.key,
    required this.services,
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
                    onTap: () => context.go(
                      '${AppRoutes.services}/${services[index].id}',
                      extra: services[index],
                    ),
                  ),
                );
              }
              return ServiceCard(
                service: services[index],
                onTap: () => context.go(
                  '${AppRoutes.services}/${services[index].id}',
                  extra: services[index],
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          ),
        ),
      ),
    );
  }
}
