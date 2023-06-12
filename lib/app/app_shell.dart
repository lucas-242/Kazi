import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kazi/app/shared/constants/app_onboarding.dart';
import 'package:kazi/app/shared/widgets/layout/layout.dart';

import 'app_cubit.dart';
import 'shared/l10n/generated/l10n.dart';
import 'shared/routes/app_router.dart';

class AppShell extends StatefulWidget {
  const AppShell({
    Key? key,
    required this.child,
    this.showOnboarding = true,
  }) : super(key: key);

  final Widget child;
  final bool showOnboarding;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late StreamSubscription<bool> userStream;

  @override
  void initState() {
    context.read<AppCubit>().changePage(0);
    Future.delayed(const Duration(seconds: 1), showOnboarding);
    // WidgetsBinding.instance.addPostFrameCallback((_) => showOnboarding());
    _listenUser();
    super.initState();
  }

  void showOnboarding() {
    if (widget.showOnboarding) {
      AppOnboarding.instance.show(context: context);
    }
  }

  void _listenUser() {
    userStream = context.read<AppCubit>().userSignOut().listen((userSignOut) {
      if (userSignOut) {
        context.go(AppRouter.login);
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
    final cubit = context.read<AppCubit>();

    return BlocBuilder<AppCubit, int>(
      builder: (context, state) {
        return Scaffold(
          // appBar: const CustomAppBar(),
          body: widget.child,
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: CustomBottomNavigation(
            currentPage: context.watch<AppCubit>().state,
            onTap: (index) => _onTapBottomItem(index, context),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Align(
            alignment: Alignment.bottomCenter,
            heightFactor: 1.5,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 4),
                shape: BoxShape.circle,
              ),
              child: FloatingActionButton(
                onPressed: _onTapFloatingActionButton,
                tooltip: AppLocalizations.current.newService,
                child: Icon(cubit.isAddServicePage ? Icons.close : Icons.add),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onTapFloatingActionButton() {
    final cubit = context.read<AppCubit>();
    if (cubit.isAddServicePage) {
      _onTapBottomItem(1, context);
    } else {
      cubit.changeToAddServicePage();
      context.go(AppRouter.addServices);
    }
  }

  void _onTapBottomItem(int index, BuildContext context) {
    context.read<AppCubit>().changePage(index);
    switch (index) {
      case 0:
        context.go(AppRouter.home);
        break;
      case 1:
        context.go(AppRouter.services);
        break;
      case 2:
        context.go(AppRouter.calculator);
        break;
      case 3:
        context.go(AppRouter.profile);
        break;
    }
  }
}
