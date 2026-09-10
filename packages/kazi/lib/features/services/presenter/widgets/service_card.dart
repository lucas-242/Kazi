import 'package:flutter/material.dart';
import 'package:kazi/features/services/domain/models/service.dart';
import 'package:kazi/features/services/presenter/widgets/received_mark.dart';
import 'package:kazi_core/kazi_core.dart' hide Service;

/// One line of the services list: the commission as the headline, the gross as
/// the footnote, the category in the leading edge.
/// See `features/services/README.md`.
///
/// ```
/// ▏ Alongamento em gel            R$ 81
/// ▏ Marina R. · 09 ago         de R$ 180
/// ```
class ServiceCard extends ConsumerWidget {
  const ServiceCard({
    super.key,
    required this.onTap,
    required this.service,
    this.showClient = true,
  });

  final VoidCallback onTap;
  final Service service;

  /// Off on a list that is already one client's, where the name would be the
  /// same word on every row — and the one thing pushing "recebido" off the end
  /// of the line it shares.
  final bool showClient;

  /// "Marina R. · 09 ago", or just the date.
  String _subtitle() {
    final date = DateFormat.yMd().format(service.date).normalizeDate();
    final client = showClient ? service.clientName ?? '' : '';
    return client.isEmpty ? date : '$client · $date';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final defaultCurrency = ref.watch(kaziDefaultCurrencyProvider);
    final serviceCurrency = service.currencyOr(defaultCurrency);

    return Material(
      color: colors.card,
      clipBehavior: Clip.antiAlias,
      shape: KaziCategoryBorder(
        color: colors.border,
        categoryColor: service.catalogItem?.colorAs ?? colors.surfaceStrong,
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(
            minHeight: KaziSizings.minTouchTarget,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: KaziInsets.md,
            vertical: KaziInsets.sm,
          ),
          child: _Content(
            service: service,
            currency: serviceCurrency,
            subtitle: _subtitle(),
          ),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.service,
    required this.currency,
    required this.subtitle,
  });

  final Service service;
  final SupportedCurrency currency;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                service.catalogItem?.name ?? '',
                style: KaziTextStyles.titleSmall,
              ),
              KaziSpacings.verticalXxs,
              // One span, so the situation ellipsises with the line it belongs
              // to instead of pushing the amounts out of their column.
              Text.rich(
                TextSpan(
                  text: subtitle,
                  children: [
                    if (service.isReceived)
                      receivedMarkSpan(context, precededBy: subtitle),
                  ],
                ),
                style: KaziTextStyles.labelSmall.copyWith(
                  color: colors.textMuted,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        KaziSpacings.horizontalSm,
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              NumberFormatUtils.formatCurrencyIn(
                service.commissionValue,
                currency,
              ),
              style: KaziTextStyles.titleSmall.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            KaziSpacings.verticalXxs,
            Text(
              KaziLocalizations.current.ofGross(
                NumberFormatUtils.formatCurrencyIn(service.value, currency),
              ),
              style: KaziTextStyles.labelSmall.copyWith(
                color: colors.textMuted,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
