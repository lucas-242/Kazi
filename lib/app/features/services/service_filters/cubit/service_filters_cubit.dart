import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kazi/app/core/extensions/extensions.dart';
import 'package:kazi/app/models/enums/fast_search.dart';
import 'package:kazi/app/services/services_service/services_service.dart';

part 'service_filters_state.dart';

class ServiceFiltersCubit extends Cubit<ServiceFiltersState> {
  ServiceFiltersCubit({
    required ServicesService servicesService,
    required DateTime startDate,
    required DateTime endDate,
    required FastSearch fastSearch,
  })  : _servicesService = servicesService,
        super(ServiceFiltersState(
          startDate: startDate,
          endDate: endDate,
          fastSearch: fastSearch,
        ));
  final ServicesService _servicesService;

  void onChangeDate(DateTime startDate, DateTime endDate) {
    final finalEndDate = endDate.lastHourOfDay;
    emit(ServiceFiltersState(
      startDate: startDate,
      endDate: finalEndDate,
      fastSearch: FastSearch.custom,
      didFiltersChange: true,
    ));
  }

  void onChangeFastSearch(FastSearch fastSearch) {
    final dates = _servicesService.getRangeDateByFastSearch(fastSearch);
    emit(ServiceFiltersState(
      startDate: dates.$1,
      endDate: dates.$2,
      fastSearch: fastSearch,
      didFiltersChange: true,
    ));
  }
}
