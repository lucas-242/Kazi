import 'package:flutter/material.dart';
import 'package:my_services/app/models/app_user.dart';
import 'package:my_services/app/services/auth_service/auth_service.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/themes/extensions/typography_extension.dart';
import 'package:my_services/app/shared/themes/settings/app_colors.dart';
import 'package:my_services/app/shared/widgets/texts/row_text.dart';
import 'package:my_services/app/shared/widgets/texts/text_icon.dart';
import 'package:my_services/injector_container.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppUser user = injector.get<AuthService>().user!;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    user.photoUrl != null
                        ? SizedBox(
                            width: 120.0,
                            height: 120.0,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(user.photoUrl!),
                              backgroundColor: AppColors.white,
                            ),
                          )
                        : const Text('🦆'),
                    const SizedBox(height: 20),
                    Text(user.name, style: context.titleMedium),
                    const SizedBox(height: 40),
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
                        : const SizedBox.shrink(),
                    RowText(
                      leftText: AppLocalizations.current.email,
                      rightText: user.email,
                      rightTextStyle: context.bodyLarge,
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    InkWell(
                      onTap: () => injector.get<AuthService>().signOut(),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          TextIcon(
                            text: AppLocalizations.current.logout,
                            textStyle: context.titleSmall!
                                .copyWith(color: AppColors.red),
                            icon: Icons.chevron_right,
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
