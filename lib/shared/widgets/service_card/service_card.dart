import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/service_provided.dart';
import '../custom_slidable/custom_slidable.dart';

class ServiceCard extends StatelessWidget {
  final Function(ServiceProvided) onTapDelete;
  final Function(ServiceProvided) onTapEdit;
  final ServiceProvided service;
  final bool showDate;

  const ServiceCard(
      {super.key,
      required this.onTapDelete,
      required this.onTapEdit,
      required this.service,
      required this.showDate});

  @override
  Widget build(BuildContext context) {
    return CustomSlidable(
      leftPanel: true,
      rightPanel: true,
      onLeftSlide: () => onTapEdit(service),
      onRightSlide: () => onTapDelete(service),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${service.type?.name}'),
            Text(NumberFormat.currency(symbol: 'R\$')
                .format(service.valueWithDiscount)),
          ],
        ),
        subtitle: (service.description != null && service.description != '') ||
                showDate
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  service.description != null && service.description != ''
                      ? Text(service.description!)
                      : Container(),
                  showDate
                      ? Text(DateFormat.yMd().format(service.date))
                      : Container(),
                ],
              )
            : null,
      ),
    );
  }
}
