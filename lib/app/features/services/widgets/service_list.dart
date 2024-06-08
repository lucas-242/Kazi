import 'package:flutter/material.dart';
import 'package:kazi/app/core/extensions/extensions.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/features/services/services.dart';
import 'package:kazi/app/models/service.dart';

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
          left: AppInsets.lg,
          right: AppInsets.lg,
          top: title == null ? AppInsets.xs : AppInsets.lg,
          bottom: AppInsets.md,
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
                  AppSpacings.verticalLg,
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
