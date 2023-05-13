import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_services/app/app_cubit.dart';
import 'package:my_services/app/models/service.dart';
import 'package:my_services/app/shared/constants/app_onboarding.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/routes/app_routes.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/widgets/ads/ad_block.dart';
import 'package:my_services/app/shared/widgets/layout/layout.dart';
import 'package:my_services/app/views/services/widgets/service_card.dart';

class ServiceListContent extends StatelessWidget {
  const ServiceListContent({
    super.key,
    required this.services,
    required this.canScroll,
  });
  final List<Service> services;
  final bool canScroll;

  void _onTap(BuildContext context, Service service) {
    var currentRoute = AppRoutes.services;
    if (context.read<AppCubit>().state == 0) {
      currentRoute = AppRoutes.home;
    }
    context.go('$currentRoute/${service.id}', extra: service);
  }

  void _onNextCallback(BuildContext context) {
    context.read<AppCubit>().changeToAddServicePage();
    context.go(AppRoutes.addServices);
  }

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
          return AdBlock(
            child: ServiceCard(
              service: services[index],
              onTap: () => _onTap(context, services[index]),
            ),
          );
        }
        if (index == 1) {
          return OnboardingTooltip(
            onboardingKey: AppOnboarding.stepNine,
            title: AppLocalizations.current.tourServiceDetailsTitle,
            description: AppLocalizations.current.tourServiceDetailsDescription,
            currentPage: 9,
            onNextCallback: () => _onNextCallback(context),
            targetPadding: const EdgeInsets.only(
              top: AppSizeConstants.tinySpace,
              left: AppSizeConstants.largeSpace,
              right: AppSizeConstants.largeSpace,
            ),
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
