import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/app/core/routes/routes.dart';
import 'package:kazi/app/core/widgets/layout/layout.dart';

import 'app_cubit.dart';
import 'core/l10n/generated/l10n.dart';

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
    final cubit = context.read<AppCubit>();

    return Scaffold(
      appBar: const CustomAppBar(),
      body: WillPopScope(
        //TODO: Add bottom sheet to ask if the user wants to leave
        onWillPop: () async => false,
        child: widget.child,
      ),
      //TODO: Create a new toaster
      //TODO: Create a bottomNavigationBar with floatActionButton to remove this property and avoid hide fields with keyboard
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
            onPressed: () => context.floatingActionNavigation(),
            tooltip: AppLocalizations.current.newService,
            child: Icon(
              cubit.state == AppPages.addServices ? Icons.close : Icons.add,
            ),
          ),
        ),
      ),
    );
  }

  void _onTapBottomItem(int index, BuildContext context) {
    final page = AppPages.fromIndex(index);
    context.navigateTo(page);
  }
}
