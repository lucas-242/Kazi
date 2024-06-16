import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import 'package:kazi/core/constants/app_onboarding.dart';
import 'package:kazi/core/extensions/extensions.dart';
import 'package:kazi/core/l10n/generated/l10n.dart';
import 'package:kazi/core/routes/routes.dart';
import 'package:kazi/core/utils/base_state.dart';
import 'package:kazi/presenter/services/service_landing/widgets/service_landing_content.dart';
import 'package:kazi/presenter/services/service_landing/widgets/service_navbar.dart';
import 'package:kazi/presenter/services/services.dart';
import 'package:kazi_design_system/kazi_design_system.dart';
import 'package:kazi_design_system/themes/themes.dart';

class ServiceLandingPage extends StatefulWidget {
  const ServiceLandingPage({super.key, this.showOnboarding = false});

  final bool showOnboarding;

  @override
  State<ServiceLandingPage> createState() => _ServiceLandingPageState();
}

class _ServiceLandingPageState extends State<ServiceLandingPage> {
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
    return KaziSafeArea(
      padding: const EdgeInsets.only(top: KaziInsets.lg),
      onRefresh: () => context.read<ServiceLandingCubit>().onRefresh(),
      child: BlocListener<ServiceLandingCubit, ServiceLandingState>(
        listenWhen: (previous, current) =>
            current.callbackMessage.isNotEmpty ||
            previous.status != current.status,
        listener: (context, state) {
          if (state.status == BaseStateStatus.error) {
            context.showSnackBar(
              state.callbackMessage,
              type: SnackBarType.success,
            );
          } else if (state.status == BaseStateStatus.success &&
              state.callbackMessage.isNotEmpty) {
            context.showSnackBar(state.callbackMessage);
          }
        },
        child: widget.showOnboarding
            ? ServiceLandingContent(
                state: AppOnboarding.servicesState,
                dateController: dateController,
                showOnboarding: true,
              )
            : BlocBuilder<ServiceLandingCubit, ServiceLandingState>(
                builder: (context, state) {
                  return state.when(
                    onState: (_) => ServiceLandingContent(
                      state: state,
                      dateController: dateController,
                    ),
                    onLoading: () => const Padding(
                      padding: EdgeInsets.symmetric(horizontal: KaziInsets.lg),
                      child: KaziLoading(),
                    ),
                    onNoData: () => Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: KaziInsets.lg),
                      child: KaziNoData(
                        message: AppLocalizations.current.noServices,
                        navbar: ServiceNavbar(dateController: dateController),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
