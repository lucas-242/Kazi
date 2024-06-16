import 'package:flutter/material.dart';
import 'package:kazi/core/environment/environment.dart';
import 'package:kazi/core/l10n/generated/l10n.dart';
import 'package:kazi/core/routes/routes.dart';
import 'package:kazi/presenter/login/components/text_button_link.dart';
import 'package:kazi_core/kazi_core.dart';
import 'package:kazi_design_system/kazi_design_system.dart';
import 'package:kazi_design_system/themes/themes.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KaziColors.white,
      appBar: AppBar(
        leading: KaziCircularButton(
          onTap: () => context.navigateTo(AppPages.signUp),
          child: const Icon(Icons.chevron_left),
        ),
        title: Padding(
          padding: const EdgeInsets.only(
            bottom: KaziInsets.md,
          ),
          child: Text(
            AppLocalizations.current.privacyPolice,
            style: context.headlineMedium,
          ),
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: KaziColors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: KaziInsets.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.current.privacyPoliceStart),
              KaziSpacings.verticalSm,
              Text(
                AppLocalizations.current.privacyPoliceInformationTitle,
                style: context.headlineMedium,
              ),
              KaziSpacings.verticalSm,
              Text(AppLocalizations.current.privacyPoliceInformation),
              TextButtonLink(
                onPressed: () => context.navigateTo(
                  AppPages.privacyPolicyWebView,
                  webViewParams: WebViewParams(
                    AppLocalizations.current.privacyPoliceInformation1,
                    Environment.policiesGooglePlayUrl,
                  ),
                ),
                child: Text(
                    '${AppLocalizations.current.privacyPoliceInformation1};'),
              ),
              TextButtonLink(
                onPressed: () => context.navigateTo(
                  AppPages.privacyPolicyWebView,
                  webViewParams: WebViewParams(
                    AppLocalizations.current.privacyPoliceInformation2,
                    Environment.policiesAdMobUrl,
                  ),
                ),
                child: Text(
                    '${AppLocalizations.current.privacyPoliceInformation2};'),
              ),
              TextButtonLink(
                onPressed: () => context.navigateTo(
                  AppPages.privacyPolicyWebView,
                  webViewParams: WebViewParams(
                    AppLocalizations.current.privacyPoliceInformation3,
                    Environment.policiesFirebaseAnalyticsUrl,
                  ),
                ),
                child: Text(
                    '${AppLocalizations.current.privacyPoliceInformation3};'),
              ),
              TextButtonLink(
                onPressed: () => context.navigateTo(
                  AppPages.privacyPolicyWebView,
                  webViewParams: WebViewParams(
                    AppLocalizations.current.privacyPoliceInformation4,
                    Environment.policiesFirebaseCrashlyticsUrl,
                  ),
                ),
                child: Text(
                    '${AppLocalizations.current.privacyPoliceInformation4}.'),
              ),
              KaziSpacings.verticalSm,
              Text(
                AppLocalizations.current.privacyPoliceLogDataTitle,
                style: context.headlineMedium,
              ),
              KaziSpacings.verticalSm,
              Text(AppLocalizations.current.privacyPoliceLogData),
              KaziSpacings.verticalSm,
              Text(
                AppLocalizations.current.privacyPoliceCookiesTitle,
                style: context.headlineMedium,
              ),
              KaziSpacings.verticalSm,
              Text(AppLocalizations.current.privacyPoliceCookies),
              KaziSpacings.verticalSm,
              Text(
                AppLocalizations.current.privacyPoliceServicesTitle,
                style: context.headlineMedium,
              ),
              KaziSpacings.verticalSm,
              Text(AppLocalizations.current.privacyPoliceServices),
              KaziSpacings.verticalSm,
              Text(
                AppLocalizations.current.privacyPoliceSecurityTitle,
                style: context.headlineMedium,
              ),
              KaziSpacings.verticalSm,
              Text(AppLocalizations.current.privacyPoliceSecurity),
              KaziSpacings.verticalSm,
              Text(
                AppLocalizations.current.pricayPoliceLinksTitle,
                style: context.headlineMedium,
              ),
              KaziSpacings.verticalSm,
              Text(AppLocalizations.current.pricayPoliceLinks),
              KaziSpacings.verticalSm,
              Text(
                AppLocalizations.current.privacyPoliceChildrenTitle,
                style: context.headlineMedium,
              ),
              KaziSpacings.verticalSm,
              Text(AppLocalizations.current.privacyPoliceChildren),
              KaziSpacings.verticalSm,
              Text(
                AppLocalizations.current.privacyPoliceChangesTitle,
                style: context.headlineMedium,
              ),
              KaziSpacings.verticalSm,
              Text(AppLocalizations.current.privacyPoliceChanges),
              KaziSpacings.verticalSm,
              Text(
                AppLocalizations.current.privacyPoliceContactTitle,
                style: context.headlineMedium,
              ),
              KaziSpacings.verticalSm,
              RichText(
                text: TextSpan(
                  text: AppLocalizations.current.privacyPoliceContact,
                  style: context.bodyLarge,
                  children: [
                    TextSpan(
                      text: AppLocalizations.current.contactEmail,
                      style: context.bodyLarge!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    const TextSpan(text: '.'),
                  ],
                ),
              ),
              KaziSpacings.verticalSm,
              Text(AppLocalizations.current.privacyPoliceEnd),
            ],
          ),
        ),
      ),
    );
  }
}
