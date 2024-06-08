import 'package:flutter/material.dart';
import 'package:kazi/app/core/environment/environment.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/routes/routes.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/widgets/buttons/buttons.dart';
import 'package:kazi/app/features/login/widgets/text_button_link.dart';
import 'package:kazi/app/models/route_params.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: CircularButton(
          onTap: () => context.navigateTo(AppPages.signUp),
          child: const Icon(Icons.chevron_left),
        ),
        title: Padding(
          padding: const EdgeInsets.only(
            bottom: AppInsets.md,
          ),
          child: Text(
            AppLocalizations.current.privacyPolice,
            style: context.headlineMedium,
          ),
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: AppInsets.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.current.privacyPoliceStart),
              AppSpacings.verticalSm,
              Text(
                AppLocalizations.current.privacyPoliceInformationTitle,
                style: context.headlineMedium,
              ),
              AppSpacings.verticalSm,
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
              AppSpacings.verticalSm,
              Text(
                AppLocalizations.current.privacyPoliceLogDataTitle,
                style: context.headlineMedium,
              ),
              AppSpacings.verticalSm,
              Text(AppLocalizations.current.privacyPoliceLogData),
              AppSpacings.verticalSm,
              Text(
                AppLocalizations.current.privacyPoliceCookiesTitle,
                style: context.headlineMedium,
              ),
              AppSpacings.verticalSm,
              Text(AppLocalizations.current.privacyPoliceCookies),
              AppSpacings.verticalSm,
              Text(
                AppLocalizations.current.privacyPoliceServicesTitle,
                style: context.headlineMedium,
              ),
              AppSpacings.verticalSm,
              Text(AppLocalizations.current.privacyPoliceServices),
              AppSpacings.verticalSm,
              Text(
                AppLocalizations.current.privacyPoliceSecurityTitle,
                style: context.headlineMedium,
              ),
              AppSpacings.verticalSm,
              Text(AppLocalizations.current.privacyPoliceSecurity),
              AppSpacings.verticalSm,
              Text(
                AppLocalizations.current.pricayPoliceLinksTitle,
                style: context.headlineMedium,
              ),
              AppSpacings.verticalSm,
              Text(AppLocalizations.current.pricayPoliceLinks),
              AppSpacings.verticalSm,
              Text(
                AppLocalizations.current.privacyPoliceChildrenTitle,
                style: context.headlineMedium,
              ),
              AppSpacings.verticalSm,
              Text(AppLocalizations.current.privacyPoliceChildren),
              AppSpacings.verticalSm,
              Text(
                AppLocalizations.current.privacyPoliceChangesTitle,
                style: context.headlineMedium,
              ),
              AppSpacings.verticalSm,
              Text(AppLocalizations.current.privacyPoliceChanges),
              AppSpacings.verticalSm,
              Text(
                AppLocalizations.current.privacyPoliceContactTitle,
                style: context.headlineMedium,
              ),
              AppSpacings.verticalSm,
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
              AppSpacings.verticalSm,
              Text(AppLocalizations.current.privacyPoliceEnd),
            ],
          ),
        ),
      ),
    );
  }
}
