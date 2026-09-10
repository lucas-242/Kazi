import 'package:flutter/material.dart';
import 'package:kazi/core/widgets/option_tile.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

class LanguageBottomSheet extends ConsumerWidget {
  const LanguageBottomSheet({super.key});

  static const _languages = <({String code, String name, String region})>[
    (code: 'pt', name: 'Português', region: 'Brasil'),
    (code: 'en', name: 'English', region: 'United States'),
    (code: 'es', name: 'Español', region: 'Latinoamérica'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final effectiveLocale = ref.watch(kaziEffectiveLocaleProvider);

    Future<void> onSelect(String languageCode) async {
      await ref
          .read(kaziLocaleControllerProvider.notifier)
          .selectLanguage(languageCode: languageCode);
      if (context.mounted) KaziNavigator.pop();
    }

    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: KaziInsets.lg,
            right: KaziInsets.lg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                KaziLocalizations.current.language,
                style: KaziTextStyles.titleMedium,
              ),
              KaziSpacings.verticalLg,
              for (final language in _languages)
                OptionTile(
                  label: language.name,
                  detail: language.region,
                  mark: OptionMark.radio,
                  selected: effectiveLocale.languageCode == language.code,
                  onTap: () => onSelect(language.code),
                ),
              KaziSpacings.verticalSm,
            ],
          ),
        ),
      ],
    );
  }
}
