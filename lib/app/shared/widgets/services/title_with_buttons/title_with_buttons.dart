import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_services/app/app_cubit.dart';

import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/routes/app_routes.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/widgets/buttons/buttons.dart';
import 'package:my_services/app/shared/widgets/texts/text_with_trailing/text_with_trailing.dart';

class TitleWithButtons extends StatelessWidget {
  const TitleWithButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppSizeConstants.smallSpace),
      child: TextWithTrailing(
        text: AppLocalizations.current.services,
        trailing: Row(
          children: [
            CircularButton(
              onTap: () => null,
              child: const Icon(
                Icons.swap_vert,
                size: 18,
              ),
            ),
            AppSizeConstants.smallHorizontalSpacer,
            CircularButton(
              onTap: () => null,
              child: const Icon(
                Icons.filter_list_alt,
                size: 18,
              ),
            ),
            AppSizeConstants.smallHorizontalSpacer,
            PillButton(
              onTap: () {
                context.read<AppCubit>().changeToAddServicePage();
                context.go(AppRoutes.addServices);
              },
              child: Text(AppLocalizations.current.newService),
            )
          ],
        ),
      ),
    );
  }
}
