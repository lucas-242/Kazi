import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kazi/features/app_update/presenter/controllers/app_update_controller.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

class ForcedUpdatePage extends ConsumerWidget {
  const ForcedUpdatePage({super.key});

  /// The glyph disc and the mark inside it.
  static const _discSize = 72.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = KaziLocalizations.current;
    final color = context.colors.money;
    final info = ref.watch(appUpdateControllerProvider).info;
    // The router owns the lock; unlocked, the page was pushed from the debug
    // menu and has to be closable.
    final canDismiss =
        !ref.watch(kaziForcedUpdateRequiredProvider) &&
        Navigator.canPop(context);

    Future<void> onUpdate() async {
      if (info.storeUrl.isEmpty) return;
      await ref.read(kaziUrlLauncherServiceProvider).launch(info.storeUrl);
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: context.colors.overlayOn(color.surface),
      child: PopScope(
        canPop: canDismiss,
        child: Scaffold(
          backgroundColor: color.surface,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(KaziInsets.xLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (canDismiss)
                    Align(
                      alignment: Alignment.centerRight,
                      child: KaziCircularButton.plain(
                        onTap: KaziNavigator.pop,
                        foregroundColor: color.onSurface,
                        semantics: l10n.close,
                        child: const Icon(Icons.close),
                      ),
                    ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: _discSize,
                      height: _discSize,
                      decoration: BoxDecoration(
                        color: color.onSurface.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.download,
                        size: KaziSizings.iconLg,
                        color: color.accent,
                      ),
                    ),
                  ),
                  KaziSpacings.verticalMd,
                  Text(
                    l10n.forcedUpdateTitle,
                    style: KaziTextStyles.headlineMedium.copyWith(
                      color: color.onSurface,
                    ),
                  ),
                  KaziSpacings.verticalSm,
                  Text(
                    l10n.forcedUpdateMessage,
                    style: KaziTextStyles.bodySmall.copyWith(
                      color: color.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  const Spacer(),
                  KaziElevatedButton.label(
                    onTap: onUpdate,
                    label: l10n.forcedUpdateButton,
                  ),
                  if (info.currentVersion.isNotEmpty) ...[
                    KaziSpacings.verticalSm,
                    Text(
                      l10n.forcedUpdateVersions(
                        info.latestVersion,
                        info.currentVersion,
                      ),
                      textAlign: TextAlign.center,
                      style: KaziTextStyles.labelSmall.copyWith(
                        color: color.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
