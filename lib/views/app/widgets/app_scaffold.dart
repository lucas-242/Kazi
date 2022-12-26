import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_services/views/app/app.dart';
import 'package:my_services/views/calendar/calendar.dart';

import '../../../shared/routes/app_routes.dart';
import '../../home/pages/home_page.dart';
import '/views/settings/settings.dart';
import 'app_bottom_navigation.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({Key? key}) : super(key: key);

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
    return BlocBuilder<AppCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: [
            const HomePage(),
            const CalendarPage(),
            const SettingsPage(),
          ][state],
          bottomNavigationBar: AppBottomNavigationBar(
            currentPage: context.watch<AppCubit>().state,
            onTap: (index) => context.read<AppCubit>().changePage(index),
          ),
        );
      },
    );
  }
}
