import 'package:flutter/material.dart';
import 'package:kazi/features/services/domain/models/catalog_item.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

/// One line of the catalog, shaped like a line of the services list: the item's
/// colour is its identity, so it sits in the leading edge rather than in a dot
/// that costs the name its width.
class CatalogItemCard extends ConsumerWidget {
  const CatalogItemCard({
    super.key,
    required this.catalogItem,
    required this.onTap,
  });
  final Function(CatalogItem) onTap;
  final CatalogItem catalogItem;

  bool get _hasCommission => catalogItem.effectiveCommissionPercent != null;

  /// "R$ 180 · 45% para você", or the gap said out loud when there is no
  /// commission configured.
  String _subtitle(SupportedCurrency currency) {
    final price = NumberFormatUtils.formatCurrencyIn(
      catalogItem.defaultValue,
      currency,
    );
    final share = _hasCommission
        ? KaziLocalizations.current.commissionPercent(
            NumberFormatUtils.formatPercent(
              catalogItem.effectiveCommissionPercent!,
            ),
          )
        : KaziLocalizations.current.withoutCommission;

    return '$price · $share';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final currency = SupportedCurrency.fromCode(
      catalogItem.currency,
      fallback: ref.watch(kaziDefaultCurrencyProvider),
    );

    return Material(
      color: colors.card,
      clipBehavior: Clip.antiAlias,
      shape: KaziCategoryBorder(
        color: colors.border,
        categoryColor: catalogItem.colorAs ?? colors.surfaceStrong,
      ),
      child: InkWell(
        onTap: () => onTap(catalogItem),
        child: Container(
          constraints: const BoxConstraints(
            minHeight: KaziSizings.minTouchTarget,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: KaziInsets.md,
            vertical: KaziInsets.sm,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      catalogItem.name,
                      style: KaziTextStyles.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    KaziSpacings.verticalXxs,
                    Text(
                      _subtitle(currency),
                      style: KaziTextStyles.labelSmall.copyWith(
                        // An item with no commission set enters the
                        // generated total and not the user's, which
                        // is a gap worth colouring.
                        color: _hasCommission
                            ? colors.textMuted
                            : colors.danger.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (!catalogItem.counters.isMissing) ...[
                KaziSpacings.horizontalSm,
                Text(
                  KaziLocalizations.current.usesCount(
                    catalogItem.counters.count,
                  ),
                  style: KaziTextStyles.labelSmall.copyWith(
                    color: colors.textMuted,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
