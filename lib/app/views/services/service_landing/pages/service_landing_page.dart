import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import 'package:kazi/app/shared/constants/app_onboarding.dart';
import 'package:kazi/app/shared/extensions/extensions.dart';
import 'package:kazi/app/shared/l10n/generated/l10n.dart';
import 'package:kazi/app/shared/themes/themes.dart';
import 'package:kazi/app/shared/utils/base_state.dart';
import 'package:kazi/app/shared/widgets/layout/layout.dart';
import 'package:kazi/app/views/services/service_landing/widgets/service_landing_content.dart';
import 'package:kazi/app/views/services/service_landing/widgets/service_navbar.dart';
import 'package:kazi/app/views/services/services.dart';

class ServiceLandingPage extends StatefulWidget {
  const ServiceLandingPage({super.key, this.showOnboarding = false});

  final bool showOnboarding;

  @override
  State<ServiceLandingPage> createState() => _ServiceLandingPageState();
}

class _ServiceLandingPageState extends State<ServiceLandingPage> {
  final dateKey = GlobalKey<FormFieldState>();
  final dateController = MaskedTextController(
      text: 'dd/MM/yyyy - dd/MM/yyyy', mask: '00/00/0000 - 00/00/0000',);

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
    return CustomSafeArea(
      padding: const EdgeInsets.only(top: AppSizeConstants.largeSpace),
      onRefresh: () => context.read<ServiceLandingCubit>().onRefresh(),
      child: BlocListener<ServiceLandingCubit, ServiceLandingState>(
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
            ? ServiceLandingContent(
                state: AppOnboarding.servicesState,
                dateController: dateController,
                dateKey: dateKey,
              )
            : BlocBuilder<ServiceLandingCubit, ServiceLandingState>(
                builder: (context, state) {
                  return state.when(
                    onState: (_) => ServiceLandingContent(
                      state: state,
                      dateController: dateController,
                      dateKey: dateKey,
                    ),
                    onLoading: () => const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppSizeConstants.largeSpace,),
                      child: Loading(),
                    ),
                    onNoData: () => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSizeConstants.largeSpace,),
                      child: NoData(
                        message: AppLocalizations.current.noServices,
                        navbar: ServiceNavbar(
                          dateKey: dateKey,
                          dateController: dateController,
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
