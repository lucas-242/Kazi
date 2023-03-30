import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_services/app/shared/extensions/extensions.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/models/enums.dart';
import 'package:my_services/app/shared/widgets/fields/fields.dart';

import 'package:my_services/app/shared/widgets/services/order_by_bottom_sheet/order_by_bottom_sheet.dart';
import 'package:my_services/app/shared/widgets/buttons/selectable_tag/selectable_tag.dart';
import 'package:my_services/app/views/services/services.dart';

class TopSearch extends StatelessWidget {
  final GlobalKey<FormFieldState> dateKey;
  final MaskedTextController dateController;
  const TopSearch({
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

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CustomDateRangePicker(
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
            ),
            IconButton(
              onPressed: () => showModalBottomSheet(
                context: context,
                builder: (context) => OrderByBottomSheet(
                  onPressed: (orderBy) {
                    context.pop();
                    cubit.onChangeOrderBy(orderBy);
                  },
                ),
              ),
              icon: const Icon(Icons.filter_list),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SelectableTag(
              onTap: () => onChangeFastSearch(FastSearch.today),
              text: AppLocalizations.current.today,
              isSelected: cubit.state.selectedFastSearch == FastSearch.today,
            ),
            SelectableTag(
              onTap: () => onChangeFastSearch(FastSearch.week),
              text: AppLocalizations.current.week,
              isSelected: cubit.state.selectedFastSearch == FastSearch.week,
            ),
            SelectableTag(
              onTap: () => onChangeFastSearch(FastSearch.fortnight),
              text: AppLocalizations.current.fortnight,
              isSelected:
                  cubit.state.selectedFastSearch == FastSearch.fortnight,
            ),
            SelectableTag(
              onTap: () => onChangeFastSearch(FastSearch.month),
              text: AppLocalizations.current.month,
              isSelected: cubit.state.selectedFastSearch == FastSearch.month,
            ),
          ],
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}
