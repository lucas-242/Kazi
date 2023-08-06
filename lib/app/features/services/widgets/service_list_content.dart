import 'package:flutter/material.dart';
import 'package:kazi/app/data/local_storage/local_storage.dart';
import 'package:kazi/app/features/services/widgets/service_card.dart';
import 'package:kazi/app/models/service.dart';
import 'package:kazi/app/core/constants/app_keys.dart';
import 'package:kazi/app/core/constants/app_onboarding.dart';
import 'package:kazi/app/core/extensions/extensions.dart';
import 'package:kazi/app/core/widgets/ads/ad_block.dart';
import 'package:kazi/injector_container.dart';

class ServiceListContent extends StatelessWidget {
  const ServiceListContent({
    super.key,
    required this.services,
    required this.canScroll,
  });
  final List<Service> services;
  final bool canScroll;

  void _onTap(BuildContext context, Service service) => context.navigateTo(
        context.currentPage == AppPage.home
            ? AppPage.home
            : AppPage.serviceDetails,
        service: service,
      );

  @override
  Widget build(BuildContext context) {
    final showOnboarding = serviceLocator
            .get<LocalStorage>()
            .get<bool>(AppKeys.showOnboardingStorage) ??
        true;

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
          key: showOnboarding && index == 1 ? AppOnboarding.stepEleven : null,
          service: services[index],
          onTap: () => _onTap(context, services[index]),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}