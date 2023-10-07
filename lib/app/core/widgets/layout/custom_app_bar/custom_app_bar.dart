import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kazi/app/core/auth/auth.dart';
import 'package:kazi/app/core/constants/app_onboarding.dart';
import 'package:kazi/app/core/routes/routes.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/service_locator.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.showOrderBy = false,
    this.onSelectedOrderBy,
  }) : super(key: key);

  final bool showOrderBy;
  final VoidCallback? onSelectedOrderBy;

  @override
  Size get preferredSize => const Size(0.0, 75.0);

  @override
  Widget build(BuildContext context) {
    final user = ServiceLocator.get<Auth>().user;

    return AppBar(
      toolbarHeight: preferredSize.height,
      centerTitle: true,
      automaticallyImplyLeading: false,
      foregroundColor: context.colorsScheme.onSurface,
      title: Row(
        children: [
          AppSizeConstants.smallHorizontalSpacer,
          TextButton(
            key: AppOnboarding.stepFive,
            onPressed: () => context.navigateTo(AppPages.profile),
            child: SizedBox(
              width: 48.0,
              height: 48.0,
              child: CircleAvatar(
                backgroundImage: user?.photoUrl != null
                    ? NetworkImage(user?.photoUrl ?? '')
                    : null,
                backgroundColor: AppColors.white,
                child: user?.photoUrl == null
                    ? Text(
                        '🦆',
                        style: context.cardTitle!.copyWith(fontSize: 38),
                      )
                    : null,
              ),
            ),
          ),
          AppSizeConstants.smallHorizontalSpacer,
          Text(
            user?.shortName ?? '',
            style: context.appBarTitle,
          ),
        ],
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(25),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: SvgPicture.asset(AppAssets.logo),
        ),
      ],
    );
  }
}
