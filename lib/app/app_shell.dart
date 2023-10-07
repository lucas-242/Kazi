import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/app/core/routes/routes.dart';
import 'package:kazi/app/core/widgets/layout/layout.dart';
import 'package:kazi/app/models/route_params.dart';

import 'app_cubit.dart';
import 'core/l10n/generated/l10n.dart';

class AppShell extends StatefulWidget {
  const AppShell({
    Key? key,
    required this.params,
    required this.child,
  }) : super(key: key);

  final RouteParams params;
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
    final cubit = context.read<AppCubit>();

    return Scaffold(
      appBar: const CustomAppBar(),
      body: widget.child,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: CustomBottomNavigation(
        currentPage: cubit.state.value,
        onTap: (index) => _onTapBottomItem(index, context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
            child: Icon(
              cubit.state == AppPages.addServices ? Icons.close : Icons.add,
            ),
          ),
        ),
      ),
    );
  }

  void _onTapFloatingActionButton() {
    final cubit = context.read<AppCubit>();
    if (cubit.state == AppPages.addServices) {
      // context.navigateTo(AppPage.services);
      cubit.changePage(widget.params.lastPage ?? AppPages.home);
      context.navigateBack(params: widget.params);
    } else {
      context.navigateTo(AppPages.addServices);
    }
  }

  void _onTapBottomItem(int index, BuildContext context) {
    final page = AppPages.fromIndex(index);
    context.navigateTo(page);
  }
}
