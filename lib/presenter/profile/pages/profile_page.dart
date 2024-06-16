import 'package:flutter/material.dart';
import 'package:kazi/core/components/texts/row_text/row_text.dart';
import 'package:kazi/core/l10n/generated/l10n.dart';
import 'package:kazi/domain/services/auth_service.dart';
import 'package:kazi/presenter/profile/components/options.dart';
import 'package:kazi/service_locator.dart';
import 'package:kazi_core/kazi_core.dart';
import 'package:kazi_design_system/kazi_design_system.dart';
import 'package:kazi_design_system/themes/themes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final User user = ServiceLocator.get<AuthService>().user!;

    Future<void> onSignOut() async =>
        ServiceLocator.get<AuthService>().signOut();

    return KaziSafeArea(
      child: KaziSingleScrollView(
        children: [
          Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: KaziInsets.lg,
                    right: KaziInsets.lg,
                    top: KaziInsets.lg,
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
                          backgroundColor: KaziColors.white,
                          child: user.photoUrl == null
                              ? Text(
                                  '🦆',
                                  style:
                                      context.cardTitle!.copyWith(fontSize: 80),
                                )
                              : null,
                        ),
                      ),
                      KaziSpacings.verticalLg,
                      Text(user.name, style: context.titleMedium),
                      KaziSpacings.verticalXLg,
                      RowText(
                        leftText: AppLocalizations.current.email,
                        rightText: user.email,
                        rightTextStyle: context.bodyMedium,
                      ),
                      KaziSpacings.verticalLg,
                      const Divider(),
                    ],
                  ),
                ),
                Options(onSignOut: onSignOut),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
