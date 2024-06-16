import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kazi/core/routes/routes.dart';
import 'package:kazi_design_system/kazi_design_system.dart';
import 'package:kazi_design_system/themes/themes.dart';

class LoginShell extends StatelessWidget {
  const LoginShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: KaziColors.primary,
      body: PopScope(
        canPop: false,
        onPopInvoked: (_) => context.showLeftBottomSheet(),
        child: KaziSafeArea(
          padding: const EdgeInsets.only(top: KaziInsets.lg),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                collapsedHeight: 73,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      KaziAssets.logoExtended,
                      height: KaziSizings.logoHeight,
                    ),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  padding: const EdgeInsets.only(
                    top: KaziInsets.xLg,
                    left: KaziInsets.xLg,
                    right: KaziInsets.xLg,
                  ),
                  decoration: const BoxDecoration(
                    color: KaziColors.white,
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
