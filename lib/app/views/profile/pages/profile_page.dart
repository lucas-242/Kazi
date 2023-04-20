import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_services/app/data/local_storage/local_storage.dart';
import 'package:my_services/app/models/app_user.dart';
import 'package:my_services/app/services/auth_service/auth_service.dart';
import 'package:my_services/app/shared/constants/global_keys.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/routes/app_routes.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/widgets/layout/layout.dart';
import 'package:my_services/app/shared/widgets/texts/row_text/row_text.dart';
import 'package:my_services/app/views/profile/widgets/option_button.dart';
import 'package:my_services/injector_container.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppUser user = serviceLocator.get<AuthService>().user!;

    Future<void> onSignOut() async {
      await serviceLocator.get<AuthService>().signOut();
      await serviceLocator
          .get<LocalStorage>()
          .remove(GlobalKeys.showOnboardingStorage);
    }

    return CustomScaffold(
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(
                AppSizeConstants.largeSpace,
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: 120.0,
                    height: 120.0,
                    child: CircleAvatar(
                      backgroundImage: user.photoUrl != null
                          ? NetworkImage(user.photoUrl!)
                          : null,
                      backgroundColor: AppColors.white,
                      child: user.photoUrl == null
                          ? Text(
                              '🦆',
                              style: context.cardTitle!.copyWith(fontSize: 80),
                            )
                          : null,
                    ),
                  ),
                  AppSizeConstants.largeVerticalSpacer,
                  Text(user.name, style: context.titleMedium),
                  AppSizeConstants.bigVerticalSpacer,
                  user.phoneNumber != null && user.phoneNumber!.isNotEmpty
                      ? Column(
                          children: [
                            RowText(
                              leftText: AppLocalizations.current.phone,
                              rightText: user.phoneNumber!,
                              rightTextStyle: context.titleSmall!
                                  .copyWith(fontWeight: FontWeight.w400),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: AppSizeConstants.largeSpace,
                              ),
                              child: Divider(),
                            ),
                          ],
                        )
                      : AppSizeConstants.emptyWidget,
                  RowText(
                    leftText: AppLocalizations.current.email,
                    rightText: user.email,
                    rightTextStyle: context.bodyMedium,
                  ),
                  AppSizeConstants.largeVerticalSpacer,
                  const Divider(),
                  OptionButton(
                    onTap: () => context.go(AppRoutes.servicesType),
                    text: AppLocalizations.current.serviceTypes,
                  ),
                  const Divider(),
                  OptionButton(
                    onTap: onSignOut,
                    text: AppLocalizations.current.logout,
                    textStyle:
                        context.titleSmall!.copyWith(color: AppColors.red),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}