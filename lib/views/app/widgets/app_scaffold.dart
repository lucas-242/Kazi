import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_services/views/app/app.dart';

import '../../home/pages/home_page.dart';
import '/views/settings/settings.dart';
import 'app_bottom_navigation.dart';

class AppScaffold extends StatefulWidget {
  final globalKey = GlobalKey();
  AppScaffold({Key? key}) : super(key: key);

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
          child: BlocBuilder<AppCubit, int>(builder: (context, state) {
            return [
              const HomePage(),
              Container(color: Colors.amber),
              const SettingsPage(),
            ][state];
          }),
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        key: widget.globalKey,
        currentPage: context.watch<AppCubit>().state,
        onTap: (index) => context.read<AppCubit>().changePage(index),
      ),
    );
  }
}
