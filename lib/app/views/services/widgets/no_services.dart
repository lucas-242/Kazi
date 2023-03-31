import 'package:flutter/material.dart';

import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/views/services/services.dart';

class NoServices extends StatelessWidget {
  final bool showFilters;
  final Widget? filtersBottomSheet;

  const NoServices(
      {super.key, this.showFilters = true, this.filtersBottomSheet});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleWithButtons(
          showFilters: showFilters,
          filtersBottomSheet: filtersBottomSheet,
        ),
        SizedBox(height: context.height * 0.12),
        Image.asset(AppAssets.noData),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSizeConstants.mediumSpace),
          child: Text(
            AppLocalizations.current.noServices,
            style: context.noData,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
