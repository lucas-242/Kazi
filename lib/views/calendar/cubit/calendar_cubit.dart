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
    if (state.services.isEmpty) {
      final result = await _fetchServices();
      _handleFetchServices(result);
    }
  }

  Future<List<ServiceProvided>> _fetchServices() async {
    try {
      final endDate = DateTime(
        state.selectedDate.year,
        state.selectedDate.month + 1,
        0,
      );
      final result = await _serviceProvidedRepository.get(
        _authService.user!.uid,
        state.selectedDate,
        endDate,
      );
      return result;
    } on AppError catch (exception) {
      onAppError(exception);
      rethrow;
    } catch (exception) {
      unexpectedError();
      rethrow;
    }
  }

  Future<void> onRefresh() async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      final result = await _fetchServices();
      _handleFetchServices(result);
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError();
    }
  }

  void _handleFetchServices(List<ServiceProvided> fetchResult) {
    final newStatus =
        fetchResult.isEmpty ? BaseStateStatus.noData : BaseStateStatus.success;

    final servicesWithTypes = ServiceHelper.addServiceTypeToServices(
        fetchResult, _cacheService.serviceTypes);

    final mergedServices = _cacheService.services =
        ServiceHelper.mergeServices(_cacheService.services, servicesWithTypes);

    emit(state.copyWith(status: newStatus, services: mergedServices));
  }

  Future<List<ServiceProvided>> deleteService(ServiceProvided service) async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      await _serviceProvidedRepository.delete(service.id);
      final newList = _removeDeletedService(service);
      _cacheService.services = newList;

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

  Future<void> onChangeSelectedDate(DateTime? dateTime) async {
    if (dateTime == null) return;
    dateTime = DateTime(dateTime.year, dateTime.month);

    emit(state.copyWith(selectedDate: dateTime));
    final cachedServices = _cacheService.getServicesByMonth(dateTime);

    if (cachedServices.isEmpty) {
      emit(state.copyWith(status: BaseStateStatus.loading));
      final fetchResult = await _fetchServices();
      _handleFetchServices(fetchResult);
    } else {
      emit(state.copyWith(services: cachedServices));
    }
  }

  void changeServices(List<ServiceProvided> services) {
    emit(state.copyWith(
      services: ServiceHelper.addServiceTypeToServices(
          services, _cacheService.serviceTypes),
    ));
  }
}
