import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kazi/core/routes/app_pages.dart';
import 'package:kazi/core/widgets/tap_probe.dart';
import 'package:kazi/features/app_update/app_update.dart';
import 'package:kazi/features/dashboard/presenter/controllers/dashboard_controller.dart';
import 'package:kazi/features/onboarding/domain/models/onboarding_hint.dart';
import 'package:kazi/features/onboarding/presenter/controllers/hint_controller.dart';
import 'package:kazi/features/onboarding/presenter/controllers/whats_new_controller.dart';
import 'package:kazi/features/onboarding/presenter/pages/whats_new_page.dart';
import 'package:kazi/features/onboarding/presenter/widgets/hint_anchor.dart';
import 'package:kazi/features/onboarding/presenter/widgets/replay_consent_sheet.dart';
import 'package:kazi/features/services/presenter/controllers/service_landing_controller.dart';
import 'package:kazi/features/subscription/presenter/controllers/paywall_prompt_controller.dart';
import 'package:kazi/features/subscription/subscription.dart';
import 'package:kazi/injector.dart';
import 'package:kazi_core/kazi_core.dart';

/// The tab indices this file has something to say about, from the branch order
/// in `AppRouter.buildRoutes`.
abstract final class _Tab {
  static const home = 0;
  static const services = 1;
  static const clients = 2;
}

class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _runFirstFrameChecks();
    });
  }

  /// Strictly sequential: the update dialog, the release announcement and the
  /// contextual hints all want the root navigator, and two of them arriving
  /// together is how a person ends up dismissing something they never read.
  ///
  /// The hints are held back by `HintController.startupSettled` rather than
  /// called from here — they belong to widgets that mount on their own frame —
  /// so the chain must release it however it ends.
  Future<void> _runFirstFrameChecks() async {
    unawaited(_maybeRepairCounters());

    try {
      await _maybeShowOptionalUpdate();
      if (!mounted) return;
      await _maybeShowWhatsNew();
      if (!mounted) return;

      await ReplayConsentSheet.askIfNeeded(context, ref);
    } finally {
      ref.read(hintControllerProvider.notifier).markStartupSettled();
    }
  }

  /// Rebuilds the denormalized counters once per account. The increments on
  /// the write path are best-effort by design, so this is the repair — and it
  /// is idempotent, writing totals rather than adding to them.
  /// See `core/counters.md`.
  Future<void> _maybeRepairCounters() async {
    final userId = ref.read(authServiceProvider).user?.uid;
    if (userId == null) return;

    final backfill = ref.read(countersBackfillProvider);
    if (!await backfill.isPending(userId)) return;

    await backfill.run(userId);
  }

  Future<void> _maybeShowWhatsNew() async {
    final controller = ref.read(whatsNewControllerProvider.notifier);
    if (!await controller.shouldShow()) return;
    if (!mounted) return;

    final info = ref.read(appUpdateControllerProvider).info;

    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (routeContext) => WhatsNewPage(
          version: info.currentVersion,
          entries: info.whatsNew,
          onClose: () => Navigator.of(routeContext).pop(),
        ),
      ),
    );
    await controller.markSeen();
  }

  Future<void> _maybeShowOptionalUpdate() async {
    final controller = ref.read(appUpdateControllerProvider.notifier);
    if (!await controller.shouldShowOptionalDialog()) {
      return;
    }
    if (!mounted) {
      return;
    }
    final storeUrl = ref.read(appUpdateControllerProvider).info.storeUrl;
    await KaziNavigator.showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => OptionalUpdateDialog(storeUrl: storeUrl),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(kaziEffectiveLocaleProvider);

    ref.listen(paywallPromptControllerProvider, (previous, next) {
      if (next == null) return;
      ref.read(paywallPromptControllerProvider.notifier).dismiss();
      if (!ref.read(isPaymentsEnabledProvider)) return;
      showPaywall(context, limit: next);
    });

    return Scaffold(
      body: widget.navigationShell,
      resizeToAvoidBottomInset: false,
      floatingActionButton: _ShellFab(
        tabIndex: widget.navigationShell.currentIndex,
      ),
      floatingActionButtonLocation: const KaziNavBarFabLocation(),
      bottomNavigationBar: KaziNavBar(
        selectedIndex: widget.navigationShell.currentIndex,
        onSelected: _onTapTab,
        items: [
          KaziNavBarItem(
            icon: Icons.home_outlined,
            label: KaziLocalizations.current.home,
          ),
          KaziNavBarItem(
            icon: Icons.format_list_bulleted,
            label: KaziLocalizations.current.services,
          ),
          KaziNavBarItem(
            icon: Icons.person_outline,
            label: KaziLocalizations.current.clients,
          ),
          KaziNavBarItem(
            icon: Icons.tune,
            label: KaziLocalizations.current.menu,
          ),
        ],
      ),
    );
  }

  void _onTapTab(int index) {
    if (index != widget.navigationShell.currentIndex) {
      _cancelPendingReads(widget.navigationShell.currentIndex);
    }

    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  void _cancelPendingReads(int leaving) {
    switch (leaving) {
      case _Tab.home:
        ref.read(dashboardControllerProvider.notifier).cancelPendingRead();
      case _Tab.services:
        ref.read(serviceLandingControllerProvider.notifier).cancelPendingRead();
    }
  }
}

class _ShellFab extends StatelessWidget {
  const _ShellFab({required this.tabIndex});

  final int tabIndex;

  AppPage get _destination =>
      tabIndex == _Tab.clients ? AppPage.addClient : AppPage.addServices;

  @override
  Widget build(BuildContext context) {
    return HintAnchor(
      hint: OnboardingHint.fab,
      enabled: tabIndex == _Tab.home,
      child: _Fab(destination: _destination),
    );
  }
}

class _Fab extends StatelessWidget {
  const _Fab({required this.destination});

  final AppPage destination;

  @override
  Widget build(BuildContext context) {
    final onAccent = context.colors.brand.onFill;

    final Widget child = destination == AppPage.addServices
        ? KaziSvg(KaziSvgAssets.logo, height: 24, color: onAccent)
        : Icon(Icons.add, size: KaziSizings.iconLg, color: onAccent);

    return TapProbe(
      target: 'shell_fab',
      child: KaziNavBarFab(
        onTap: () => KaziNavigator.push(destination),
        child: child,
      ),
    );
  }
}
