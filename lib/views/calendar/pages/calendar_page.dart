import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_services/models/enums.dart';
import 'package:my_services/models/service.dart';
import 'package:my_services/shared/themes/themes.dart';
import 'package:my_services/shared/widgets/service_list/service_list.dart';

import '../../../shared/routes/app_routes.dart';
import '../../../shared/utils/base_state.dart';
import '../../../shared/widgets/custom_date_range_picker/custom_date_range_picker.dart';
import '../../../shared/widgets/custom_elevated_button/custom_elevated_button.dart';
import '../../../shared/widgets/custom_snack_bar/custom_snack_bar.dart';
import '../../../shared/widgets/order_by_bottom_sheet/order_by_bottom_sheet.dart';
import '../../../shared/widgets/selectable_tag/selectable_tag.dart';
import '../../add_services/cubit/add_services_cubit.dart';
import '../../home/home.dart';
import '../cubit/calendar_cubit.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final dateKey = GlobalKey<FormFieldState>();
  final dateController = MaskedTextController(
      text: 'dd/MM/yyyy - dd/MM/yyyy', mask: '00/00/0000 - 00/00/0000');

  @override
  void initState() {
    final cubit = context.read<CalendarCubit>();
    dateController.text =
        '${DateFormat.yMd().format(cubit.state.startDate)} - ${DateFormat.yMd().format(cubit.state.endDate)}';
    cubit.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendário', style: context.titleLarge),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () => context.read<CalendarCubit>().signOut(),
            icon: const Icon(Icons.logout),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, AppRoutes.addServices),
            icon: const Icon(Icons.add),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => context.read<CalendarCubit>().onRefresh(),
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
                builder: (context, state) {
                  return state.when(
                    onState: (_) => _Build(
                      state: state,
                      dateController: dateController,
                      dateKey: dateKey,
                    ),
                    onLoading: () => SizedBox(
                      height: context.height,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    onNoData: () => _NoData(
                      dateController: dateController,
                      dateKey: dateKey,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Build extends StatelessWidget {
  final CalendarState state;
  final GlobalKey<FormFieldState> dateKey;
  final MaskedTextController dateController;

  const _Build(
      {required this.dateKey,
      required this.dateController,
      required this.state});

  @override
  Widget build(BuildContext context) {
    void onDelete(Service service) async {
      final homeCubit = context.read<HomeCubit>();
      await context.read<CalendarCubit>().deleteService(service);
      homeCubit.onChangeServices();
    }

    void onEdit(Service service) async {
      context.read<AddServicesCubit>().onChangeService(service);
      Navigator.pushNamed(context, AppRoutes.addServices);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TopSearch(dateKey: dateKey, dateController: dateController),
        ServiceList(
          title:
              '${DateFormat.yMd().format(state.startDate)} - ${DateFormat.yMd().format(state.endDate)}',
          services: state.services,
          totalValue: state.totalValue,
          totalWithDiscount: state.totalWithDiscount,
          totalDiscounted: state.totalDiscounted,
          onTapEdit: onEdit,
          onTapDelete: onDelete,
          showDate: state.selectedFastSearch != FastSearch.today,
        ),
      ],
    );
  }
}

class _NoData extends StatelessWidget {
  final GlobalKey<FormFieldState> dateKey;
  final MaskedTextController dateController;

  const _NoData({required this.dateKey, required this.dateController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TopSearch(dateKey: dateKey, dateController: dateController),
        Text(
          'Não há serviços prestados no período selecionado.',
          style: context.titleMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 25),
        CustomElevatedButton(
          onTap: () => Navigator.pushNamed(context, AppRoutes.addServices),
          text: 'Adicionar novo serviço',
        ),
      ],
    );
  }
}

class _TopSearch extends StatelessWidget {
  final GlobalKey<FormFieldState> dateKey;
  final MaskedTextController dateController;
  const _TopSearch({
    Key? key,
    required this.dateKey,
    required this.dateController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CalendarCubit>();

    Future<void> onChangeFastSearch(FastSearch fastSearch) async {
      await cubit.onChageSelectedFastSearch(fastSearch);
      dateController.text =
          '${DateFormat.yMd().format(cubit.state.startDate)} - ${DateFormat.yMd().format(cubit.state.endDate)}';
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
                      '${DateFormat.yMd().format(range.start)} - ${DateFormat.yMd().format(range.end)}';
                },
              ),
            ),
            IconButton(
              onPressed: () => showModalBottomSheet(
                context: context,
                builder: (context) => OrderByBottomSheet(
                  onPressed: (orderBy) {
                    Navigator.of(context).pop();
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
              text: 'Hoje',
              isSelected: cubit.state.selectedFastSearch == FastSearch.today,
            ),
            SelectableTag(
              onTap: () => onChangeFastSearch(FastSearch.week),
              text: 'Semana',
              isSelected: cubit.state.selectedFastSearch == FastSearch.week,
            ),
            SelectableTag(
              onTap: () => onChangeFastSearch(FastSearch.fortnight),
              text: 'Quinzena',
              isSelected:
                  cubit.state.selectedFastSearch == FastSearch.fortnight,
            ),
            SelectableTag(
              onTap: () => onChangeFastSearch(FastSearch.month),
              text: 'Mês',
              isSelected: cubit.state.selectedFastSearch == FastSearch.month,
            ),
          ],
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}
