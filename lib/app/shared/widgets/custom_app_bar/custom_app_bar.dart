import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_services/app/services/auth_service/auth_service.dart';

import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/injector_container.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final bool showOrderBy;
  final VoidCallback? onSelectedOrderBy;

  const CustomAppBar({
    Key? key,
    this.showOrderBy = false,
    this.onSelectedOrderBy,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size(0.0, 75.0);

  @override
  Widget build(BuildContext context) {
    final user = injector.get<AuthService>().user;

    return AppBar(
      toolbarHeight: preferredSize.height,
      centerTitle: true,
      automaticallyImplyLeading: false,
      foregroundColor: context.colorsScheme.onSurface,
      title: Row(
        children: [
          const SizedBox(width: 10),
          SizedBox(
            width: 48.0,
            height: 48.0,
            child: CircleAvatar(
              backgroundImage:
                  user!.photoUrl != null ? NetworkImage(user.photoUrl!) : null,
              backgroundColor: AppColors.white,
              child: user.photoUrl == null
                  ? Text(
                      '🦆',
                      style: context.cardTitle!.copyWith(fontSize: 38),
                    )
                  : null,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            AppLocalizations.current.hi(user.shortName),
            style: context.headlineSmall,
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
