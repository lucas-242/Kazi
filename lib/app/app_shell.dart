import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:kazi/app/core/extensions/extensions.dart';
import 'package:kazi/app/core/widgets/layout/layout.dart';
import 'package:kazi/app/models/route_params.dart';

import 'app_cubit.dart';
import 'core/l10n/generated/l10n.dart';

class AppShell extends StatefulWidget {
  const AppShell({
    Key? key,
    required this.params,
  }) : super(key: key);

  final RouteParams params;

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
        context.navigateTo(AppPage.signIn);
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
      body: const RouterOutlet(),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: CustomBottomNavigation(
        currentPage: context.watch<AppCubit>().state.value,
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
              cubit.state == AppPage.addServices ? Icons.close : Icons.add,
            ),
          ),
        ),
      ),
    );
  }

  void _onTapFloatingActionButton() {
    final cubit = context.read<AppCubit>();
    if (cubit.state == AppPage.addServices) {
      // context.navigateTo(AppPage.services);
      cubit.changePage(widget.params.lastPage ?? AppPage.home);
      context.navigateBack(params: widget.params);
    } else {
      context.navigateTo(AppPage.addServices);
    }
  }

  void _onTapBottomItem(int index, BuildContext context) {
    final page = AppPage.fromIndex(index);
    context.navigateTo(page);
  }
}
