import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_services/shared/themes/themes.dart';
import 'package:my_services/shared/widgets/service_list/service_list.dart';

import '../../../core/routes/app_routes.dart';
import '../../../shared/models/base_state.dart';
import '../../../shared/widgets/custom_app_bar/custom_app_bar_widget.dart';
import '../../../shared/widgets/custom_elevated_button/custom_elevated_button.dart';
import '../../../shared/widgets/custom_snack_bar/custom_snack_bar.dart';
import '../../add_services/cubit/add_services_cubit.dart';
import '../cubit/calendar_cubit.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  void initState() {
    final cubit = context.read<CalendarCubit>();
    cubit.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: RefreshIndicator not working
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Calendário',
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
          onRefresh: () => context.read<CalendarCubit>().getServices(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
              child: BlocListener<CalendarCubit, CalendarState>(
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
                child: BlocBuilder<CalendarCubit, CalendarState>(
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
    return BlocBuilder<CalendarCubit, CalendarState>(builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat.MMMMd().format(DateTime.now()),
                style: context.titleMedium,
              ),
              Text(
                '${state.services.length.toString()} Serviços',
                style: context.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 25),
          ServiceList(
            services: state.services,
            totalValue: state.totalValue,
            totalWithDiscount: state.totalWithDiscount,
            totalDiscounted: state.totalDiscounted,
            onTapEdit: (service) {
              context.read<AddServicesCubit>().changeServiceProvided(service);
              Navigator.pushNamed(context, AppRoutes.addServiceProvided);
            },
            onTapDelete: (service) =>
                context.read<CalendarCubit>().deleteService(service),
          ),
        ],
      );
    });
  }
}

class _NoData extends StatelessWidget {
  const _NoData();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Não há serviços prestados no dia ${DateFormat.MMMMd().format(DateTime.now())} ',
          style: context.titleMedium,
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
