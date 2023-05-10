import 'package:flutter/material.dart';
import 'package:my_services/app/models/service_group_by_date.dart';
import 'package:my_services/app/shared/constants/app_onboarding.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/routes/router.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/widgets/layout/layout.dart';
import 'package:my_services/app/views/services/widgets/service_date_card.dart';

class ServiceListByDate extends StatefulWidget {
  const ServiceListByDate({
    Key? key,
    required this.servicesByDateList,
    this.showOnboarding = false,
  }) : super(key: key);

  final List<ServicesGroupByDate> servicesByDateList;
  final bool showOnboarding;

  @override
  State<ServiceListByDate> createState() => _ServiceListByDateState();
}

class _ServiceListByDateState extends State<ServiceListByDate> {
  void onTap(ServicesGroupByDate servicesByDate, int index) => setState(() {
        widget.servicesByDateList[index] =
            servicesByDate.copyWith(isExpaded: !servicesByDate.isExpanded);
      });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.servicesByDateList.length,
      itemBuilder: (context, index) {
        final servicesByDate = widget.servicesByDateList[index];
        if (showOnboarding && index == 1) {
          return OnboardingTooltip(
            onboardingKey: AppOnboarding.stepEight,
            title: AppLocalizations.current.tourHomeBalanceTitle,
            description: AppLocalizations.current.tourHomeBalanceDescription,
            currentPage: 8,
            targetPadding: const EdgeInsets.only(
              top: AppSizeConstants.largeSpace,
              bottom: AppSizeConstants.mediumSpace,
              left: AppSizeConstants.largeSpace,
              right: AppSizeConstants.largeSpace,
            ),
            child: ServiceDateCard(
              servicesByDate: servicesByDate,
              onTap: () => onTap(servicesByDate, index),
            ),
          );
        }

        return ServiceDateCard(
          servicesByDate: servicesByDate,
          onTap: () => onTap(servicesByDate, index),
        );
      },
      separatorBuilder: (context, index) =>
          AppSizeConstants.smallVerticalSpacer,
    );
  }
}
