import 'package:flutter/material.dart';
import 'package:kazi/core/widgets/option_tile.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

/// The three brightnesses.
///
/// The only sheet in the app that stays open after a choice: the whole app
/// repaints behind it, and closing would take away the thing you are comparing.
class ThemeBottomSheet extends ConsumerWidget {
  const ThemeBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected =
        ref.watch(kaziThemeControllerProvider).asData?.value ??
        ThemeMode.system;

    Future<void> onSelect(ThemeMode mode) =>
        ref.read(kaziThemeControllerProvider.notifier).selectThemeMode(mode);

    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: KaziInsets.xLg,
            right: KaziInsets.xLg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                KaziLocalizations.current.theme,
                style: KaziTextStyles.titleMedium,
              ),
              KaziSpacings.verticalLg,
              OptionTile(
                label: KaziLocalizations.current.themeSystem,
                detail: KaziLocalizations.current.themeSystemDetail,
                mark: OptionMark.radio,
                selected: selected == ThemeMode.system,
                onTap: () => onSelect(ThemeMode.system),
              ),
              OptionTile(
                label: KaziLocalizations.current.themeLight,
                mark: OptionMark.radio,
                selected: selected == ThemeMode.light,
                onTap: () => onSelect(ThemeMode.light),
              ),
              OptionTile(
                label: KaziLocalizations.current.themeDark,
                mark: OptionMark.radio,
                selected: selected == ThemeMode.dark,
                onTap: () => onSelect(ThemeMode.dark),
              ),
              KaziSpacings.verticalSm,
              Text(
                KaziLocalizations.current.themeChangeNote,
                style: KaziTextStyles.labelSmall.copyWith(
                  color: context.colors.textMuted,
                ),
              ),
              KaziSpacings.verticalLg,
            ],
          ),
        ),
      ],
    );
  }
}
