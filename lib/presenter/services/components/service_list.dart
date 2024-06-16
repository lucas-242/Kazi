import 'package:flutter/material.dart';
import 'package:kazi/presenter/services/services.dart';
import 'package:kazi/core/extensions/extensions.dart';
import 'package:kazi_core/kazi_core.dart';
import 'package:kazi_design_system/themes/themes.dart';

class ServiceList extends StatelessWidget {
  const ServiceList({
    super.key,
    required this.services,
    this.canScroll = false,
    this.title,
    this.expandList = false,
  });

  final List<Service> services;
  final bool canScroll;
  final String? title;
  final bool expandList;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(
          left: KaziInsets.lg,
          right: KaziInsets.lg,
          top: title == null ? KaziInsets.xs : KaziInsets.lg,
          bottom: KaziInsets.md,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Column(
                children: [
                  Text(
                    title!.capitalize(),
                    style: context.titleSmall,
                  ),
                  KaziSpacings.verticalLg,
                ],
              ),
            expandList
                ? Expanded(
                    child: ServiceListContent(
                      services: services,
                      canScroll: canScroll,
                    ),
                  )
                : ServiceListContent(
                    services: services,
                    canScroll: canScroll,
                  ),
          ],
        ),
      ),
    );
  }
}
