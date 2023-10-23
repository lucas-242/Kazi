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
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.primary,
      body: WillPopScope(
        onWillPop: () async {
          final shouldPop = await context.showLeftBottomSheet();
          return shouldPop ?? false;
        },
        child: CustomSafeArea(
          padding: const EdgeInsets.only(top: AppSizeConstants.largeSpace),
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
                      height: AppSizeConstants.logoHeight,
                    ),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
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
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
