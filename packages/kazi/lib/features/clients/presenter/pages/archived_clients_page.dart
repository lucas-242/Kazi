import 'package:flutter/material.dart';
import 'package:kazi/core/utils/base_state.dart';
import 'package:kazi/core/widgets/archived_delete_row.dart';
import 'package:kazi/core/widgets/archived_record_tile.dart';
import 'package:kazi/features/clients/domain/models/client_entry.dart';
import 'package:kazi/features/clients/presenter/controllers/archived_clients_controller.dart';
import 'package:kazi/features/clients/presenter/controllers/archived_clients_state.dart';
import 'package:kazi_core/kazi_core.dart';

class ArchivedClientsPage extends ConsumerStatefulWidget {
  const ArchivedClientsPage({super.key});

  @override
  ConsumerState<ArchivedClientsPage> createState() =>
      _ArchivedClientsPageState();
}

class _ArchivedClientsPageState extends ConsumerState<ArchivedClientsPage> {
  bool _leaving = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(archivedClientsControllerProvider.notifier).onInit(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(archivedClientsControllerProvider);
    final controller = ref.read(archivedClientsControllerProvider.notifier);

    // Emptying the screen leaves nothing to come back to: leave rather than
    // show an empty archive. Guarded, because build runs again before the
    // microtask lands and a second pop would take the caller's screen with it.
    if (state.clients.isEmpty &&
        state.status != BaseStateStatus.loading &&
        !_leaving) {
      _leaving = true;
      Future.microtask(KaziNavigator.pop);
    }

    return Scaffold(
      appBar: KaziAppBar(title: KaziLocalizations.current.archivedClients),
      body: KaziSafeArea(
        onRefresh: controller.onInit,
        child: switch (state.status) {
          BaseStateStatus.loading => const KaziSkeletonList(count: 3),
          BaseStateStatus.error => KaziError(
            message: state.callbackMessage,
            onRetry: controller.onInit,
          ),
          _ => _ArchivedClients(state: state),
        },
      ),
    );
  }
}

/// The same two halves as the catalogue's archive: what can come back, then,
/// under its own heading, what can be erased. See core/archiving.md.
class _ArchivedClients extends ConsumerWidget {
  const _ArchivedClients({required this.state});

  final ArchivedClientsState state;

  /// "12 services · Archived on 03/08/2026", less whichever half is unknown.
  String _subtitle(ClientEntry client) {
    final services = state.countFor(client.id);
    final used = services == null
        ? null
        : services == 0
        ? KaziLocalizations.current.noServices
        : KaziLocalizations.current.servicesCount(services);
    final archivedAt = client.archivedAt;
    final when = archivedAt == null
        ? null
        : KaziLocalizations.current.archivedOn(archivedAt.format());

    return [used, when].nonNulls.join(' · ');
  }

  /// Spells out what deletion takes and what it leaves, so nobody reads it as
  /// "this erases the work I did for them".
  String _deleteMessage(int? services) {
    if (services == null || services == 0) {
      return KaziLocalizations.current.deleteNoServicesImpact;
    }

    return KaziLocalizations.current.deleteClientImpact(services);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(archivedClientsControllerProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KaziNote(KaziLocalizations.current.archivedClientsNote),
        KaziSpacings.verticalMd,
        for (final client in state.clients) ...[
          ArchivedRecordTile(
            name: client.info.user.name,
            subtitle: _subtitle(client),
            onRestore: () => controller.restoreClient(client),
          ),
          KaziSpacings.verticalXs,
        ],
        KaziSpacings.verticalMd,
        Text(
          KaziLocalizations.current.deletePermanently.toUpperCase(),
          style: KaziTextStyles.tag.copyWith(color: context.colors.textMuted),
        ),
        KaziSpacings.verticalXs,
        for (final client in state.clients) ...[
          ArchivedDeleteRow(
            name: client.info.user.name,
            // The count informs; it does not gate. Someone asking to be removed
            // is usually someone already served, so a rule barring deletion
            // above zero services would close the door precisely when it has to
            // open. See core/archiving.md.
            deletable: true,
            note: switch (state.countFor(client.id)) {
              null || 0 => KaziLocalizations.current.freeToDelete,
              final int services =>
                KaziLocalizations.current.usedInServices(services),
            },
            onTap: () => confirmPermanentDelete(
              context,
              name: client.info.user.name,
              message: _deleteMessage(state.countFor(client.id)),
              onDelete: () => controller.deleteClient(client),
            ),
          ),
          KaziSpacings.verticalXs,
        ],
        KaziSpacings.verticalLg,
      ],
    );
  }
}
