import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/utils/base_state.dart';
import 'package:my_services/app/shared/widgets/layout/layout.dart';
import 'package:my_services/app/views/services/services.dart';

import '../cubit/home_cubit.dart';
import '../widgets/home_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
              type: SnackBarType.error,
            );
          }
        },
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return state.when(
              onState: (_) => HomeContent(state: state),
              onLoading: () => SizedBox(
                height: context.height,
                child: const Center(child: CircularProgressIndicator()),
              ),
              onNoData: () => const NoServices(showFilters: false),
            );
          },
        ),
      ),
    );
  }
}
