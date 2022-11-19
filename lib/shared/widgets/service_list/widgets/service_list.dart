import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_services/shared/themes/themes.dart';
import 'package:my_services/views/home/cubit/home_cubit.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../models/service_provided.dart';
import '../../../../views/add_services/cubit/add_services_cubit.dart';
import '../../service_card/service_card.dart';
import '../cubit/service_list_cubit.dart';

class ServiceList extends StatefulWidget {
  final List<ServiceProvided> services;
  const ServiceList({super.key, required this.services});

  @override
  State<ServiceList> createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ServiceListCubit>();

    Future<void> onTapDelete(ServiceProvided service) async {
      final cubit = context.read<ServiceListCubit>();
      final newServiceList =
          await cubit.deleteService(service, widget.services);
      // ignore: use_build_context_synchronously
      context.read<HomeCubit>().changeServices(newServiceList);
    }

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.services.length,
          itemBuilder: (context, index) => ServiceCard(
            serviceType: widget.services[index],
            onTapEdit: (service) {
              context.read<AddServicesCubit>().changeServiceProvided(service);
              Navigator.pushNamed(context, AppRoutes.addServiceProvided);
            },
            onTapDelete: onTapDelete,
          ),
        ),
        const SizedBox(height: 25),
        Text(
            'Valor total: ${NumberFormat.currency(symbol: 'R\$').format(cubit.getTotalValue(widget.services))}',
            style: context.bodyMedium),
        const SizedBox(height: 15),
        Text(
            'Valor recebido: ${NumberFormat.currency(symbol: 'R\$').format(cubit.getTotalWithDiscount(widget.services))}',
            style: context.bodyMedium),
        const SizedBox(height: 15),
        Text(
            'Valor descontado: ${NumberFormat.currency(symbol: 'R\$').format(cubit.getTotalDiscounted(widget.services))}',
            style: context.bodyMedium)
      ],
    );
  }
}
