import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kazi/core/constants/app_onboarding.dart';
import 'package:kazi/core/routes/routes.dart';
import 'package:kazi/domain/services/auth_service.dart';
import 'package:kazi/service_locator.dart';
import 'package:kazi_design_system/themes/themes.dart';

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
    final user = ServiceLocator.get<AuthService>().user;

    return AppBar(
      toolbarHeight: preferredSize.height,
      centerTitle: true,
      automaticallyImplyLeading: false,
      foregroundColor: context.colorsScheme.onSurface,
      title: Row(
        children: [
          KaziSpacings.horizontalSm,
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
                backgroundColor: KaziColors.white,
                child: user?.photoUrl == null
                    ? Text(
                        '🦆',
                        style: context.cardTitle!.copyWith(fontSize: 38),
                      )
                    : null,
              ),
            ),
          ),
          KaziSpacings.horizontalSm,
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
          child: SvgPicture.asset(KaziAssets.logo),
        ),
      ],
    );
  }
}
