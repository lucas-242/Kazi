import 'package:flutter/material.dart';
import 'package:kazi/features/app_update/domain/models/whats_new_entry.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

/// One screen, three lines, one button.
///
/// It exists so the change is announced by us rather than discovered by
/// accident in the middle of a job. Deliberately not a carousel and not a
/// sequence: nobody opened the app to read a changelog.
///
/// [entries] comes from the console (`RemoteConfigKeys.whatsNewContent`), not
/// from this build — the same release ships with nothing to say until someone
/// publishes copy for it.
class WhatsNewPage extends StatelessWidget {
  const WhatsNewPage({
    super.key,
    required this.version,
    required this.entries,
    required this.onClose,
  });

  final String version;
  final List<WhatsNewEntry> entries;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final l10n = KaziLocalizations.current;
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(KaziInsets.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.whatsNewTitle,
                      style: KaziTextStyles.labelLarge.copyWith(
                        color: colors.textMuted,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onClose,
                    icon: const Icon(Icons.close),
                    color: colors.textMuted,
                  ),
                ],
              ),
              Text(
                l10n.whatsNewVersion(version),
                style: KaziTextStyles.headlineSmall,
              ),
              KaziSpacings.verticalXs,
              Text(
                l10n.whatsNewSubtitle,
                style: KaziTextStyles.bodyMedium.copyWith(
                  color: colors.textMuted,
                ),
              ),
              KaziSpacings.verticalLg,
              for (final entry in entries) _Entry(entry: entry),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: KaziElevatedButton.label(
                  label: l10n.setupResultCta,
                  onTap: onClose,
                  backgroundColor: colors.inverse,
                  foregroundColor: colors.onInverse,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Entry extends StatelessWidget {
  const _Entry({required this.entry});

  final WhatsNewEntry entry;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: KaziInsets.xs),
      padding: const EdgeInsets.all(KaziInsets.sm),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: KaziRadii.smBorder,
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(entry.title, style: KaziTextStyles.titleSmall),
          Text(
            entry.description,
            style: KaziTextStyles.labelSmall.copyWith(color: colors.textMuted),
          ),
        ],
      ),
    );
  }
}
