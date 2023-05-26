import 'package:flutter/material.dart';
import 'package:kazi/app/data/local_storage/local_storage.dart';
import 'package:kazi/app/models/app_user.dart';
import 'package:kazi/app/services/auth_service/auth_service.dart';
import 'package:kazi/app/shared/constants/app_keys.dart';
import 'package:kazi/app/shared/l10n/generated/l10n.dart';
import 'package:kazi/app/shared/themes/themes.dart';
import 'package:kazi/app/shared/widgets/layout/layout.dart';
import 'package:kazi/app/shared/widgets/texts/row_text/row_text.dart';
import 'package:kazi/app/views/profile/widgets/options.dart';
import 'package:kazi/injector_container.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppUser user = serviceLocator.get<AuthService>().user!;

    Future<void> onSignOut() async {
      await serviceLocator.get<AuthService>().signOut();
      await serviceLocator
          .get<LocalStorage>()
          .remove(AppKeys.showOnboardingStorage);
    }

    return CustomScaffold(
      child: SingleChildScrollView(
        child: Card(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: AppSizeConstants.largeSpace,
                  right: AppSizeConstants.largeSpace,
                  top: AppSizeConstants.largeSpace,
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
                                style:
                                    context.cardTitle!.copyWith(fontSize: 80),
                              )
                            : null,
                      ),
                    ),
                    AppSizeConstants.largeVerticalSpacer,
                    Text(user.name, style: context.titleMedium),
                    AppSizeConstants.bigVerticalSpacer,
                    if (user.phoneNumber != null &&
                        user.phoneNumber!.isNotEmpty)
                      Column(
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
                      ),
                    RowText(
                      leftText: AppLocalizations.current.email,
                      rightText: user.email,
                      rightTextStyle: context.bodyMedium,
                    ),
                    AppSizeConstants.largeVerticalSpacer,
                    const Divider(),
                  ],
                ),
              ),
              Options(onSignOut: onSignOut),
            ],
          ),
        ),
      ),
    );
  }
}
