import 'package:flutter/material.dart';
import 'package:kazi/app/core/auth/auth.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/widgets/layout/layout.dart';
import 'package:kazi/app/core/widgets/texts/row_text/row_text.dart';
import 'package:kazi/app/features/profile/widgets/options.dart';
import 'package:kazi/app/models/user.dart';
import 'package:kazi/injector_container.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final User user = serviceLocator.get<Auth>().user!;
    final User user = User.toCreate(name: 'jooj');

    Future<void> onSignOut() async => serviceLocator.get<Auth>().signOut();

    return CustomSafeArea(
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
