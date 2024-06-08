import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import 'package:kazi/app/core/constants/app_onboarding.dart';
import 'package:kazi/app/core/extensions/extensions.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/themes/themes.dart';
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
    required this.dateKey,
    required this.dateController,
    required this.state,
  });
  final ServiceLandingState state;
  final GlobalKey<FormFieldState> dateKey;
  final MaskedTextController dateController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            key: AppOnboarding.stepTen,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppInsets.lg,
                ),
                child: ServiceNavbar(
                  dateKey: dateKey,
                  dateController: dateController,
                ),
              ),
              AppSpacings.verticalMd,
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
          AppSpacings.verticalMd,
          Padding(
            key: AppOnboarding.stepNine,
            padding: const EdgeInsets.symmetric(horizontal: AppInsets.lg),
            child: _getServiceList(),
          ),
        ],
      ),
    );
  }

  Widget _getServiceList() {
    final servicesService = ServiceLocator.get<ServicesService>();

    if (_showLastMonthServices()) {
      return ServiceList(
        title: AppLocalizations.current.filteringLastMonth,
        services: state.services,
      );
    }
    if (_showServicesAreNotInCurrentMonth()) {
      return ServiceList(
        title: AppLocalizations.current.fromTo(
          DateFormat.yMd().format(state.startDate).normalizeDate(),
          DateFormat.yMd().format(state.endDate).normalizeDate(),
        ),
        services: state.services,
      );
    }

    return ServiceListByDate(
      servicesByDateList: servicesService.groupServicesByDate(
        state.services,
        state.selectedOrderBy,
      ),
    );
  }

  bool _showLastMonthServices() =>
      state.fastSearch == FastSearch.lastMonth ||
      ServiceLocator.get<TimeService>()
          .isRangeInLastMonth(state.startDate, state.endDate);

  bool _showServicesAreNotInCurrentMonth() => !ServiceLocator.get<TimeService>()
      .isRangeInThisMonth(state.startDate, state.endDate);
}
