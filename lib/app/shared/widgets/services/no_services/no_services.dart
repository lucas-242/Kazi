import 'package:flutter/material.dart';

import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/widgets/services/services.dart';

class NoServices extends StatelessWidget {
  const NoServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleWithButtons(),
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
