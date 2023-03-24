import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/themes/extensions/theme_extension.dart';
import 'package:my_services/app/shared/widgets/custom_app_bar/custom_app_bar.dart';

import 'app_cubit.dart';
import 'shared/routes/app_routes.dart';
import 'shared/widgets/custom_bottom_navigation/custom_bottom_navigation.dart';
import 'views/calendar/calendar.dart';
import 'views/home/pages/home_page.dart';
import 'views/settings/settings.dart';

class AppScaffold extends StatefulWidget {
  final Widget child;
  const AppScaffold({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
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
    return BlocBuilder<AppCubit, int>(
      builder: (context, state) {
        return Scaffold(
          appBar: const CustomAppBar(),
          body: widget.child,
          bottomNavigationBar: CustomBottomNavigation(
            currentPage: context.watch<AppCubit>().state,
            onTap: (index) {
              context.read<AppCubit>().changePage(index);
              _onItemTapped(index, context);
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () => context.go(AppRoutes.addServices),
            tooltip: AppLocalizations.current.addNewService,
            elevation: 0,
            highlightElevation: 0,
            backgroundColor: context.colorsScheme.primary,
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go(AppRoutes.home);
        break;
      case 1:
        GoRouter.of(context).go(AppRoutes.services);
        break;
      case 2:
        GoRouter.of(context).go(AppRoutes.calculator);
        break;
      case 3:
        GoRouter.of(context).go(AppRoutes.profile);
        break;
    }
  }
}
