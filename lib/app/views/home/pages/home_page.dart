import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_services/app/shared/widgets/custom_app_bar/custom_app_bar.dart';

import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import '../cubit/home_cubit.dart';

import 'package:my_services/app/shared/utils/base_state.dart';
import 'package:my_services/app/shared/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:my_services/app/shared/widgets/order_by_bottom_sheet/order_by_bottom_sheet.dart';
import '../widgets/home_content.dart';
import '../widgets/home_no_data.dart';

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
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.current.home,
        showOrderBy: true,
        onSelectedOrderBy: () => showModalBottomSheet(
          context: context,
          builder: (context) => OrderByBottomSheet(
            onPressed: (orderBy) {
              Navigator.of(context).pop();
              context.read<HomeCubit>().onChangeOrderBy(orderBy);
            },
          ),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => context.read<HomeCubit>().onRefresh(),
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
            child: BlocListener<HomeCubit, HomeState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status,
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
                    onNoData: () => const HomeNoData(),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
