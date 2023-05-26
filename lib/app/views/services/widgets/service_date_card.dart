import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kazi/app/models/service_group_by_date.dart';
import 'package:kazi/app/services/time_service/time_service.dart';
import 'package:kazi/app/shared/extensions/extensions.dart';
import 'package:kazi/app/shared/l10n/generated/l10n.dart';
import 'package:kazi/app/shared/themes/themes.dart';
import 'package:kazi/app/shared/widgets/animation/expanded_section/expanded_section.dart';
import 'package:kazi/app/shared/widgets/buttons/buttons.dart';
import 'package:kazi/app/shared/widgets/texts/texts.dart';
import 'package:kazi/app/views/services/services.dart';
import 'package:kazi/injector_container.dart';

class ServiceDateCard extends StatelessWidget {
  const ServiceDateCard({
    super.key,
    required this.servicesByDate,
    required this.onTap,
  });
  final ServicesGroupByDate servicesByDate;
  final VoidCallback onTap;

  String getTextDate(DateTime date) {
    final today = serviceLocator.get<TimeService>().now;

    if (date == today) {
      return AppLocalizations.current.today;
    } else if (date.calculateDifference(today) == -1) {
      return AppLocalizations.current.yesterday;
    }
    return DateFormat.yMMMd().format(date).normalizeDate();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: AppSizeConstants.largeSpace,
              right: AppSizeConstants.largeSpace,
              top: AppSizeConstants.largeSpace,
              bottom:
                  !servicesByDate.isExpanded ? AppSizeConstants.largeSpace : 0,
            ),
            child: TextWithTrailing(
              text: getTextDate(servicesByDate.date),
              trailing: CircularButton(
                onTap: onTap,
                child: Icon(
                  servicesByDate.isExpanded
                      ? Icons.keyboard_arrow_up_outlined
                      : Icons.keyboard_arrow_down_outlined,
                ),
              ),
            ),
          ),
          ExpandedSection(
            isExpanded: servicesByDate.isExpanded,
            child: ServiceList(
              services: servicesByDate.services,
            ),
          ),
        ],
      ),
    );
  }
}
