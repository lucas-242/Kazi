import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kazi/app/core/routes/routes.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/widgets/layout/layout.dart';

import 'app_cubit.dart';

class AppShell extends StatefulWidget {
  const AppShell({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late StreamSubscription<bool> userStream;

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) => showOnboarding());
    _listenUser();
    super.initState();
  }

  // void showOnboarding() {
  //     AppOnboarding.instance.show(context: context);
  // }

  void _listenUser() {
    userStream = context.read<AppCubit>().userSignOut().listen((userSignOut) {
      if (userSignOut) {
        context.navigateTo(AppPages.signIn);
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
    final state = context.read<AppCubit>().state;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: PopScope(
        canPop: false,
        onPopInvoked: (_) =>
            context.showLeftBottomSheet().then((shouldPop) => context.pop),
        child: Stack(
          children: [
            SizedBox(
                height: context.height - AppSizings.bottomAppBarHeight,
                child: widget.child),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomBottomNavigation(
                currentPage: state,
                onTap: (index) => _onTapBottomItem(index, context),
                onTapFloatingButton: context.navigateToAddServices,
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }

  void _onTapBottomItem(int index, BuildContext context) {
    final page = AppPages.fromIndex(index);
    context.navigateTo(page);
  }
}
