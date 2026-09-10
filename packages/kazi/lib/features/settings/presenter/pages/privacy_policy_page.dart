import 'package:flutter/material.dart';
import 'package:kazi/core/constants/app_urls.dart';
import 'package:kazi/core/widgets/sub_nav_bar.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

/// A readable summary of the privacy policy, with the full text below it.
///
/// The full text stays in the app rather than only behind the web link: the
/// web copy predates analytics and session recording.
class PrivacyPolicyPage extends ConsumerStatefulWidget {
  const PrivacyPolicyPage({super.key});

  /// When the `privacyPolice*` text last changed. Bump it with the text.
  static final updatedAt = DateTime(2026, 8, 21);

  @override
  ConsumerState<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends ConsumerState<PrivacyPolicyPage> {
  bool _isFullVersionShown = false;

  Future<void> _open(String url) =>
      ref.read(kaziUrlLauncherServiceProvider).launch(url);

  @override
  Widget build(BuildContext context) {
    final l10n = KaziLocalizations.current;
    final locale = Localizations.localeOf(context).toString();
    final updatedAt = DateFormat.yMMMMd(
      locale,
    ).format(PrivacyPolicyPage.updatedAt);

    return Scaffold(
      body: KaziSafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SubNavBar(
              title: l10n.privacy,
              pills: [
                KaziCircularButton.plain(
                  onTap: () => _open(AppUrls.privacyPolicy),
                  semantics: l10n.privacyOpenWebVersion,
                  child: const Icon(Icons.language, size: 18),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: KaziInsets.md,
                bottom: KaziInsets.xxLg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l10n.privacyUpdatedOn(updatedAt),
                    style: KaziTextStyles.bodySmall.copyWith(
                      color: context.colors.textMuted,
                    ),
                  ),
                  KaziSpacings.verticalSm,
                  _SummaryCard(
                    title: l10n.privacySummaryStoredTitle,
                    body: l10n.privacySummaryStored,
                  ),
                  _SummaryCard(
                    title: l10n.privacySummaryNeverTitle,
                    body: l10n.privacySummaryNever,
                  ),
                  _SummaryCard(
                    title: l10n.privacySummaryControlTitle,
                    body: l10n.privacySummaryControl,
                  ),
                  _SummaryCard(
                    title: l10n.privacySummaryDeleteTitle,
                    body: l10n.privacySummaryDelete,
                    onTap: () => _open('mailto:${l10n.contactEmail}'),
                  ),
                  KaziSpacings.verticalXxs,
                  if (_isFullVersionShown)
                    const _FullVersion()
                  else
                    KaziElevatedButton.outlined(
                      onTap: () => setState(() => _isFullVersionShown = true),
                      label: l10n.privacyReadFullVersion,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.title, required this.body, this.onTap});

  final String title;
  final String body;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.only(bottom: KaziInsets.xs),
      child: Material(
        color: colors.card,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: KaziRadii.mdBorder,
          side: BorderSide(color: colors.border),
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(KaziInsets.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: KaziTextStyles.titleSmall),
                KaziSpacings.verticalXxs,
                Text(
                  body,
                  style: KaziTextStyles.bodySmall.copyWith(
                    color: colors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FullVersion extends StatelessWidget {
  const _FullVersion();

  @override
  Widget build(BuildContext context) {
    final l10n = KaziLocalizations.current;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KaziSpacings.verticalSm,
        _Paragraph(l10n.privacyPoliceStart),
        _Section(
          title: l10n.privacyPoliceInformationTitle,
          body: l10n.privacyPoliceInformation,
        ),
        _Providers(
          names: [
            l10n.privacyPoliceInformation1,
            l10n.privacyPoliceInformation2,
            l10n.privacyPoliceInformation3,
            l10n.privacyPoliceInformation4,
            l10n.privacyPoliceInformation5,
            l10n.privacyPoliceInformation6,
          ],
        ),
        _Section(
          title: l10n.privacyPoliceAnalyticsTitle,
          body: l10n.privacyPoliceAnalytics,
        ),
        _Section(
          title: l10n.privacyPoliceReplayTitle,
          body: l10n.privacyPoliceReplay,
        ),
        _Section(
          title: l10n.privacyPoliceRightsTitle,
          body: l10n.privacyPoliceRights,
        ),
        _Section(
          title: l10n.privacyPoliceRetentionTitle,
          body: l10n.privacyPoliceRetention,
        ),
        _Section(
          title: l10n.privacyPoliceLogDataTitle,
          body: l10n.privacyPoliceLogData,
        ),
        _Section(
          title: l10n.privacyPoliceCookiesTitle,
          body: l10n.privacyPoliceCookies,
        ),
        _Section(
          title: l10n.privacyPoliceServicesTitle,
          body: l10n.privacyPoliceServices,
        ),
        _Section(
          title: l10n.privacyPoliceSecurityTitle,
          body: l10n.privacyPoliceSecurity,
        ),
        _Section(
          title: l10n.pricayPoliceLinksTitle,
          body: l10n.pricayPoliceLinks,
        ),
        _Section(
          title: l10n.privacyPoliceChildrenTitle,
          body: l10n.privacyPoliceChildren,
        ),
        _Section(
          title: l10n.privacyPoliceChangesTitle,
          body: l10n.privacyPoliceChanges,
        ),
        _Section(
          title: l10n.privacyPoliceContactTitle,
          body: '${l10n.privacyPoliceContact}${l10n.contactEmail}',
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: KaziInsets.lg,
            bottom: KaziInsets.xs,
          ),
          child: Text(title, style: context.text.titleMedium),
        ),
        _Paragraph(body),
      ],
    );
  }
}

class _Paragraph extends StatelessWidget {
  const _Paragraph(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: KaziTextStyles.bodyMedium.copyWith(
        color: context.colors.textMuted,
      ),
    );
  }
}

class _Providers extends StatelessWidget {
  const _Providers({required this.names});

  final List<String> names;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.only(top: KaziInsets.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final name in names)
            Padding(
              padding: const EdgeInsets.only(bottom: KaziInsets.xxs),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: KaziInsets.xxs),
                    child: KaziColorDot(color: colors.textMuted, size: 6),
                  ),
                  KaziSpacings.horizontalXs,
                  Expanded(
                    child: Text(
                      name,
                      style: KaziTextStyles.bodyMedium.copyWith(
                        color: colors.text,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
