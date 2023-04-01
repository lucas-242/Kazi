import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_services/app/shared/extensions/extensions.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/models/enums.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/widgets/buttons/buttons.dart';
import 'package:my_services/app/shared/widgets/fields/fields.dart';

import 'package:my_services/app/shared/widgets/texts/texts.dart';
import 'package:my_services/app/views/services/services.dart';

import 'selectable_pill_button.dart';

class FiltersBottomSheet extends StatefulWidget {
  final GlobalKey<FormFieldState> dateKey;
  final MaskedTextController dateController;
  const FiltersBottomSheet({
    Key? key,
    required this.dateKey,
    required this.dateController,
  }) : super(key: key);

  @override
  State<FiltersBottomSheet> createState() => _FiltersBottomSheetState();
}

class _FiltersBottomSheetState extends State<FiltersBottomSheet> {
  late DateTime startDate;
  late DateTime endDate;
  late FastSearch fastSearch;

  @override
  void initState() {
    final cubit = context.read<ServiceLandingCubit>();
    startDate = cubit.state.startDate;
    endDate = cubit.state.endDate;
    fastSearch = cubit.state.fastSearch;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ServiceLandingCubit>();

    void onChangeDate(DateTimeRange range) {
      startDate = range.start;
      endDate = range.end;
      widget.dateController.text =
          '${DateFormat.yMd().format(startDate).normalizeDate()} - ${DateFormat.yMd().format(endDate).normalizeDate()}';
    }

    void onChangeFastSearch(FastSearch selectedFastSearch) {
      setState(() {
        fastSearch = selectedFastSearch;
        final range = cubit.getRangeDateByFastSearch(fastSearch);
        onChangeDate(DateTimeRange(
          start: range['startDate']!,
          end: range['endDate']!,
        ));
      });
    }

    Future<void> onApplyFilters() async {
      context.pop();
      await cubit.onApplyFilters(fastSearch, startDate, endDate);
    }

    Future<void> onCleanFilters() async {
      context.pop();
      await cubit.onCleanFilters();
    }

    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: AppSizeConstants.largeSpace,
            left: AppSizeConstants.largeSpace,
            right: AppSizeConstants.largeSpace,
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
              AppSizeConstants.largeVerticalSpacer,
              CustomDateRangePicker(
                fieldKey: widget.dateKey,
                controller: widget.dateController,
                startDate: startDate,
                endDate: endDate,
                onChange: onChangeDate,
              ),
              AppSizeConstants.largeVerticalSpacer,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SelectablePillButton(
                    onTap: () => onChangeFastSearch(FastSearch.today),
                    text: AppLocalizations.current.today,
                    isSelected: fastSearch == FastSearch.today,
                  ),
                  SelectablePillButton(
                    onTap: () => onChangeFastSearch(FastSearch.week),
                    text: AppLocalizations.current.week,
                    isSelected: fastSearch == FastSearch.week,
                  ),
                  SelectablePillButton(
                    onTap: () => onChangeFastSearch(FastSearch.fortnight),
                    text: AppLocalizations.current.fortnight,
                    isSelected: fastSearch == FastSearch.fortnight,
                  ),
                  SelectablePillButton(
                    onTap: () => onChangeFastSearch(FastSearch.month),
                    text: AppLocalizations.current.month,
                    isSelected: fastSearch == FastSearch.month,
                  ),
                ],
              ),
              AppSizeConstants.imenseVerticalSpacer,
              PillButton(
                onTap: onApplyFilters,
                child: Text(AppLocalizations.current.applyFilters),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
