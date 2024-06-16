import 'package:flutter/material.dart';
import 'package:kazi/core/components/ads/ad_container.dart';
import 'package:kazi/core/constants/app_onboarding.dart';
import 'package:kazi/core/routes/routes.dart';
import 'package:kazi/presenter/services/components/service_card.dart';
import 'package:kazi_core/kazi_core.dart';
import 'package:kazi_design_system/themes/themes.dart';

class ServiceListContent extends StatelessWidget {
  const ServiceListContent({
    super.key,
    required this.services,
    required this.canScroll,
  });
  final List<Service> services;
  final bool canScroll;

  void _onTap(BuildContext context, Service service) => context.pushTo(
        AppPages.serviceDetails,
        service: service,
      );

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: canScroll
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      itemCount: services.length,
      itemBuilder: (context, index) {
        if (index != 0 && index % 2 == 0) {
          return AdContainer(
            child: ServiceCard(
              service: services[index],
              onTap: () => _onTap(context, services[index]),
            ),
          );
        }

        return ServiceCard(
          key: context.showOnboarding && index == 1
              ? AppOnboarding.stepEleven
              : null,
          service: services[index],
          onTap: () => _onTap(context, services[index]),
        );
      },
      separatorBuilder: (context, index) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: KaziInsets.lg),
        child: Divider(),
      ),
    );
  }
}
