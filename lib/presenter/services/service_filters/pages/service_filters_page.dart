import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kazi/presenter/services/service_filters/cubit/service_filters_cubit.dart';
import 'package:kazi/presenter/services/service_landing/widgets/selectable_pill_button.dart';
import 'package:kazi/presenter/services/services.dart';
import 'package:kazi/core/components/texts/texts.dart';
import 'package:kazi/core/constants/app_keys.dart';
import 'package:kazi/core/extensions/extensions.dart';
import 'package:kazi/core/l10n/generated/l10n.dart';
import 'package:kazi/core/routes/routes.dart';
import 'package:kazi/domain/services/services_service.dart';
import 'package:kazi/service_locator.dart';
import 'package:kazi_core/kazi_core.dart';
import 'package:kazi_design_system/kazi_design_system.dart';
import 'package:kazi_design_system/themes/themes.dart';

class FiltersBottomSheet extends StatefulWidget {
  const FiltersBottomSheet({
    super.key,
    required this.dateController,
  });
  final TextEditingController dateController;

  @override
  State<FiltersBottomSheet> createState() => _FiltersBottomSheetState();
}

class _FiltersBottomSheetState extends State<FiltersBottomSheet> {
  late DateTime initialStartDate;
  late DateTime initialEndDate;
  late FastSearch initialFastSearch;

  @override
  void initState() {
    final cubit = context.read<ServiceLandingCubit>();
    initialStartDate = cubit.state.startDate;
    initialEndDate = cubit.state.endDate;
    initialFastSearch = cubit.state.fastSearch;
    widget.dateController.text =
        '${DateFormat.yMd().format(initialStartDate).normalizeDate()} - ${DateFormat.yMd().format(initialEndDate).normalizeDate()}';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final serviceLandingcubit = context.read<ServiceLandingCubit>();

    void updateDateController(BuildContext context) {
      final state = context.read<ServiceFiltersCubit>().state;
      widget.dateController.text =
          '${DateFormat.yMd().format(state.startDate).normalizeDate()} - ${DateFormat.yMd().format(state.endDate).normalizeDate()}';
    }

    void onChangeDate(BuildContext context, DateTimeRange range) {
      final cubit = context.read<ServiceFiltersCubit>();
      cubit.onChangeDate(range.start, range.end);
      updateDateController(context);
    }

    void onChangeFastSearch(
      BuildContext context,
      FastSearch selectedFastSearch,
    ) {
      final cubit = context.read<ServiceFiltersCubit>();
      cubit.onChangeFastSearch(selectedFastSearch);
      updateDateController(context);
    }

    Future<void> onApplyFilters(BuildContext context) async {
      final state = context.read<ServiceFiltersCubit>().state;
      context.closeModal();
      await serviceLandingcubit.onApplyFilters(
        state.fastSearch,
        state.startDate,
        state.endDate,
      );
    }

    Future<void> onCleanFilters() async {
      context.closeModal();
      await serviceLandingcubit.onCleanFilters();
    }

    return BlocProvider<ServiceFiltersCubit>(
      create: (context) => ServiceFiltersCubit(
        startDate: initialStartDate,
        endDate: initialEndDate,
        fastSearch: initialFastSearch,
        servicesService: ServiceLocator.get<ServicesService>(),
      ),
      child: Builder(
        builder: (context) {
          return Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: KaziInsets.xLg,
                  left: KaziInsets.xLg,
                  right: KaziInsets.xLg,
                  bottom: KaziInsets.xxxLg,
                ),
                child: Column(
                  children: [
                    TextWithTrailing(
                      text: AppLocalizations.current.filters,
                      trailing: KaziPillButton(
                        onTap: onCleanFilters,
                        backgroundColor: context.colorsScheme.primary,
                        child: Text(AppLocalizations.current.removeFilters),
                      ),
                    ),
                    KaziSpacings.verticalXLg,
                    KaziDateRangePicker(
                      label: AppLocalizations.current.period,
                      controller: widget.dateController,
                      startRange: initialStartDate,
                      endRange: initialEndDate,
                      firstDate: AppKeys.formStartDate,
                      lastDate: AppKeys.formEndDate,
                      onChange: (range) => onChangeDate(context, range),
                    ),
                    KaziSpacings.verticalXLg,
                    BlocBuilder<ServiceFiltersCubit, ServiceFiltersState>(
                      builder: (context, state) {
                        final cubit = context.read<ServiceFiltersCubit>();
                        return SizedBox(
                          width: double.infinity,
                          child: Wrap(
                            spacing: KaziInsets.md,
                            children: [
                              SelectablePillButton(
                                onTap: () => onChangeFastSearch(
                                    context, FastSearch.today),
                                text: AppLocalizations.current.today,
                                isSelected:
                                    cubit.state.fastSearch == FastSearch.today,
                              ),
                              SelectablePillButton(
                                onTap: () => onChangeFastSearch(
                                    context, FastSearch.week),
                                text: AppLocalizations.current.week,
                                isSelected:
                                    cubit.state.fastSearch == FastSearch.week,
                              ),
                              SelectablePillButton(
                                onTap: () => onChangeFastSearch(
                                    context, FastSearch.fortnight),
                                text: AppLocalizations.current.fortnight,
                                isSelected: cubit.state.fastSearch ==
                                    FastSearch.fortnight,
                              ),
                              SelectablePillButton(
                                onTap: () => onChangeFastSearch(
                                    context, FastSearch.month),
                                text: AppLocalizations.current.month,
                                isSelected:
                                    cubit.state.fastSearch == FastSearch.month,
                              ),
                              SelectablePillButton(
                                onTap: () => onChangeFastSearch(
                                    context, FastSearch.lastMonth),
                                text: AppLocalizations.current.lastMonth,
                                isSelected: cubit.state.fastSearch ==
                                    FastSearch.lastMonth,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    KaziSpacings.verticalXxxLg,
                    KaziPillButton(
                      onTap: () => onApplyFilters(context),
                      child: Text(AppLocalizations.current.applyFilters),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
