import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_services/app/models/enums.dart';
import 'package:my_services/app/services/time_service/time_service.dart';
import 'package:my_services/app/shared/utils/service_helper.dart';

part 'service_filters_state.dart';

class ServiceFiltersCubit extends Cubit<ServiceFiltersState> {
  final TimeService _timeService;

  ServiceFiltersCubit({
    required TimeService timeService,
    required DateTime startDate,
    required DateTime endDate,
    required FastSearch fastSearch,
  })  : _timeService = timeService,
        super(ServiceFiltersState(
          startDate: startDate,
          endDate: endDate,
          fastSearch: fastSearch,
        ));

  void onChangeDate(DateTime startDate, DateTime endDate) {
    emit(ServiceFiltersState(
      startDate: startDate,
      endDate: endDate,
      fastSearch: FastSearch.custom,
      didFiltersChange: true,
    ));
  }

  void onChangeFastSearch(FastSearch fastSearch) {
    final range = ServiceHelper.getRangeDateByFastSearch(
        fastSearch, _timeService.nowWithoutTime);
    emit(ServiceFiltersState(
      startDate: range['startDate']!,
      endDate: range['endDate']!,
      fastSearch: fastSearch,
      didFiltersChange: true,
    ));
  }
}
