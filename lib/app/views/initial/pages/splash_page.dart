// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:my_services/app/models/app_user.dart';
import 'package:my_services/app/services/auth_service/auth_service.dart';
import 'package:my_services/app/shared/routes/app_routes.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/injector_container.dart';

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

  late StreamSubscription<AppUser?> userStream;
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
    final auth = serviceLocator<AuthService>();
    userStream = auth
        .userChanges()
        .listen(_onUserChange, onError: (_) => context.go(AppRoutes.login));
  }

  Future<void> _onUserChange(AppUser? user) async {
    if (canNavigate) {
      _checkUser(user);
    } else {
      await Future.delayed(
        const Duration(milliseconds: 500),
        () => _onUserChange(user),
      );
    }
  }

  Future<void> _checkUser(AppUser? user) async {
    // await _closeAnimation();
    if (user != null) {
      _setUser(user);
      context.go(AppRoutes.onboarding);
    } else {
      context.go(AppRoutes.login);
    }
  }

  void _setUser(AppUser? user) {
    final auth = serviceLocator<AuthService>();
    auth.user = user;
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
              height: 70,
            ),
            AnimatedContainer(
              duration: containerAnimationDuration,
              height: 70,
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
