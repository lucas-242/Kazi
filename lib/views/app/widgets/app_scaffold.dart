import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../home/pages/home_page.dart';
import '../view_model/app_view_model.dart';
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
    var appBloc = context.watch<AppViewModel>();
    return Scaffold(
      body: [
        const HomePage(),
        Container(color: Colors.amber),
        const SettingsPage(),
      ][appBloc.currentPageIndex],
      bottomNavigationBar: AppBottomNavigationBar(
          key: widget.globalKey,
          currentPage: appBloc.currentPageIndex,
          onTap: (index) => appBloc.changePage(index)),
    );
  }
}
