import 'package:flutter/material.dart';
import 'package:kazi/app/core/environment/environment.dart';
import 'package:kazi/app/core/extensions/extensions.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/widgets/buttons/buttons.dart';
import 'package:kazi/app/features/login/widgets/text_button_link.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: CircularButton(
          onTap: () => context.navigateTo(AppPage.signUp),
          child: const Icon(Icons.chevron_left),
        ),
        title: Padding(
          padding: const EdgeInsets.only(
            bottom: AppSizeConstants.mediumSpace,
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
          padding: const EdgeInsets.only(bottom: AppSizeConstants.largeSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.current.privacyPoliceStart),
              AppSizeConstants.smallVerticalSpacer,
              Text(
                AppLocalizations.current.privacyPoliceInformationTitle,
                style: context.headlineMedium,
              ),
              AppSizeConstants.smallVerticalSpacer,
              Text(AppLocalizations.current.privacyPoliceInformation),
              TextButtonLink(
                onPressed: () => context.navigateTo(
                  AppPage.privacyPolicyWebView,
                  objects: {
                    'title': AppLocalizations.current.privacyPoliceInformation1,
                    'url': Environment.policiesGooglePlayUrl
                  },
                ),
                child: Text(
                    '${AppLocalizations.current.privacyPoliceInformation1};'),
              ),
              TextButtonLink(
                onPressed: () => context.navigateTo(
                  AppPage.privacyPolicyWebView,
                  objects: {
                    'title': AppLocalizations.current.privacyPoliceInformation2,
                    'url': Environment.policiesAdMobUrl
                  },
                ),
                child: Text(
                    '${AppLocalizations.current.privacyPoliceInformation2};'),
              ),
              TextButtonLink(
                onPressed: () => context.navigateTo(
                  AppPage.privacyPolicyWebView,
                  objects: {
                    'title': AppLocalizations.current.privacyPoliceInformation3,
                    'url': Environment.policiesFirebaseAnalyticsUrl
                  },
                ),
                child: Text(
                    '${AppLocalizations.current.privacyPoliceInformation3};'),
              ),
              TextButtonLink(
                onPressed: () => context.navigateTo(
                  AppPage.privacyPolicyWebView,
                  objects: {
                    'title': AppLocalizations.current.privacyPoliceInformation4,
                    'url': Environment.policiesFirebaseCrashlyticsUrl
                  },
                ),
                child: Text(
                    '${AppLocalizations.current.privacyPoliceInformation4}.'),
              ),
              AppSizeConstants.smallVerticalSpacer,
              Text(
                AppLocalizations.current.privacyPoliceLogDataTitle,
                style: context.headlineMedium,
              ),
              AppSizeConstants.smallVerticalSpacer,
              Text(AppLocalizations.current.privacyPoliceLogData),
              AppSizeConstants.smallVerticalSpacer,
              Text(
                AppLocalizations.current.privacyPoliceCookiesTitle,
                style: context.headlineMedium,
              ),
              AppSizeConstants.smallVerticalSpacer,
              Text(AppLocalizations.current.privacyPoliceCookies),
              AppSizeConstants.smallVerticalSpacer,
              Text(
                AppLocalizations.current.privacyPoliceServicesTitle,
                style: context.headlineMedium,
              ),
              AppSizeConstants.smallVerticalSpacer,
              Text(AppLocalizations.current.privacyPoliceServices),
              AppSizeConstants.smallVerticalSpacer,
              Text(
                AppLocalizations.current.privacyPoliceSecurityTitle,
                style: context.headlineMedium,
              ),
              AppSizeConstants.smallVerticalSpacer,
              Text(AppLocalizations.current.privacyPoliceSecurity),
              AppSizeConstants.smallVerticalSpacer,
              Text(
                AppLocalizations.current.pricayPoliceLinksTitle,
                style: context.headlineMedium,
              ),
              AppSizeConstants.smallVerticalSpacer,
              Text(AppLocalizations.current.pricayPoliceLinks),
              AppSizeConstants.smallVerticalSpacer,
              Text(
                AppLocalizations.current.privacyPoliceChildrenTitle,
                style: context.headlineMedium,
              ),
              AppSizeConstants.smallVerticalSpacer,
              Text(AppLocalizations.current.privacyPoliceChildren),
              AppSizeConstants.smallVerticalSpacer,
              Text(
                AppLocalizations.current.privacyPoliceChangesTitle,
                style: context.headlineMedium,
              ),
              AppSizeConstants.smallVerticalSpacer,
              Text(AppLocalizations.current.privacyPoliceChanges),
              AppSizeConstants.smallVerticalSpacer,
              Text(
                AppLocalizations.current.privacyPoliceContactTitle,
                style: context.headlineMedium,
              ),
              AppSizeConstants.smallVerticalSpacer,
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
              AppSizeConstants.smallVerticalSpacer,
              Text(AppLocalizations.current.privacyPoliceEnd),
            ],
          ),
        ),
      ),
    );
  }
}
