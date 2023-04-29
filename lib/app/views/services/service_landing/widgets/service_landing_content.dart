import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import 'package:my_services/app/models/enums.dart';
import 'package:my_services/app/services/services_service/services_service.dart';
import 'package:my_services/app/services/time_service/time_service.dart';
import 'package:my_services/app/shared/extensions/extensions.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/views/services/service_landing/widgets/service_navbar.dart';
import 'package:my_services/app/views/services/services.dart';
import 'package:my_services/injector_container.dart';

class ServiceLandingContent extends StatelessWidget {
  final ServiceLandingState state;
  final GlobalKey<FormFieldState> dateKey;
  final MaskedTextController dateController;

  const ServiceLandingContent(
      {super.key,
      required this.dateKey,
      required this.dateController,
      required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ServiceNavbar(dateKey: dateKey, dateController: dateController),
        AppSizeConstants.bigVerticalSpacer,
        Expanded(child: _getServiceList()),
      ],
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
      servicesByDate: servicesService.groupServicesByDate(state.services),
    );
  }
}
