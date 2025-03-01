import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kazi/app/services/auth_service/auth_service.dart';
import 'package:kazi/app/shared/constants/app_onboarding.dart';
import 'package:kazi/app/shared/extensions/extensions.dart';
import 'package:kazi/app/shared/themes/themes.dart';
import 'package:kazi/injector_container.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.showOrderBy = false,
    this.onSelectedOrderBy,
  });

  final bool showOrderBy;
  final VoidCallback? onSelectedOrderBy;

  @override
  Size get preferredSize => const Size(0.0, 75.0);

  @override
  Widget build(BuildContext context) {
    final user = serviceLocator.get<AuthService>().user;

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
            onPressed: () => context.navigateTo(AppPage.profile),
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
