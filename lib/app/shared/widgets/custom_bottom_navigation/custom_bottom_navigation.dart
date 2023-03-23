import 'package:flutter/material.dart';
import 'package:my_services/app/shared/extensions/extensions.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/widgets/custom_bottom_navigation/widgets/bottom_navigation_button.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentPage;
  final void Function(int) onTap;
  const CustomBottomNavigation({
    Key? key,
    this.currentPage = 0,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BottomNavigationButton(
            onTap: () => onTap(0),
            icon: AppAssets.home,
            label: 'Home',
            isSelected: currentPage == 0,
          ),
          BottomNavigationButton(
            onTap: () => onTap(1),
            icon: AppAssets.services,
            label: AppLocalizations.current.services.capitalize(),
            isSelected: currentPage == 1,
            padding: const EdgeInsets.only(right: 32.0),
          ),
          BottomNavigationButton(
            onTap: () => onTap(2),
            icon: AppAssets.calculator,
            label: AppLocalizations.current.calculator,
            isSelected: currentPage == 2,
            padding: const EdgeInsets.only(left: 32.0),
          ),
          BottomNavigationButton(
            onTap: () => onTap(3),
            icon: AppAssets.person,
            label: AppLocalizations.current.profile,
            isSelected: currentPage == 3,
          ),
        ],
      ),
    );

    // return BottomNavigationBar(
    //   currentIndex: currentPage,
    //   type: BottomNavigationBarType.fixed,
    //   items: [
    //     BottomNavigationBarItem(
    //         icon: Icon(Icons.home, color: Color.fromARGB(255, 0, 0, 0)),
    //         label: 'Home'),
    //     BottomNavigationBarItem(
    //         icon: Icon(Icons.power, color: Color.fromARGB(255, 0, 0, 0)),
    //         label: 'Power')
    //   ],
    //   onTap: onTap,
    // );

    // return BottomNavigationBar(
    //   currentIndex: currentPage,
    //   onTap: (index) => onTap(index),

    //   items: [
    //     const BottomNavigationBarItem(
    //       activeIcon: Icon(Icons.home),
    //       icon: Icon(Icons.home_outlined),
    //       label: 'Home',
    //     ),
    //     BottomNavigationBarItem(
    //       activeIcon: const Icon(Icons.calendar_month),
    //       icon: const Icon(Icons.calendar_month_outlined),
    //       label: AppLocalizations.current.calendar,
    //     ),
    //     BottomNavigationBarItem(
    //       activeIcon: const Icon(Icons.settings),
    //       icon: const Icon(Icons.settings_outlined),
    //       label: AppLocalizations.current.settings,
    //     ),
    //     BottomNavigationBarItem(
    //       activeIcon: const Icon(Icons.person),
    //       icon: const Icon(Icons.person),
    //       label: AppLocalizations.current.settings,
    //     ),
    //   ],
    // );
  }
}
