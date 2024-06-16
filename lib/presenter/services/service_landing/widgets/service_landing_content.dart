import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import 'package:kazi/core/constants/app_onboarding.dart';
import 'package:kazi/core/extensions/extensions.dart';
import 'package:kazi/core/l10n/generated/l10n.dart';
import 'package:kazi/domain/services/services_service.dart';
import 'package:kazi/domain/services/time_service.dart';
import 'package:kazi/presenter/services/service_landing/widgets/info_list.dart';
import 'package:kazi/presenter/services/service_landing/widgets/service_navbar.dart';
import 'package:kazi/presenter/services/services.dart';
import 'package:kazi/service_locator.dart';
import 'package:kazi_core/kazi_core.dart';
import 'package:kazi_design_system/kazi_design_system.dart';
import 'package:kazi_design_system/themes/themes.dart';

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
    return KaziSingleScrollView(
      children: [
        Column(
          key: showOnboarding ? AppOnboarding.stepTen : null,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: KaziInsets.lg,
              ),
              child: ServiceNavbar(dateController: dateController),
            ),
            KaziSpacings.verticalMd,
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
              left: KaziInsets.lg,
              right: KaziInsets.lg,
              top: KaziInsets.md,
            ),
            child: Text(title, style: context.titleSmall),
          ),
        KaziSpacings.verticalMd,
        Padding(
          key: showOnboarding ? AppOnboarding.stepNine : null,
          padding: const EdgeInsets.symmetric(horizontal: KaziInsets.lg),
          child: state.services.isNotEmpty
              ? ServiceListByDate(
                  servicesByDateList:
                      ServiceLocator.get<ServicesService>().groupServicesByDate(
                    state.services,
                    state.selectedOrderBy,
                  ),
                )
              : const SizedBox.shrink(),
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
