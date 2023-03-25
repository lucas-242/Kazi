import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_services/app/app_cubit.dart';

import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/routes/app_routes.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/widgets/buttons/pills/title_and_pill.dart';

class HomeNoData extends StatelessWidget {
  const HomeNoData({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleAndPill(
          title: AppLocalizations.current.services,
          pillText: AppLocalizations.current.newService,
          onTap: () {
            context.read<AppCubit>().changeToAddServicePage();

            context.go(AppRoutes.addServices);
          },
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
