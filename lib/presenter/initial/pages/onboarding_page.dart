import 'package:flutter/material.dart';
import 'package:kazi/core/constants/app_onboarding.dart';
import 'package:kazi/core/l10n/generated/l10n.dart';
import 'package:kazi/core/routes/routes.dart';
import 'package:kazi_design_system/kazi_design_system.dart';
import 'package:kazi_design_system/themes/themes.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorsScheme.surface,
      body: PopScope(
        onPopInvoked: (_) => context.showLeftBottomSheet(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(KaziInsets.xxxLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(KaziAssets.onboarding),
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
                  KaziSpacings.verticalSm,
                  Text(
                    AppLocalizations.current.onboardingSubtitle,
                    style: context.headlineSmall,
                  ),
                  KaziSpacings.verticalXLg,
                  Center(
                    child: KaziCircularButton(
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
