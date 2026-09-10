import 'package:flutter/material.dart';
import 'package:kazi/features/services/domain/models/service_group_by_date.dart';
import 'package:kazi/features/services/presenter/widgets/service_date_card.dart';
import 'package:kazi_core/kazi_core.dart';

class ServiceListByDate extends StatefulWidget {
  const ServiceListByDate({super.key, required this.servicesByDateList});

  final List<ServicesGroupByDate> servicesByDateList;

  @override
  State<ServiceListByDate> createState() => _ServiceListByDateState();
}

class _ServiceListByDateState extends State<ServiceListByDate> {
  /// Days the person opened or closed. Held here, not on the groups: those are
  /// rebuilt with only the first day open whenever the list changes, so a
  /// swipe that stamps a payment would fold every other day shut.
  final _toggled = <DateTime, bool>{};

  bool _isExpanded(ServicesGroupByDate group) =>
      _toggled[group.date] ?? group.isExpanded;

  void _onTap(ServicesGroupByDate group) =>
      setState(() => _toggled[group.date] = !_isExpanded(group));

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.servicesByDateList.length,
      itemBuilder: (context, index) {
        final group = widget.servicesByDateList[index];

        return ServiceDateCard(
          servicesByDate: group.copyWith(isExpanded: _isExpanded(group)),
          onTap: () => _onTap(group),
        );
      },
      separatorBuilder: (context, index) => KaziSpacings.verticalXs,
    );
  }
}
