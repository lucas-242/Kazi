import 'package:flutter/material.dart';
import 'package:kazi/core/routes/app_pages.dart';
import 'package:kazi/features/services/domain/models/service.dart';
import 'package:kazi/features/services/presenter/widgets/received_mark.dart';
import 'package:kazi/features/services/services.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

/// One of today's services on the home: colour mark, what it was, the share the
/// user keeps and the gross it came out of — always in the currency the service
/// was registered in, never converted.
class TodayServiceCard extends ConsumerWidget {
  const TodayServiceCard({super.key, required this.service});

  final Service service;

  /// The title falls back to the catalog item's name: a service can be
  /// registered without a description, but never without an item.
  String get _title {
    final description = service.description;
    if (description != null && description.trim().isNotEmpty) {
      return description;
    }
    return service.catalogItem?.name ?? '';
  }

  /// "Marina R. · 14:00", or just the client, or just the time. Who was served
  /// and when, which is what the day's list is read for — the commission rate
  /// moved to the amount it qualifies.
  String get _subtitle {
    final client = service.clientName ?? '';
    final hasTime = service.date.hour != 0 || service.date.minute != 0;
    final time = hasTime ? DateFormat.Hm().format(service.date) : '';

    return [client, time].where((part) => part.isNotEmpty).join(' · ');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serviceCurrency = service.currencyOr(
      ref.watch(kaziDefaultCurrencyProvider),
    );

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: KaziCategoryBorder(
        color: context.colors.border,
        categoryColor:
            service.catalogItem?.colorAs ?? context.colors.surfaceStrong,
        radius: const Radius.circular(KaziRadii.md),
      ),
      child: InkWell(
        onTap: () => KaziNavigator.push(
          AppPage.serviceDetails,
          extra: ServiceArguments(service: service),
        ),
        child: Padding(
          padding: const EdgeInsets.all(KaziInsets.md),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: KaziInsets.xxs,
                  children: [
                    Text(
                      _title,
                      style: KaziTextStyles.labelLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text.rich(
                      TextSpan(
                        text: _subtitle,
                        children: [
                          if (service.isReceived)
                            receivedMarkSpan(context, precededBy: _subtitle),
                        ],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: KaziTextStyles.labelSmall.copyWith(
                        color: context.colors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              KaziSpacings.horizontalMd,
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    NumberFormatUtils.formatCurrencyIn(
                      service.commissionValue,
                      serviceCurrency,
                    ),
                    style: KaziTextStyles.labelLarge,
                  ),
                  Text(
                    KaziLocalizations.current.ofGross(
                      NumberFormatUtils.formatCurrencyIn(
                        service.value,
                        serviceCurrency,
                      ),
                    ),
                    style: KaziTextStyles.labelSmall.copyWith(
                      color: context.colors.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
