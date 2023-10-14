import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/app/core/routes/routes.dart';
import 'package:kazi/app/core/themes/extensions/theme_extension.dart';
import 'package:kazi/app/core/themes/settings/app_size_constants.dart';
import 'package:kazi/app/core/widgets/layout/layout.dart';

import 'app_cubit.dart';

class AppShell extends StatefulWidget {
  const AppShell({
    Key? key,
    required this.child,
  }) : super(key: key);

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
      body: WillPopScope(
        onWillPop: () async {
          final shouldPop = await context.showLeftBottomSheet();
          return shouldPop ?? false;
        },
        child: Stack(
          children: [
            SizedBox(
                height: context.height - AppSizeConstants.bottomAppBarHeight,
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
