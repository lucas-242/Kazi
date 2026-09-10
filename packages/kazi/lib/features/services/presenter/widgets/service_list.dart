import 'package:flutter/material.dart';
import 'package:kazi/features/services/domain/models/service.dart';
import 'package:kazi/features/services/presenter/widgets/service_list_content.dart';
import 'package:kazi_core/kazi_core.dart' hide Service;

class ServiceList extends StatelessWidget {
  const ServiceList({
    super.key,
    required this.services,
    this.canScroll = false,
    this.title,
    this.expandList = false,
    this.firstPosition = 0,
    this.total,
  });

  final List<Service> services;
  final bool canScroll;
  final String? title;
  final bool expandList;

  /// See [ServiceListContent.firstPosition].
  final int firstPosition;

  /// See [ServiceListContent.total].
  final int? total;

  @override
  Widget build(BuildContext context) {
    // Vertical rhythm only: the page's horizontal gutter comes from
    // `KaziSafeArea`, and the rows carry their own card padding.
    return Padding(
      padding: EdgeInsets.only(
        top: title == null ? KaziInsets.xs : KaziInsets.md,
        bottom: KaziInsets.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title!.toUpperCase(),
              style: KaziTextStyles.tag.copyWith(
                color: context.colors.textMuted,
              ),
            ),
            KaziSpacings.verticalSm,
          ],
          expandList
              ? Expanded(
                  child: ServiceListContent(
                    services: services,
                    canScroll: canScroll,
                    firstPosition: firstPosition,
                    total: total,
                  ),
                )
              : ServiceListContent(
                  services: services,
                  canScroll: canScroll,
                  firstPosition: firstPosition,
                  total: total,
                ),
        ],
      ),
    );
  }
}
