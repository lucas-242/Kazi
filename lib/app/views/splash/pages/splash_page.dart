import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../injector_container.dart';
import '../../../models/app_user.dart';
import '../../../services/auth_service/auth_service.dart';
import '../../../shared/routes/app_routes.dart';
import '../../../shared/themes/themes.dart';

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
    final auth = injector<AuthService>();
    userStream = auth.userChanges().listen((user) {
      if (user != null) {
        auth.user = user;
        Navigator.pushReplacementNamed(context, AppRoutes.app);
        userStream.cancel();
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'My',
              style: context.headlineLarge,
              textAlign: TextAlign.center,
            ),
          ),
          Center(
            child: Text(
              'Services',
              style: context.headlineLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
