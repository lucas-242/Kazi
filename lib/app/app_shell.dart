import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/widgets/layout/layout.dart';

import 'app_cubit.dart';
import 'shared/routes/app_routes.dart';

class AppShell extends StatefulWidget {
  final Widget child;
  const AppShell({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late StreamSubscription<bool> userStream;

  @override
  void initState() {
    context.read<AppCubit>().changePage(0);
    _listenUser();
    super.initState();
  }

  void _listenUser() {
    userStream = context.read<AppCubit>().userSignOut().listen((userSignOut) {
      if (userSignOut) {
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
    final cubit = context.read<AppCubit>();

    return BlocBuilder<AppCubit, int>(
      builder: (context, state) {
        return Scaffold(
          appBar: const CustomAppBar(),
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
      context.go(AppRoutes.addServices);
    }
  }

  void _onTapBottomItem(int index, BuildContext context) {
    context.read<AppCubit>().changePage(index);
    switch (index) {
      case 0:
        context.go(AppRoutes.home);
        break;
      case 1:
        context.go(AppRoutes.services);
        break;
      case 2:
        context.go(AppRoutes.calculator);
        break;
      case 3:
        context.go(AppRoutes.profile);
        break;
    }
  }
}
