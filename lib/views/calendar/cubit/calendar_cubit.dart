import 'package:bloc/bloc.dart';
import 'package:my_services/models/service_provided.dart';
import 'package:my_services/repositories/service_provided_repository/service_provided_repository.dart';
import 'package:my_services/services/auth_service/auth_service.dart';
import 'package:my_services/shared/helpers/service_helper.dart';
import 'package:my_services/shared/models/base_cubit.dart';
import 'package:my_services/shared/models/base_state.dart';

import '../../../core/errors/app_error.dart';
import '../../../services/cache_service/cache_service.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> with BaseCubit {
  final ServiceProvidedRepository _serviceProvidedRepository;
  final AuthService _authService;
  final CacheService _cacheService;

  CalendarCubit(
    this._serviceProvidedRepository,
    this._authService,
    this._cacheService,
  ) : super(CalendarState(status: BaseStateStatus.loading));

  void onInit() async {
    if (_cacheService.serviceProvidedList.isEmpty ||
        _cacheService.serviceTypeList.isEmpty) {
      final result = await _fetchServices();

      final newStatus =
          result.isEmpty ? BaseStateStatus.noData : BaseStateStatus.success;

      emit(state.copyWith(
        status: newStatus,
        services: ServiceHelper.addServiceTypeToServices(
            result, _cacheService.serviceTypeList),
      ));
    }
  }

  Future<List<ServiceProvided>> _fetchServices() async {
    try {
      final result = await _serviceProvidedRepository.get(
        _authService.user!.uid,
        dateTime: state.selectedDate,
      );
      _cacheService.serviceProvidedList = result;
      return result;
    } on AppError catch (exception) {
      onAppError(exception);
      rethrow;
    } catch (exception) {
      unexpectedError();
      rethrow;
    }
  }

  Future<void> getServices() async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      final result = await _fetchServices();
      final newStatus =
          result.isEmpty ? BaseStateStatus.noData : BaseStateStatus.success;

      emit(state.copyWith(status: newStatus, services: result));
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError();
    }
  }

  Future<List<ServiceProvided>> deleteService(ServiceProvided service) async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      await _serviceProvidedRepository.delete(service.id);
      final newList = _removeDeletedService(service);
      _cacheService.serviceProvidedList = newList;

      emit(state.copyWith(status: BaseStateStatus.success, services: newList));
      return newList;
    } on AppError catch (exception) {
      onAppError(exception);
      rethrow;
    } catch (exception) {
      unexpectedError();
      rethrow;
    }
  }

  List<ServiceProvided> _removeDeletedService(ServiceProvided service) {
    final newList = state.services
      ..removeWhere((element) => element.id == service.id);

    return newList;
  }

  void changeServiceProvidedList(List<ServiceProvided> serviceProvidedList) {
    emit(state.copyWith(
      services: ServiceHelper.addServiceTypeToServices(
          serviceProvidedList, _cacheService.serviceTypeList),
    ));
  }
}
