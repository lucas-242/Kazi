import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_services/app/app_cubit.dart';
import 'package:my_services/app/models/service.dart';
import 'package:my_services/app/shared/routes/app_routes.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/widgets/ads/ad_block.dart';

import 'service_card.dart';

class ServiceList extends StatelessWidget {
  final List<Service> services;
  final bool canScroll;

  const ServiceList({
    super.key,
    required this.services,
    this.canScroll = true,
  });

  void _onTap(BuildContext context, Service service) {
    var currentRoute = AppRoutes.services;
    if (context.read<AppCubit>().state == 0) {
      currentRoute = AppRoutes.home;
    }
    context.go('$currentRoute/${service.id}', extra: service);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppSizeConstants.largeSpace,
          right: AppSizeConstants.largeSpace,
          top: AppSizeConstants.tinySpace,
          bottom: AppSizeConstants.mediumSpace,
        ),
        child: ListView.separated(
          shrinkWrap: true,
          physics: canScroll
              ? const AlwaysScrollableScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          itemCount: services.length,
          itemBuilder: (context, index) {
            if (index != 0 && index % 2 == 0) {
              return AdBlock(
                child: ServiceCard(
                  service: services[index],
                  onTap: () => _onTap(context, services[index]),
                ),
              );
            }
            return ServiceCard(
              service: services[index],
              onTap: () => _onTap(context, services[index]),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        ),
      ),
    );
  }
}
