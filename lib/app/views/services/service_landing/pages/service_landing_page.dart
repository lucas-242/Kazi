import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_services/app/shared/extensions/extensions.dart';
import 'package:my_services/app/shared/themes/themes.dart';

import 'package:my_services/app/shared/utils/base_state.dart';
import 'package:my_services/app/shared/widgets/layout/layout.dart';
import 'package:my_services/app/views/services/service_landing/widgets/filters_bottom_sheet.dart';
import 'package:my_services/app/views/services/service_landing/widgets/service_landing_content.dart';
import 'package:my_services/app/views/services/services.dart';

class ServiceLandingPage extends StatefulWidget {
  const ServiceLandingPage({super.key});

  @override
  State<ServiceLandingPage> createState() => _ServiceLandingPageState();
}

class _ServiceLandingPageState extends State<ServiceLandingPage> {
  final dateKey = GlobalKey<FormFieldState>();
  final dateController = MaskedTextController(
      text: 'dd/MM/yyyy - dd/MM/yyyy', mask: '00/00/0000 - 00/00/0000');

  @override
  void initState() {
    final cubit = context.read<ServiceLandingCubit>();
    dateController.text =
        '${DateFormat.yMd().format(cubit.state.startDate).normalizeDate()} - ${DateFormat.yMd().format(cubit.state.endDate).normalizeDate()}';
    cubit.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      onRefresh: () => context.read<ServiceLandingCubit>().onRefresh(),
      child: BlocListener<ServiceLandingCubit, ServiceLandingState>(
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
        child: BlocBuilder<ServiceLandingCubit, ServiceLandingState>(
          builder: (context, state) {
            return state.when(
              onState: (_) => ServiceLandingContent(
                state: state,
                dateController: dateController,
                dateKey: dateKey,
              ),
              onLoading: () => SizedBox(
                height: context.height,
                child: const Center(child: CircularProgressIndicator()),
              ),
              onNoData: () => NoServices(
                filtersBottomSheet: FiltersBottomSheet(
                  dateKey: dateKey,
                  dateController: dateController,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
