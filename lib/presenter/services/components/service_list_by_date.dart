import 'package:flutter/material.dart';
import 'package:kazi/presenter/services/components/service_date_card.dart';
import 'package:kazi_core/kazi_core.dart';
import 'package:kazi_design_system/themes/themes.dart';

class ServiceListByDate extends StatefulWidget {
  const ServiceListByDate({
    super.key,
    required this.servicesByDateList,
  });

  final List<ServicesGroupByDate> servicesByDateList;

  @override
  State<ServiceListByDate> createState() => _ServiceListByDateState();
}

class _ServiceListByDateState extends State<ServiceListByDate> {
  void onTap(ServicesGroupByDate servicesByDate, int index) => setState(() {
        widget.servicesByDateList[index] =
            servicesByDate.copyWith(isExpanded: !servicesByDate.isExpanded);
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
      separatorBuilder: (context, index) => KaziSpacings.verticalSm,
    );
  }
}
