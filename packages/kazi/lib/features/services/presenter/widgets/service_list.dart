import 'package:flutter/material.dart';
import 'package:kazi/features/services/domain/models/service.dart';
import 'package:kazi/features/services/presenter/widgets/service_list_content.dart';
import 'package:kazi_core/kazi_core.dart' hide Service;

class ServiceList extends StatelessWidget {
  const ServiceList({
    super.key,
    required this.services,
    this.title,
    this.firstPosition = 0,
    this.total,
  }) : isSliver = false;

  /// The whole list on screen as a lazy sliver, for when it is the page's
  /// scroll body: rows are built as they scroll in, not all at once.
  const ServiceList.sliver({super.key, required this.services, this.title})
    : isSliver = true,
      firstPosition = 0,
      total = null;

  final List<Service> services;
  final String? title;

  /// See [ServiceListContent.firstPosition].
  final int firstPosition;

  /// See [ServiceListContent.total].
  final int? total;

  final bool isSliver;

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    // Vertical rhythm only: the page's horizontal gutter comes from
    // `KaziSafeArea`, and the rows carry their own card padding.
    final padding = EdgeInsets.only(
      top: title == null ? KaziInsets.xs : KaziInsets.md,
      bottom: KaziInsets.sm,
    );

    if (isSliver) {
      return SliverPadding(
        padding: padding,
        sliver: SliverMainAxisGroup(
          slivers: [
            if (title != null) SliverToBoxAdapter(child: _Title(title)),
            ServiceListContent.sliver(services: services),
          ],
        ),
      );
    }

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) _Title(title),
          ServiceListContent(
            services: services,
            firstPosition: firstPosition,
            total: total,
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: KaziTextStyles.tag.copyWith(color: context.colors.textMuted),
        ),
        KaziSpacings.verticalSm,
      ],
    );
  }
}
