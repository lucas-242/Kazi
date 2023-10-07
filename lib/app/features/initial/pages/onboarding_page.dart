import 'package:flutter/material.dart';
import 'package:kazi/app/core/constants/app_onboarding.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/routes/routes.dart';
import 'package:kazi/app/core/themes/extensions/theme_extension.dart';
import 'package:kazi/app/core/themes/extensions/typography_extension.dart';
import 'package:kazi/app/core/themes/settings/app_assets.dart';
import 'package:kazi/app/core/themes/settings/app_size_constants.dart';
import 'package:kazi/app/core/widgets/buttons/buttons.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorsScheme.surface,
      body: WillPopScope(
        //TODO: Add bottom sheet to ask if the user wants to leave
        onWillPop: () async => false,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppSizeConstants.hugeSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(AppAssets.onboarding),
                  ),
                  RichText(
                    text: TextSpan(
                      text: AppLocalizations.current.onboardingTitle1,
                      style: context.headlineLarge,
                      children: [
                        TextSpan(
                          text: AppLocalizations.current.onboardingTitle2,
                          style: context.headlineLarge!
                              .copyWith(color: context.colorsScheme.primary),
                        ),
                      ],
                    ),
                  ),
                  AppSizeConstants.smallVerticalSpacer,
                  Text(
                    AppLocalizations.current.onboardingSubtitle,
                    style: context.headlineSmall,
                  ),
                  AppSizeConstants.hugeVerticalSpacer,
                  Center(
                    child: CircularButton(
                      iconSize: 54,
                      onTap: () {
                        AppOnboarding.onCompleteOnboarding(context);
                        context.navigateTo(AppPages.home);
                      },
                      child: const Icon(Icons.chevron_right),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
