import 'package:flutter/material.dart';
import 'package:kazi/core/routes/app_pages.dart';
import 'package:kazi/core/routes/navigation_keys.dart';
import 'package:kazi/core/widgets/keyboard_while_on_top.dart';
import 'package:kazi/features/clients/domain/models/client_entry.dart';
import 'package:kazi/features/clients/presenter/pages/archived_clients_page.dart';
import 'package:kazi/features/clients/presenter/pages/client_details_page.dart';
import 'package:kazi/features/clients/presenter/pages/client_form_page.dart';
import 'package:kazi/features/clients/presenter/pages/clients_page.dart';
import 'package:kazi_core/kazi_core.dart';

export 'presenter/pages/archived_clients_page.dart';
export 'presenter/pages/client_details_page.dart';
export 'presenter/pages/client_form_page.dart';
export 'presenter/pages/clients_page.dart';

final class ClientArguments extends KaziNavigationArguments {
  const ClientArguments({super.previousPage, this.client});

  final ClientEntry? client;
}

abstract final class ClientsRoutes {
  // `KeyboardWhileOnTop` keeps a page covered by a sheet or a dialog from
  // following that keyboard.
  static final GoRoute addClient = GoRoute(
    path: 'add-client',
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) => KeyboardWhileOnTop(
      child: Scaffold(
        body: ClientFormPage(
          client: (state.extra as ClientArguments?)?.client,
        ),
      ),
    ),
  );

  static final GoRoute clientDetails = GoRoute(
    path: 'client-details',
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) => KeyboardWhileOnTop(
      child: Scaffold(
        body: ClientDetailsPage(
          clientId: (state.extra as ClientArguments).client!.id,
        ),
      ),
    ),
  );

  static final GoRoute archivedClients = GoRoute(
    path: 'archived',
    parentNavigatorKey: rootNavigatorKey,
    builder: (_, _) => const ArchivedClientsPage(),
  );

  static GoRoute shellRoute() => GoRoute(
    path: AppPage.clients.route,
    builder: (_, _) => const ClientsPage(),
    routes: [clientDetails, addClient, archivedClients],
  );
}
