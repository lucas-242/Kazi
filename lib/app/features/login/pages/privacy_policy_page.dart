import 'package:flutter/material.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/utils/url_laucher_helper.dart';
import 'package:kazi/app/core/widgets/buttons/buttons.dart';
import 'package:kazi/app/core/widgets/layout/layout.dart';
import 'package:kazi/app/features/login/widgets/text_button_link.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomSafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: AppSizeConstants.largeSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackAndPill(text: AppLocalizations.current.privacyPolice),
                AppSizeConstants.mediumVerticalSpacer,
                Text(AppLocalizations.current.privacyPoliceStart),
                AppSizeConstants.smallVerticalSpacer,
                Text(
                  AppLocalizations.current.privacyPoliceInformationTitle,
                  style: context.headlineMedium,
                ),
                AppSizeConstants.smallVerticalSpacer,
                Text(AppLocalizations.current.privacyPoliceInformation),
                TextButtonLink(
                  onPressed: () => UrlLauncherHelper.launch(
                      'https://www.google.com/policies/privacy/'),
                  child:
                      Text(AppLocalizations.current.privacyPoliceInformation1),
                ),
                TextButtonLink(
                  onPressed: () => UrlLauncherHelper.launch(
                      'https://support.google.com/admob/answer/6128543?hl=en'),
                  child:
                      Text(AppLocalizations.current.privacyPoliceInformation2),
                ),
                TextButtonLink(
                  onPressed: () => UrlLauncherHelper.launch(
                      'https://firebase.google.com/policies/analytics'),
                  child:
                      Text(AppLocalizations.current.privacyPoliceInformation3),
                ),
                TextButtonLink(
                  onPressed: () => UrlLauncherHelper.launch(
                      'https://firebase.google.com/support/privacy/'),
                  child:
                      Text(AppLocalizations.current.privacyPoliceInformation4),
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
      ),
    );
  }
}
