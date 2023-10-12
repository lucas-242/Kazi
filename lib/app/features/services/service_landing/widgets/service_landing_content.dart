import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import 'package:kazi/app/core/constants/app_onboarding.dart';
import 'package:kazi/app/core/extensions/extensions.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/widgets/layout/layout.dart';
import 'package:kazi/app/features/services/service_landing/widgets/info_list.dart';
import 'package:kazi/app/features/services/service_landing/widgets/service_navbar.dart';
import 'package:kazi/app/features/services/services.dart';
import 'package:kazi/app/models/enums/fast_search.dart';
import 'package:kazi/app/services/services_service/services_service.dart';
import 'package:kazi/app/services/time_service/time_service.dart';
import 'package:kazi/service_locator.dart';

class ServiceLandingContent extends StatelessWidget {
  const ServiceLandingContent({
    super.key,
    required this.dateController,
    required this.state,
    this.showOnboarding = false,
  });
  final ServiceLandingState state;
  final MaskedTextController dateController;
  final bool showOnboarding;

  @override
  Widget build(BuildContext context) {
    return CustomSingleScrollView(
      children: [
        Column(
          key: showOnboarding ? AppOnboarding.stepTen : null,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizeConstants.largeSpace,
              ),
              child: ServiceNavbar(dateController: dateController),
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
        if (state.didFiltersChange)
          Padding(
            padding: const EdgeInsets.only(
              left: AppSizeConstants.largeSpace,
              right: AppSizeConstants.largeSpace,
              top: AppSizeConstants.mediumSpace,
            ),
            child: Text(title, style: context.titleSmall),
          ),
        AppSizeConstants.mediumVerticalSpacer,
        Padding(
          key: showOnboarding ? AppOnboarding.stepNine : null,
          padding: const EdgeInsets.symmetric(
              horizontal: AppSizeConstants.largeSpace),
          child: state.services.isNotEmpty
              ? ServiceListByDate(
                  servicesByDateList:
                      ServiceLocator.get<ServicesService>().groupServicesByDate(
                    state.services,
                    state.selectedOrderBy,
                  ),
                )
              : AppSizeConstants.emptyWidget,
        ),
      ],
    );
  }

  String get title {
    if (_showingLastMonthServices) {
      return AppLocalizations.current.filteringLastMonth;
    }

    if (state.fastSearch == FastSearch.today) {
      return AppLocalizations.current.filteringToday;
    }

    return AppLocalizations.current.filteringFromTo(
      DateFormat.yMd().format(state.startDate).normalizeDate(),
      DateFormat.yMd().format(state.endDate).normalizeDate(),
    );
  }

  bool get _showingLastMonthServices =>
      state.fastSearch == FastSearch.lastMonth ||
      ServiceLocator.get<TimeService>()
          .isRangeInLastMonth(state.startDate, state.endDate);
}
