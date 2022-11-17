import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_services/shared/themes/themes.dart';
import 'package:my_services/views/home/cubit/home_cubit.dart';
import 'package:my_services/views/home/widgets/service_provided_card.dart';

import '../../../core/routes/app_routes.dart';
import '../../../shared/widgets/base_state/base_state.dart';
import '../../../shared/widgets/custom_app_bar/custom_app_bar_widget.dart';
import '../../../shared/widgets/custom_elevated_button/custom_elevated_button.dart';
import '../../../shared/widgets/custom_snack_bar/custom_snack_bar.dart';

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
    //TODO: RefreshIndicator not working
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Home',
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, AppRoutes.addServiceProvided),
            icon: const Icon(Icons.add),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => context.read<HomeCubit>().getServices(),
          child: SingleChildScrollView(
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
                  buildWhen: (previous, current) =>
                      previous.status != current.status,
                  builder: (context, state) {
                    return state.when(
                      onState: (_) => const _Build(),
                      onLoading: () => SizedBox(
                        height: context.height,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      onNoData: () => const _NoData(),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Build extends StatelessWidget {
  const _Build();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dia ${DateFormat.MMMMd().format(DateTime.now())}',
          style: context.titleMedium,
        ),
        const SizedBox(height: 25),
        BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.serviceProvidedList.length,
            itemBuilder: (context, index) => ServiceProvidedCard(
              serviceType: state.serviceProvidedList[index],
              onTapEdit: (service) {
                context.read<HomeCubit>().changeServiceProvided(service);
                Navigator.pushNamed(context, AppRoutes.addServiceProvided);
              },
              onTapDelete: (service) =>
                  context.read<HomeCubit>().deleteServiceProvided(service),
            ),
          );
        }),
        const SizedBox(height: 15),
      ],
    );
  }
}

class _NoData extends StatelessWidget {
  const _NoData();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Não há serviços prestados no mês atual',
          style: context.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 25),
        Text(
          'Você ainda não cadastrou nenhum serviço nesse mês',
          style: context.bodyLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 25),
        CustomElevatedButton(
          onTap: () =>
              Navigator.pushNamed(context, AppRoutes.addServiceProvided),
          text: 'Adicionar novo serviço',
        ),
      ],
    );
  }
}
