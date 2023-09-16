import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/features/login/login.dart';

class LoginLandingContent extends StatelessWidget {
  const LoginLandingContent({super.key, required this.state});

  final LoginState state;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          collapsedHeight: 73,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppAssets.logoExtended,
                height: AppSizeConstants.logoHeight,
              ),
            ],
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              AppSizeConstants.largeVerticalSpacer,
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                    top: AppSizeConstants.bigSpace,
                    left: AppSizeConstants.bigSpace,
                    right: AppSizeConstants.bigSpace,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.isSigningIn
                                ? AppLocalizations.current.signIn
                                : AppLocalizations.current.signUp,
                            style: context.headlineMedium,
                          ),
                          AppSizeConstants.bigVerticalSpacer,
                          if (state.isSigningIn)
                            const SignInForm()
                          else
                            const SignUpForm(),
                          AppSizeConstants.mediumVerticalSpacer,
                        ],
                      ),
                      const LoginSignInChanger(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
