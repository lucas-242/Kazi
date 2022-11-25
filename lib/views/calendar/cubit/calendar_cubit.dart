import 'package:bloc/bloc.dart';
import 'package:my_services/models/service_provided.dart';
import 'package:my_services/repositories/service_provided_repository/service_provided_repository.dart';
import 'package:my_services/services/auth_service/auth_service.dart';
import 'package:my_services/shared/helpers/service_helper.dart';
import 'package:my_services/shared/models/base_cubit.dart';
import 'package:my_services/shared/models/base_state.dart';

import '../../../core/errors/app_error.dart';
import '../../../shared/extensions/extensions.dart';
import '../../../models/fast_search.dart';
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
      final range = _getRangeDateByFastSearch(state.selectedFastSearch);
      final fetchResult =
          await _fetchServices(range['startDate']!, range['endDate']!);
      _handleFetchServices(fetchResult);
    }
  }

  Future<List<ServiceProvided>> _fetchServices(
      DateTime startDate, DateTime endDate) async {
    try {
      // final endDate = DateTime(
      //   state.selectedDate.year,
      //   state.selectedDate.month + 1,
      //   0,
      // );
      final result = await _serviceProvidedRepository.get(
        _authService.user!.uid,
        // state.selectedDate,
        // endDate,
        startDate,
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
      final range = _getRangeDateByFastSearch(state.selectedFastSearch);
      final fetchResult =
          await _fetchServices(range['startDate']!, range['endDate']!);
      _handleFetchServices(fetchResult);
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
      final newStatus =
          newList.isEmpty ? BaseStateStatus.noData : BaseStateStatus.success;

      emit(state.copyWith(status: newStatus, services: newList));
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

    final cachedServices = ServiceHelper.filterServicesByDate(
      _cacheService.services,
      dateTime.year,
      dateTime.month,
    );

    if (cachedServices.isEmpty) {
      emit(state.copyWith(
          status: BaseStateStatus.loading, selectedDate: dateTime));
      final range = _getRangeDateByFastSearch(state.selectedFastSearch);
      final fetchResult =
          await _fetchServices(range['startDate']!, range['endDate']!);
      _handleFetchServices(fetchResult);
    } else {
      emit(state.copyWith(
          services: cachedServices, status: BaseStateStatus.success));
    }
  }

  //TODO: Add option to search by range limited to 3 months
  Future<void> onChageSelectedFastSearch(FastSearch fastSearch) async {
    if (fastSearch == state.selectedFastSearch) return;

    final range = _getRangeDateByFastSearch(fastSearch);
    final cachedServices = ServiceHelper.filterServicesByRange(
        _cacheService.services, range['startDate']!, range['endDate']!);

    if (cachedServices.isEmpty) {
      emit(state.copyWith(
          status: BaseStateStatus.loading, selectedFastSearch: fastSearch));
      final fetchResult =
          await _fetchServices(range['startDate']!, range['endDate']!);
      _handleFetchServices(fetchResult);
    } else {
      emit(state.copyWith(
          services: cachedServices,
          selectedFastSearch: fastSearch,
          status: BaseStateStatus.success));
    }
  }

  Map<String, DateTime> _getRangeDateByFastSearch(FastSearch fastSearch) {
    final today = DateTime.now();
    DateTime startDate;
    DateTime endDate;
    switch (fastSearch) {
      case FastSearch.day:
        startDate = today;
        endDate = today;
        break;
      case FastSearch.week:
        startDate = today.mostRecentWeekday(DateTime.sunday);
        endDate = today.next(DateTime.saturday);
        break;
      case FastSearch.fortnight:
        if (today.day <= 15) {
          startDate = DateTime(today.year, today.month, 1);
          endDate = DateTime(today.year, today.month, 15);
        } else {
          startDate = DateTime(today.year, today.month, 16);
          endDate = DateTime(today.year, today.month + 1, 0);
        }
        break;
      case FastSearch.month:
        startDate = DateTime(today.year, today.month, 1);
        endDate = DateTime(today.year, today.month + 1, 0);
        break;
    }
    return {'startDate': startDate, 'endDate': endDate};
  }

  void changeServices() {
    final cachedServices = ServiceHelper.filterServicesByDate(
      _cacheService.services,
      state.selectedDate.year,
      state.selectedDate.month,
    );

    emit(state.copyWith(
      services: ServiceHelper.addServiceTypeToServices(
          cachedServices, _cacheService.serviceTypes),
    ));
  }
}
