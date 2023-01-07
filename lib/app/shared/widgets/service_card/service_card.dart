import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_services/app/shared/extensions/extensions.dart';

import '../../../models/service.dart';
import '../../utils/number_format_helper.dart';
import '../custom_slidable/custom_slidable.dart';

class ServiceCard extends StatelessWidget {
  final Function(Service) onTapDelete;
  final Function(Service) onTapEdit;
  final Service service;
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
            Text(NumberFormatHelper.formatCurrency(
                context, service.valueWithDiscount)),
          ],
        ),
        subtitle: (service.description != null && service.description != '') ||
                showDate
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  service.description != null && service.description != ''
                      ? Text('${service.description}')
                      : Container(),
                  showDate
                      ? Text(
                          DateFormat.yMd().format(service.date).normalizeDate())
                      : Container(),
                ],
              )
            : null,
      ),
    );
  }
}
