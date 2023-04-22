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
  late StreamSubscription<AppUser?> userStream;

  @override
  void initState() {
    _listenUser();
    super.initState();
  }

  void _listenUser() {
    final auth = serviceLocator<AuthService>();
    userStream = auth.userChanges().listen((user) {
      if (user != null) {
        auth.user = user;
        context.go(AppRoutes.onboarding);
      } else {
        context.go(AppRoutes.login);
      }
    });
  }

  @override
  void dispose() {
    userStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorsScheme.primary,
      body: Center(
        //TODO: Animate it - OnInit text show up from behind centered image. On dispose, text collapse to the image
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppAssets.logo),
            Text('Kazi', style: context.loginTitle)
          ],
        ),
      ),
    );
  }
}
