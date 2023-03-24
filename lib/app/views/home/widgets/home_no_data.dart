import 'package:flutter/material.dart';

import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/routes/app_routes.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/widgets/title_pill/title_pill.dart';

class HomeNoData extends StatelessWidget {
  const HomeNoData({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitlePill(
          title: AppLocalizations.current.services,
          button: AppLocalizations.current.newService,
          onTap: () => Navigator.pushNamed(context, AppRoutes.addServices),
        ),
        SizedBox(height: context.height * 0.12),
        Image.asset(AppAssets.noData),
        Text(
          AppLocalizations.current.noServices,
          style: context.noData,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
