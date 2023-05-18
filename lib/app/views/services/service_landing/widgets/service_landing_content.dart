import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:kazi/app/models/enums.dart';
import 'package:kazi/app/services/services_service/services_service.dart';
import 'package:kazi/app/services/time_service/time_service.dart';
import 'package:kazi/app/shared/constants/app_onboarding.dart';
import 'package:kazi/app/shared/extensions/extensions.dart';
import 'package:kazi/app/shared/l10n/generated/l10n.dart';
import 'package:kazi/app/shared/routes/app_routes.dart';
import 'package:kazi/app/shared/themes/themes.dart';
import 'package:kazi/app/shared/widgets/layout/layout.dart';
import 'package:kazi/app/views/services/service_landing/widgets/info_list.dart';
import 'package:kazi/app/views/services/service_landing/widgets/service_navbar.dart';
import 'package:kazi/app/views/services/services.dart';
import 'package:kazi/injector_container.dart';

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
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizeConstants.largeSpace),
            child: OnboardingTooltip(
              onboardingKey: AppOnboarding.stepSeven,
              title: AppLocalizations.current.tourServicesListTitle,
              description: AppLocalizations.current.tourServicesListDescription,
              currentPage: 7,
              position: OnboardingTooltipPosition.top,
              onBackCallback: () => context.go(AppRoutes.addServiceType),
              targetPadding: const EdgeInsets.only(
                top: AppSizeConstants.smallSpace,
                left: AppSizeConstants.smallSpace,
                right: AppSizeConstants.smallSpace,
              ),
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
