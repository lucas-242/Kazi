import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/app/core/constants/app_onboarding.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/routes/routes.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/utils/base_state.dart';
import 'package:kazi/app/core/widgets/buttons/buttons.dart';
import 'package:kazi/app/core/widgets/layout/layout.dart';
import 'package:kazi/app/features/home/home.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    this.showOnboarding = false,
  });
  final bool showOnboarding;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final cubit = context.read<HomeCubit>();
    cubit.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      onRefresh: () => context.read<HomeCubit>().onRefresh(),
      child: BlocListener<HomeCubit, HomeState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == BaseStateStatus.error) {
            context.showSnackBar(
              state.callbackMessage,
              type: SnackBarType.success,
            );
          }
        },
        child: widget.showOnboarding
            ? HomeContent(state: AppOnboarding.homeState, showOnboarding: true)
            : BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return state.when(
                    onState: (_) => HomeContent(state: state),
                    onLoading: () => const Loading(),
                    onNoData: () => NoData(
                      message: AppLocalizations.current.noServicesHome,
                      navbar: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          PillButton(
                            onTap: () => context.navigateToAddServices(),
                            child: Text(AppLocalizations.current.newService),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
