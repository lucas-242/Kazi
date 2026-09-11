import 'package:flutter/material.dart';
import 'package:kazi/core/routes/app_pages.dart';
import 'package:kazi/features/clients/clients.dart';
import 'package:kazi/features/clients/domain/models/client_entry.dart';
import 'package:kazi/features/services/domain/models/service_view.dart';
import 'package:kazi/features/services/presenter/controllers/service_landing_controller.dart';
import 'package:kazi/features/services/presenter/controllers/service_landing_state.dart';
import 'package:kazi/features/services/presenter/widgets/service_card.dart';
import 'package:kazi/features/services/services.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

/// What the search mode shows under the field: services and clients in
/// separate blocks, over everything ever registered.
///
/// A failed search is not a dead end — it becomes the shortcut that creates
/// what was being looked for. See README.md.
class ServiceSearchContent extends ConsumerWidget {
  const ServiceSearchContent({super.key, required this.state});

  final ServiceLandingState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final term = state.searchTerm.trim();
    if (term.isEmpty) return const SliverToBoxAdapter(child: _SearchHint());

    final services = state.searchedServices;
    final clients = state.searchClients;

    if (services.isEmpty && clients.isEmpty) {
      return SliverToBoxAdapter(
        child: KaziNoResults(
          icon: Icons.search,
          message: KaziLocalizations.current.nothingFoundFor(term),
          description: KaziLocalizations.current.nothingFoundForDescription,
          actionLabel: KaziLocalizations.current.createInCatalog(term),
          onAction: () => KaziNavigator.push(AppPage.addCatalogItem),
        ),
      );
    }

    // A sliver, because a short term matches most of the history.
    return SliverMainAxisGroup(
      slivers: [
        if (services.isNotEmpty) ...[
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ServicesHeading(state: state),
                KaziSpacings.verticalSm,
              ],
            ),
          ),
          SliverList.separated(
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];

              return ServiceCard(
                service: service,
                onTap: () => KaziNavigator.push(
                  AppPage.serviceDetails,
                  extra: ServiceArguments(service: service),
                ),
              );
            },
            separatorBuilder: (context, index) => KaziSpacings.verticalXs,
          ),
        ],
        if (clients.isNotEmpty)
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KaziSpacings.verticalLg,
                _Heading(title: KaziLocalizations.current.clients),
                KaziSpacings.verticalSm,
                for (final client in clients) ...[
                  if (client != clients.first) KaziSpacings.verticalXs,
                  _ClientRow(client: client),
                ],
              ],
            ),
          ),
        const SliverToBoxAdapter(child: KaziSpacings.verticalLg),
      ],
    );
  }
}

/// Says the one thing about search that is not obvious from looking at it.
class _SearchHint extends StatelessWidget {
  const _SearchHint();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: KaziInsets.xLg),
      child: Text(
        KaziLocalizations.current.searchIgnoresPeriod,
        style: KaziTextStyles.bodyMedium.copyWith(
          color: context.colors.textMuted,
        ),
      ),
    );
  }
}

/// How many were found and what they are worth, with the way into the summary
/// for the same cut.
class _ServicesHeading extends ConsumerWidget {
  const _ServicesHeading({required this.state});

  final ServiceLandingState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totals = state.searchTotals;

    return Row(
      children: [
        Expanded(
          child: Text(
            KaziLocalizations.current.searchServicesFound(
              state.searchedServices.length,
              NumberFormatUtils.formatCurrencyIn(
                totals.commission,
                totals.currency,
              ),
            ),
            style: KaziTextStyles.labelSmall.copyWith(
              color: context.colors.textMuted,
            ),
          ),
        ),
        KaziTextButton(
          onTap: () => ref
              .read(serviceLandingControllerProvider.notifier)
              .openServices(view: ServiceView.summary),
          child: Text(KaziLocalizations.current.seeInSummary),
        ),
      ],
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    // Upper-cased at the call site: Flutter has no text-transform.
    return Text(
      title.toUpperCase(),
      style: KaziTextStyles.tag.copyWith(color: context.colors.textMuted),
    );
  }
}

class _ClientRow extends StatelessWidget {
  const _ClientRow({required this.client});

  final ClientEntry client;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Material(
      color: colors.card,
      borderRadius: KaziRadii.smBorder,
      child: InkWell(
        onTap: () => KaziNavigator.push(
          AppPage.clientDetails,
          extra: ClientArguments(client: client),
        ),
        borderRadius: KaziRadii.smBorder,
        child: Container(
          constraints: const BoxConstraints(
            minHeight: KaziSizings.minTouchTarget,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: KaziInsets.md,
            vertical: KaziInsets.sm,
          ),
          decoration: BoxDecoration(
            borderRadius: KaziRadii.smBorder,
            border: Border.all(color: colors.border),
          ),
          child: Row(
            children: [
              Icon(
                Icons.person_outline,
                size: 18,
                color: colors.textMuted,
              ),
              KaziSpacings.horizontalSm,
              Expanded(
                child: Text(
                  client.info.user.name,
                  style: KaziTextStyles.titleSmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
