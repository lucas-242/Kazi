import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kazi/app/models/enums.dart';
import 'package:kazi/app/services/services_service/services_service.dart';
import 'package:kazi/app/shared/extensions/extensions.dart';
import 'package:kazi/app/shared/l10n/generated/l10n.dart';
import 'package:kazi/app/shared/themes/themes.dart';
import 'package:kazi/app/shared/widgets/buttons/buttons.dart';
import 'package:kazi/app/shared/widgets/fields/fields.dart';
import 'package:kazi/app/shared/widgets/texts/texts.dart';
import 'package:kazi/app/views/services/service_filters/cubit/service_filters_cubit.dart';
import 'package:kazi/app/views/services/service_landing/widgets/selectable_pill_button.dart';
import 'package:kazi/app/views/services/services.dart';
import 'package:kazi/injector_container.dart';

class FiltersBottomSheet extends StatefulWidget {
  const FiltersBottomSheet({
    super.key,
    required this.dateKey,
    required this.dateController,
  });
  final GlobalKey<FormFieldState> dateKey;
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
      context.back();
      await serviceLandingcubit.onApplyFilters(
        state.fastSearch,
        state.startDate,
        state.endDate,
      );
    }

    Future<void> onCleanFilters() async {
      context.back();
      await serviceLandingcubit.onCleanFilters();
    }

    return BlocProvider<ServiceFiltersCubit>(
      create: (context) => ServiceFiltersCubit(
        startDate: initialStartDate,
        endDate: initialEndDate,
        fastSearch: initialFastSearch,
        servicesService: serviceLocator.get<ServicesService>(),
      ),
      child: Builder(
        builder: (context) {
          return Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: AppSizeConstants.bigSpace,
                  left: AppSizeConstants.bigSpace,
                  right: AppSizeConstants.bigSpace,
                  bottom: AppSizeConstants.imenseSpace,
                ),
                child: Column(
                  children: [
                    TextWithTrailing(
                      text: AppLocalizations.current.filters,
                      trailing: PillButton(
                        onTap: onCleanFilters,
                        backgroundColor: context.colorsScheme.primary,
                        child: Text(AppLocalizations.current.removeFilters),
                      ),
                    ),
                    AppSizeConstants.bigVerticalSpacer,
                    CustomDateRangePicker(
                      fieldKey: widget.dateKey,
                      controller: widget.dateController,
                      startDate: initialStartDate,
                      endDate: initialEndDate,
                      onChange: (range) => onChangeDate(context, range),
                    ),
                    AppSizeConstants.bigVerticalSpacer,
                    BlocBuilder<ServiceFiltersCubit, ServiceFiltersState>(
                      builder: (context, state) {
                        final cubit = context.read<ServiceFiltersCubit>();
                        return SizedBox(
                          width: double.infinity,
                          child: Wrap(
                            spacing: AppSizeConstants.mediumSpace,
                            children: [
                              SelectablePillButton(
                                onTap: () => onChangeFastSearch(
                                    context, FastSearch.today,),
                                text: AppLocalizations.current.today,
                                isSelected:
                                    cubit.state.fastSearch == FastSearch.today,
                              ),
                              SelectablePillButton(
                                onTap: () => onChangeFastSearch(
                                    context, FastSearch.week,),
                                text: AppLocalizations.current.week,
                                isSelected:
                                    cubit.state.fastSearch == FastSearch.week,
                              ),
                              SelectablePillButton(
                                onTap: () => onChangeFastSearch(
                                    context, FastSearch.fortnight,),
                                text: AppLocalizations.current.fortnight,
                                isSelected: cubit.state.fastSearch ==
                                    FastSearch.fortnight,
                              ),
                              SelectablePillButton(
                                onTap: () => onChangeFastSearch(
                                    context, FastSearch.month,),
                                text: AppLocalizations.current.month,
                                isSelected:
                                    cubit.state.fastSearch == FastSearch.month,
                              ),
                              SelectablePillButton(
                                onTap: () => onChangeFastSearch(
                                    context, FastSearch.lastMonth,),
                                text: AppLocalizations.current.lastMonth,
                                isSelected: cubit.state.fastSearch ==
                                    FastSearch.lastMonth,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    AppSizeConstants.imenseVerticalSpacer,
                    PillButton(
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
