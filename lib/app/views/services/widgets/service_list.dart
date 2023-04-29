import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_services/app/app_cubit.dart';
import 'package:my_services/app/models/service.dart';
import 'package:my_services/app/shared/extensions/extensions.dart';
import 'package:my_services/app/shared/routes/app_routes.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/widgets/ads/ad_block.dart';

import 'service_card.dart';

class ServiceList extends StatelessWidget {
  const ServiceList({
    super.key,
    required this.services,
    this.canScroll = true,
    this.title,
    this.expandList = false,
  });

  final List<Service> services;
  final bool canScroll;
  final String? title;
  final bool expandList;

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
        padding: EdgeInsets.only(
          left: AppSizeConstants.largeSpace,
          right: AppSizeConstants.largeSpace,
          top: title == null
              ? AppSizeConstants.tinySpace
              : AppSizeConstants.largeSpace,
          bottom: AppSizeConstants.mediumSpace,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Column(
                children: [
                  Text(
                    title!.capitalize(),
                    style: context.titleSmall,
                  ),
                  AppSizeConstants.largeVerticalSpacer,
                ],
              ),
            expandList ? Expanded(child: getServiceList()) : getServiceList(),
          ],
        ),
      ),
    );
  }

  Widget getServiceList() {
    return ListView.separated(
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
    );
  }
}
