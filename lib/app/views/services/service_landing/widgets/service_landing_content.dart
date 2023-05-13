import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:my_services/app/models/enums.dart';
import 'package:my_services/app/services/services_service/services_service.dart';
import 'package:my_services/app/services/time_service/time_service.dart';
import 'package:my_services/app/shared/constants/app_onboarding.dart';
import 'package:my_services/app/shared/extensions/extensions.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/routes/app_routes.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/widgets/layout/layout.dart';
import 'package:my_services/app/views/services/service_landing/widgets/info_list.dart';
import 'package:my_services/app/views/services/service_landing/widgets/service_navbar.dart';
import 'package:my_services/app/views/services/services.dart';
import 'package:my_services/injector_container.dart';

class ServiceLandingContent extends StatelessWidget {
  final ServiceLandingState state;
  final GlobalKey<FormFieldState> dateKey;
  final MaskedTextController dateController;

  const ServiceLandingContent({
    super.key,
    required this.dateKey,
    required this.dateController,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          OnboardingTooltip(
            onboardingKey: AppOnboarding.stepEight,
            title: AppLocalizations.current.tourServicesInfoTitle,
            description: AppLocalizations.current.tourServicesInfoDescription,
            currentPage: 8,
            targetPadding: const EdgeInsets.only(
              top: AppSizeConstants.largeSpace,
              bottom: AppSizeConstants.mediumSpace,
              left: AppSizeConstants.largeSpace,
              right: AppSizeConstants.largeSpace,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizeConstants.largeSpace,
                  ),
                  child: ServiceNavbar(
                    dateKey: dateKey,
                    dateController: dateController,
                  ),
                ),
                AppSizeConstants.mediumVerticalSpacer,
                SizedBox(
                  height: 105,
                  child: InfoList(
                    totalValue: state.totalValue,
                    totalDiscounted: state.totalDiscounted,
                    totalWithDiscount: state.totalWithDiscount,
                  ),
                ),
              ],
            ),
          ),
          AppSizeConstants.mediumVerticalSpacer,
          OnboardingTooltip(
            onboardingKey: AppOnboarding.stepSeven,
            title: AppLocalizations.current.tourServicesListTitle,
            description: AppLocalizations.current.tourServicesListDescription,
            currentPage: 7,
            position: OnboardingTooltipPosition.top,
            onBackCallback: () => context.go(AppRoutes.addServiceType),
            targetPadding: const EdgeInsets.only(
              top: AppSizeConstants.largeSpace,
              bottom: AppSizeConstants.mediumSpace,
              left: AppSizeConstants.largeSpace,
              right: AppSizeConstants.largeSpace,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizeConstants.largeSpace),
              child: _getServiceList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getServiceList() {
    final timeService = serviceLocator<TimeService>();
    final servicesService = serviceLocator<ServicesService>();

    if (state.fastSearch == FastSearch.lastMonth ||
        timeService.isRangeInLastMonth(state.startDate, state.endDate)) {
      return ServiceList(
        title: AppLocalizations.current.filteringLastMonth,
        services: state.services,
      );
    }
    if (!timeService.isRangeInThisMonth(state.startDate, state.endDate)) {
      return ServiceList(
        title: AppLocalizations.current.fromTo(
          DateFormat.yMd().format(state.startDate).normalizeDate(),
          DateFormat.yMd().format(state.endDate).normalizeDate(),
        ),
        services: state.services,
      );
    }

    return ServiceListByDate(
      servicesByDateList: servicesService.groupServicesByDate(state.services),
    );
  }
}
