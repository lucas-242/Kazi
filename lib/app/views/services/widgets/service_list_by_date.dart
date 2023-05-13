import 'package:flutter/material.dart';
import 'package:my_services/app/models/service_group_by_date.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/views/services/widgets/service_date_card.dart';

class ServiceListByDate extends StatefulWidget {
  const ServiceListByDate({
    Key? key,
    required this.servicesByDateList,
  }) : super(key: key);

  final List<ServicesGroupByDate> servicesByDateList;

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
