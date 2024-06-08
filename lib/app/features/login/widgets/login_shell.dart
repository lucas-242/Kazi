import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/widgets/layout/layout.dart';

class LoginShell extends StatelessWidget {
  const LoginShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: CustomSafeArea(
        padding: const EdgeInsets.only(top: AppInsets.lg),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              collapsedHeight: 73,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppAssets.logoExtended,
                    height: AppSizings.logoHeight,
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  AppSpacings.verticalLg,
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: AppInsets.xLg,
                        left: AppInsets.xLg,
                        right: AppInsets.xLg,
                      ),
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: child,
                    ),
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
