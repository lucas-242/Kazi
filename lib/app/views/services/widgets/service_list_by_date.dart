import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_services/app/models/service_group_by_date.dart';
import 'package:my_services/app/services/time_service/time_service.dart';
import 'package:my_services/app/shared/extensions/extensions.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/widgets/buttons/buttons.dart';
import 'package:my_services/app/shared/widgets/texts/texts.dart';
import 'package:my_services/injector_container.dart';

import '../../../shared/widgets/animation/expanded_section/expanded_section.dart';
import 'service_list.dart';

class ServiceListByDate extends StatefulWidget {
  final List<ServicesGroupByDate> servicesByDate;

  const ServiceListByDate({
    Key? key,
    required this.servicesByDate,
  }) : super(key: key);

  @override
  State<ServiceListByDate> createState() => _ServiceListByDateState();
}

class _ServiceListByDateState extends State<ServiceListByDate> {
  @override
  Widget build(BuildContext context) {
    String getTextDate(DateTime date) {
      final today = serviceLocator.get<TimeService>().now;

      if (date == today) {
        return AppLocalizations.current.today;
      } else if (date.calculateDifference(today) == -1) {
        return AppLocalizations.current.yesterday;
      }
      return DateFormat.yMMMd().format(date).normalizeDate();
    }

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.servicesByDate.length,
      itemBuilder: (context, index) {
        final servicesByDate = widget.servicesByDate[index];
        return Card(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: AppSizeConstants.largeSpace,
                  right: AppSizeConstants.largeSpace,
                  top: AppSizeConstants.largeSpace,
                  bottom: !servicesByDate.isExpanded
                      ? AppSizeConstants.largeSpace
                      : 0,
                ),
                child: TextWithTrailing(
                  text: getTextDate(servicesByDate.date),
                  trailing: CircularButton(
                    onTap: () => setState(() {
                      widget.servicesByDate[index] = servicesByDate.copyWith(
                          isExpaded: !servicesByDate.isExpanded);
                    }),
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
                  canScroll: false,
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) =>
          AppSizeConstants.smallVerticalSpacer,
    );
  }
}
