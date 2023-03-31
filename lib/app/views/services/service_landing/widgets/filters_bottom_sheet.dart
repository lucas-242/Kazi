import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
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

class FiltersBottomSheet extends StatelessWidget {
  final GlobalKey<FormFieldState> dateKey;
  final MaskedTextController dateController;
  const FiltersBottomSheet({
    Key? key,
    required this.dateKey,
    required this.dateController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ServiceLandingCubit>();

    Future<void> onChangeFastSearch(FastSearch fastSearch) async {
      await cubit.onChageSelectedFastSearch(fastSearch);
      dateController.text =
          '${DateFormat.yMd().format(cubit.state.startDate).normalizeDate()} - ${DateFormat.yMd().format(cubit.state.endDate).normalizeDate()}';
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
                  onTap: () => null,
                  backgroundColor: context.colorsScheme.primary,
                  child: Text(AppLocalizations.current.removeFilters),
                ),
              ),
              AppSizeConstants.largeVerticalSpacer,
              CustomDateRangePicker(
                fieldKey: dateKey,
                controller: dateController,
                startDate: cubit.state.startDate,
                endDate: cubit.state.endDate,
                onChange: (range) {
                  cubit.onChangeDate(range.start, range.end);
                  dateController.text =
                      '${DateFormat.yMd().format(range.start).normalizeDate()} - ${DateFormat.yMd().format(range.end).normalizeDate()}';
                },
              ),
              AppSizeConstants.largeVerticalSpacer,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SelectablePillButton(
                    onTap: () => onChangeFastSearch(FastSearch.today),
                    text: AppLocalizations.current.today,
                    isSelected:
                        cubit.state.selectedFastSearch == FastSearch.today,
                  ),
                  SelectablePillButton(
                    onTap: () => onChangeFastSearch(FastSearch.week),
                    text: AppLocalizations.current.week,
                    isSelected:
                        cubit.state.selectedFastSearch == FastSearch.week,
                  ),
                  SelectablePillButton(
                    onTap: () => onChangeFastSearch(FastSearch.fortnight),
                    text: AppLocalizations.current.fortnight,
                    isSelected:
                        cubit.state.selectedFastSearch == FastSearch.fortnight,
                  ),
                  SelectablePillButton(
                    onTap: () => onChangeFastSearch(FastSearch.month),
                    text: AppLocalizations.current.month,
                    isSelected:
                        cubit.state.selectedFastSearch == FastSearch.month,
                  ),
                ],
              ),
              AppSizeConstants.imenseVerticalSpacer,
              PillButton(
                onTap: () => null,
                child: Text(AppLocalizations.current.applyFilters),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
