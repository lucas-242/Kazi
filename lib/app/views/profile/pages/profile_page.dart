import 'package:flutter/material.dart';
import 'package:my_services/app/models/app_user.dart';
import 'package:my_services/app/services/auth_service/auth_service.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/widgets/layout/layout.dart';
import 'package:my_services/app/shared/widgets/texts/row_text/row_text.dart';
import 'package:my_services/app/shared/widgets/texts/text_with_trailing/text_with_trailing.dart';
import 'package:my_services/injector_container.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppUser user = injector.get<AuthService>().user!;

    return CustomScaffold(
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
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
                  AppSizeConstants.mediumVerticalSpacer,
                  Text(user.name, style: context.titleMedium),
                  AppSizeConstants.largeVerticalSpacer,
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
                              padding: EdgeInsets.symmetric(vertical: 20.0),
                              child: Divider(),
                            ),
                          ],
                        )
                      : AppSizeConstants.emptyWidget,
                  RowText(
                    leftText: AppLocalizations.current.email,
                    rightText: user.email,
                    rightTextStyle: context.bodyLarge,
                  ),
                  AppSizeConstants.mediumVerticalSpacer,
                  const Divider(),
                  InkWell(
                    onTap: () => injector.get<AuthService>().signOut(),
                    child: Column(
                      children: [
                        AppSizeConstants.mediumVerticalSpacer,
                        TextWithTrailing(
                          text: AppLocalizations.current.logout,
                          textStyle: context.titleSmall!
                              .copyWith(color: AppColors.red),
                          trailing: const Icon(
                            Icons.chevron_right,
                            color: AppColors.grey,
                          ),
                        ),
                        AppSizeConstants.mediumVerticalSpacer,
                      ],
                    ),
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
