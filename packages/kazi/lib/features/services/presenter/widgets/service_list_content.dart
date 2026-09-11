import 'package:flutter/material.dart';
import 'package:kazi/features/services/domain/models/service.dart';
import 'package:kazi/core/routes/app_pages.dart';
import 'package:kazi/core/services/data/ads/banner_ad_policy.dart';
import 'package:kazi/core/widgets/ads/ad_block.dart';
import 'package:kazi/features/services/services.dart';
import 'package:kazi/features/services/presenter/controllers/service_receipt_controller.dart';
import 'package:kazi/features/services/presenter/widgets/service_card.dart';
import 'package:kazi/injector.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

class ServiceListContent extends ConsumerWidget {
  const ServiceListContent({
    super.key,
    required this.services,
    this.firstPosition = 0,
    this.total,
  }) : isSliver = false;

  /// The same rows as a lazy [SliverList], for a list that is the whole list
  /// on screen and the page's scroll body.
  const ServiceListContent.sliver({super.key, required this.services})
    : isSliver = true,
      firstPosition = 0,
      total = null;

  final List<Service> services;
  final bool isSliver;

  /// Where [services] start in the whole list on screen, when they are one
  /// day's slice of it. Banners are placed by that position.
  final int firstPosition;

  /// Length of the whole list on screen; null when [services] is all of it.
  final int? total;

  void _onTap(BuildContext context, Service service) => KaziNavigator.push(
    AppPage.serviceDetails,
    extra: ServiceArguments(service: service),
  );

  /// Flips the payment stamp on [service], then reports back so the row can
  /// stay put instead of dismissing.
  Future<bool> _onSwipe(
    BuildContext context,
    WidgetRef ref,
    Service service,
  ) async {
    try {
      await ref.read(serviceReceiptControllerProvider.notifier).setReceived([
        service,
      ], received: !service.isReceived);
    } on AppError catch (exception) {
      if (context.mounted) KaziSnackbar.show(context, exception.message);
    } catch (_) {
      if (context.mounted) {
        KaziSnackbar.show(context, KaziLocalizations.current.errorUnknowError);
      }
    }

    // Always false: the row changes state but still belongs to the list.
    return false;
  }

  Widget _buildItem(
    BuildContext context,
    WidgetRef ref,
    int index, {
    required BannerAdPolicy bannerPolicy,
  }) {
    final service = services[index];

    final row = _ReceiptSwipe(
      key: ValueKey('service-${service.id}'),
      service: service,
      onSwipe: () => _onSwipe(context, ref, service),
      child: ServiceCard(
        service: service,
        onTap: () => _onTap(context, service),
      ),
    );

    final isFollowedByBanner = bannerPolicy.shouldShowAfter(
      firstPosition + index,
      total: total ?? services.length,
    );
    if (!isFollowedByBanner) return row;

    // Wraps the swipeable row, not the bare card, or the service above a
    // banner is the one row that cannot be marked as received.
    return AdBlock(
      key: ValueKey('ad-${service.id}'),
      padding: const EdgeInsets.only(top: KaziInsets.xs),
      child: row,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bannerPolicy = ref.watch(bannerAdPolicyProvider);

    // A gap, not a rule: a divider between two bordered cards reads as a third.
    if (isSliver) {
      return SliverList.separated(
        itemCount: services.length,
        itemBuilder: (context, index) =>
            _buildItem(context, ref, index, bannerPolicy: bannerPolicy),
        separatorBuilder: (context, index) => KaziSpacings.verticalXs,
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var index = 0; index < services.length; index++) ...[
          if (index != 0) KaziSpacings.verticalXs,
          _buildItem(context, ref, index, bannerPolicy: bannerPolicy),
        ],
      ],
    );
  }
}

/// A row that flips the payment stamp when swiped, and stays put.
class _ReceiptSwipe extends StatefulWidget {
  const _ReceiptSwipe({
    super.key,
    required this.service,
    required this.onSwipe,
    required this.child,
  });

  final Service service;
  final Future<bool> Function() onSwipe;
  final Widget child;

  @override
  State<_ReceiptSwipe> createState() => _ReceiptSwipeState();
}

class _ReceiptSwipeState extends State<_ReceiptSwipe> {
  /// The label the swipe started with, held until the row is back at rest.
  /// The stamp lands while the row is still open, and repainting the
  /// background then flashes the opposite action. Null while at rest.
  bool? _labelledAsReceived;

  void _onUpdate(DismissUpdateDetails details) {
    if (details.progress > 0) {
      if (_labelledAsReceived == null) {
        setState(() => _labelledAsReceived = widget.service.isReceived);
      }
    } else if (_labelledAsReceived != null) {
      setState(() => _labelledAsReceived = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // Clipped to the card's corners while swiped, or the colour pokes out
      // square at both ends. At rest there is nothing to clip, and a clip on
      // every row is rasterized again on every frame of a scroll.
      borderRadius: KaziRadii.smBorder,
      clipBehavior: _labelledAsReceived == null ? Clip.none : Clip.antiAlias,
      child: Dismissible(
        key: ValueKey(widget.service.id),
        direction: DismissDirection.endToStart,
        onUpdate: _onUpdate,
        confirmDismiss: (_) => widget.onSwipe(),
        background: _SwipeBackground(
          isReceived: _labelledAsReceived ?? widget.service.isReceived,
        ),
        child: widget.child,
      ),
    );
  }
}

/// What shows behind a row being swiped: the action it is about to perform.
class _SwipeBackground extends StatelessWidget {
  const _SwipeBackground({required this.isReceived});

  /// Swiping a paid service undoes the stamp, so the label has to say so.
  final bool isReceived;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final color = isReceived ? colors.warning.surface : colors.success.surface;
    final onColor = isReceived
        ? colors.warning.onSurface
        : colors.success.onSurface;

    return ColoredBox(
      color: color,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: KaziInsets.md),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              isReceived ? Icons.undo : Icons.check_circle_outline,
              size: 18,
              color: onColor,
            ),
            KaziSpacings.horizontalXs,
            Text(
              isReceived
                  ? KaziLocalizations.current.notReceived
                  : KaziLocalizations.current.received,
              style: KaziTextStyles.labelSmall.copyWith(color: onColor),
            ),
          ],
        ),
      ),
    );
  }
}
