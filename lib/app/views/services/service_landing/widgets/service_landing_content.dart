import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:go_router/go_router.dart';
import 'package:my_services/app/app_cubit.dart';
import 'package:my_services/app/models/service.dart';
import 'package:my_services/app/shared/routes/app_routes.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/views/home/home.dart';
import 'package:my_services/app/views/services/services.dart';
import 'package:my_services/app/views/services/service_landing/widgets/filters_bottom_sheet.dart';

class ServiceLandingContent extends StatelessWidget {
  final ServiceLandingState state;
  final GlobalKey<FormFieldState> dateKey;
  final MaskedTextController dateController;

  const ServiceLandingContent(
      {super.key,
      required this.dateKey,
      required this.dateController,
      required this.state});

  @override
  Widget build(BuildContext context) {
    Future<void> onDelete(Service service) async {
      final homeCubit = context.read<HomeCubit>();
      await context.read<ServiceLandingCubit>().deleteService(service);
      homeCubit.onChangeServices();
    }

    void onEdit(Service service) {
      context.read<AddServicesCubit>().onChangeService(service);
      context.read<AppCubit>().changeToAddServicePage();
      context.go(AppRoutes.addServices);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWithButtons(
          filtersBottomSheet: FiltersBottomSheet(
            dateKey: dateKey,
            dateController: dateController,
          ),
        ),
        AppSizeConstants.largeVerticalSpacer,
        ServiceList(services: state.services),
      ],
    );
  }
}
