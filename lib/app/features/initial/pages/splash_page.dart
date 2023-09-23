// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kazi/app/core/auth/auth.dart';
import 'package:kazi/app/core/extensions/extensions.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/models/user.dart';
import 'package:kazi/injector_container.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final containerAnimationDuration = const Duration(milliseconds: 1000);
  final opacityAnimationDuration = const Duration(milliseconds: 1100);
  final minimumSplashTime = const Duration(milliseconds: 3500);
  final delayToInitAnimation = const Duration(milliseconds: 1000);

  late StreamSubscription<User?> userStream;
  late Timer timer;

  bool showText = false;
  bool canNavigate = false;

  @override
  void initState() {
    timer = Timer(minimumSplashTime, () => canNavigate = true);
    WidgetsBinding.instance.addPostFrameCallback((_) => _initAnimation());
    _listenUser();
    super.initState();
  }

  Future<void> _initAnimation() async {
    await Future.delayed(
      delayToInitAnimation,
      () => setState(() => showText = true),
    );
  }

  void _listenUser() {
    final auth = serviceLocator<Auth>();
    userStream = auth.userChanges.listen(_onUserChange,
        onError: (_) => context.navigateTo(AppPage.signIn));
  }

  Future<void> _onUserChange(User? user) async {
    if (canNavigate) {
      _checkUser(user);
    } else {
      await Future.delayed(
        const Duration(milliseconds: 500),
        () => _onUserChange(user),
      );
    }
  }

  Future<void> _checkUser(User? user) async {
    // await _closeAnimation();
    if (user != null) {
      context.navigateTo(AppPage.onboarding);
    } else {
      context.navigateTo(AppPage.signIn);
    }
  }

  // Future<void> _closeAnimation() async {
  //   setState(() => showText = false);
  //   await Future.delayed(opacityAnimationDuration);
  // }

  @override
  void dispose() {
    userStream.cancel();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorsScheme.primary,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              AppAssets.logo,
              height: 55,
            ),
            AnimatedContainer(
              duration: containerAnimationDuration,
              height: AppSizeConstants.logoHeight,
              width: showText ? context.width * 0.19 : 0,
              child: Center(
                child: AnimatedOpacity(
                  duration: opacityAnimationDuration,
                  opacity: showText ? 1 : 0,
                  child: Text(
                    'Kazi',
                    style: context.loginTitle,
                    softWrap: false,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
