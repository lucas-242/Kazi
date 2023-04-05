import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_services/app/models/service.dart';
import 'package:my_services/app/models/service_type.dart';
import 'package:my_services/app/repositories/services_repository/services_repository.dart';
import 'package:my_services/app/repositories/service_type_repository/service_type_repository.dart';
import 'package:my_services/app/services/auth_service/auth_service.dart';
import 'package:my_services/app/services/time_service/time_service.dart';
import 'package:my_services/app/shared/utils/service_helper.dart';
import 'package:my_services/app/shared/utils/base_cubit.dart';
import 'package:my_services/app/shared/utils/base_state.dart';

import 'package:my_services/app/models/enums.dart';
import 'package:my_services/app/shared/errors/errors.dart';

part 'service_landing_state.dart';

class ServiceLandingCubit extends Cubit<ServiceLandingState> with BaseCubit {
  final ServicesRepository _serviceProvidedRepository;
  final ServiceTypeRepository _serviceTypeRepository;
  final AuthService _authService;
  final TimeService _timeService;

  DateTime get now => _timeService.nowWithoutTime;

  ServiceLandingCubit(
    this._serviceProvidedRepository,
    this._serviceTypeRepository,
    this._authService,
    this._timeService,
  ) : super(ServiceLandingState(
          status: BaseStateStatus.loading,
          startDate: _timeService.nowWithoutTime,
          endDate: _timeService.nowWithoutTime,
        ));

  Future<void> onInit() async {
    try {
      final range =
          ServiceHelper.getRangeDateByFastSearch(state.fastSearch, now);
      final result = await _getServices(range['startDate']!, range['endDate']!);
      _handleGetServices(result);
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  Future<List<Service>> _getServices(
      DateTime startDate, DateTime endDate) async {
    final result = await _serviceProvidedRepository.get(
        _authService.user!.uid, startDate, endDate);
    return result;
  }

  Future<void> _handleGetServices(List<Service> fetchResult) async {
    try {
      final types = await _getServiceTypes();
      var services = ServiceHelper.addServiceTypeToServices(fetchResult, types);
      services = ServiceHelper.orderServices(services, state.selectedOrderBy);

      final newStatus = fetchResult.isEmpty
          ? BaseStateStatus.noData
          : BaseStateStatus.success;
      emit(state.copyWith(status: newStatus, services: services));
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  Future<List<ServiceType>> _getServiceTypes() async {
    final result = await _serviceTypeRepository.get(_authService.user!.uid);
    return result;
  }

  Future<void> onRefresh() async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      final range =
          ServiceHelper.getRangeDateByFastSearch(state.fastSearch, now);
      final fetchResult =
          await _getServices(range['startDate']!, range['endDate']!);
      _handleGetServices(fetchResult);
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  Future<void> deleteService(Service service) async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      await _serviceProvidedRepository.delete(service.id);
      final newList = await _getServices(state.startDate, state.endDate);
      final newStatus =
          newList.isEmpty ? BaseStateStatus.noData : BaseStateStatus.success;

      emit(state.copyWith(status: newStatus, services: newList));
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  Future<void> onApplyFilters([
    FastSearch? fastSearch,
    DateTime? startDate,
    DateTime? endDate,
  ]) async {
    if (fastSearch != null && fastSearch != FastSearch.custom) {
      await _onChageSelectedFastSearch(fastSearch);
    } else if (startDate != null && endDate != null) {
      await _onChangeDate(startDate, endDate);
    }
  }

  Future<void> _onChageSelectedFastSearch(FastSearch fastSearch) async {
    try {
      if (fastSearch == state.fastSearch) return;

      final range = ServiceHelper.getRangeDateByFastSearch(fastSearch, now);

      emit(state.copyWith(
        status: BaseStateStatus.loading,
        fastSearch: fastSearch,
        startDate: range['startDate']!,
        endDate: range['endDate']!,
        didFiltersChange: true,
      ));
      final fetchResult =
          await _getServices(range['startDate']!, range['endDate']!);
      _handleGetServices(fetchResult);
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  Future<void> _onChangeDate(DateTime startDate, DateTime endDate) async {
    try {
      emit(state.copyWith(
        status: BaseStateStatus.loading,
        startDate: startDate,
        endDate: endDate,
        fastSearch: FastSearch.custom,
        didFiltersChange: true,
      ));
      final fetchResult = await _getServices(startDate, endDate);
      _handleGetServices(fetchResult);
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  Future<void> onCleanFilters() async {
    emit(ServiceLandingState(
      status: BaseStateStatus.loading,
      startDate: _timeService.nowWithoutTime,
      endDate: _timeService.nowWithoutTime,
    ));
    onInit();
  }

  void onChangeOrderBy(OrderBy orderBy) {
    final services = ServiceHelper.orderServices(state.services, orderBy);
    emit(state.copyWith(services: services, selectedOrderBy: orderBy));
  }

  Future<void> onChangeServices() async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      final result = await _getServices(state.startDate, state.endDate);
      _handleGetServices(result);
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }
}
