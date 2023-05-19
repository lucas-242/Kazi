import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/app/shared/constants/app_onboarding.dart';
import 'package:kazi/app/shared/l10n/generated/l10n.dart';
import 'package:kazi/app/shared/utils/base_state.dart';
import 'package:kazi/app/shared/widgets/layout/layout.dart';

import '../cubit/home_cubit.dart';
import '../widgets/home_content.dart';

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
    return CustomScaffold(
      onRefresh: () => context.read<HomeCubit>().onRefresh(),
      child: BlocListener<HomeCubit, HomeState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == BaseStateStatus.error) {
            getCustomSnackBar(
              context,
              message: state.callbackMessage,
            );
          }
        },
        child: widget.showOnboarding
            ? HomeContent(state: AppOnboarding.homeState)
            : BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return state.when(
                    onState: (_) => HomeContent(state: state),
                    onLoading: () => const Loading(),
                    onNoData: () =>
                        NoData(message: AppLocalizations.current.noServices),
                  );
                },
              ),
      ),
    );
  }
}
