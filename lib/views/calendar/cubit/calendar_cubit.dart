import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:my_services/models/service_provided.dart';
import 'package:my_services/models/service_type.dart';
import 'package:my_services/repositories/service_provided_repository/service_provided_repository.dart';
import 'package:my_services/repositories/service_type_repository/service_type_repository.dart';
import 'package:my_services/services/auth_service/auth_service.dart';
import 'package:my_services/shared/helpers/service_helper.dart';
import 'package:my_services/shared/models/base_cubit.dart';
import 'package:my_services/shared/models/base_state.dart';

import '../../../core/errors/app_error.dart';
import '../../../shared/extensions/extensions.dart';
import '../../../models/fast_search.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> with BaseCubit {
  final ServiceProvidedRepository _serviceProvidedRepository;
  final ServiceTypeRepository _serviceTypeRepository;
  final AuthService _authService;

  CalendarCubit(
    this._serviceProvidedRepository,
    this._serviceTypeRepository,
    this._authService,
  ) : super(CalendarState(status: BaseStateStatus.loading));

  void onInit() async {
    final range = _getRangeDateByFastSearch(state.selectedFastSearch);
    final result = await _fetchServices(range['startDate']!, range['endDate']!);
    _handleFetchServices(result);
  }

  Future<List<ServiceProvided>> _fetchServices(
      DateTime startDate, DateTime endDate) async {
    try {
      final result = await _serviceProvidedRepository.get(
          _authService.user!.uid, startDate, endDate);
      return result;
    } on AppError catch (exception) {
      onAppError(exception);
      rethrow;
    } catch (exception) {
      unexpectedError();
      rethrow;
    }
  }

  Future<List<ServiceType>> _fetchServiceTypes() async {
    try {
      final result = await _serviceTypeRepository.get(_authService.user!.uid);
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

  Future<void> _handleFetchServices(List<ServiceProvided> fetchResult) async {
    final newStatus =
        fetchResult.isEmpty ? BaseStateStatus.noData : BaseStateStatus.success;

    final types = await _fetchServiceTypes();
    final services = ServiceHelper.addServiceTypeToServices(fetchResult, types);

    emit(state.copyWith(status: newStatus, services: services));
  }

  Future<List<ServiceProvided>> deleteService(ServiceProvided service) async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      await _serviceProvidedRepository.delete(service.id);
      final newList = await _fetchServices(
          state.startDate, state.endDate); // _removeDeletedService(service);
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

  Future<void> onChangeDate(DateTimeRange range) async {
    emit(state.copyWith(
      status: BaseStateStatus.loading,
      startDate: range.start,
      endDate: range.end,
      selectedFastSearch: FastSearch.custom,
    ));
    final fetchResult = await _fetchServices(range.start, range.end);
    _handleFetchServices(fetchResult);
  }

  //TODO: Add option to search by range limited to 3 months
  Future<void> onChageSelectedFastSearch(FastSearch fastSearch) async {
    if (fastSearch == state.selectedFastSearch) return;

    final range = _getRangeDateByFastSearch(fastSearch);

    emit(state.copyWith(
      status: BaseStateStatus.loading,
      selectedFastSearch: fastSearch,
      startDate: range['startDate']!,
      endDate: range['endDate']!,
    ));
    final fetchResult =
        await _fetchServices(range['startDate']!, range['endDate']!);
    _handleFetchServices(fetchResult);
  }

  Map<String, DateTime> _getRangeDateByFastSearch(FastSearch fastSearch) {
    final today = DateTime.now();
    DateTime startDate;
    DateTime endDate;
    switch (fastSearch) {
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
      default:
        startDate = today;
        endDate = today;
        break;
    }
    return {
      'startDate': startDate.copyWith(hour: 0, minute: 0, second: 0),
      'endDate': endDate.copyWith(hour: 23, minute: 59, second: 59),
    };
  }

  Future<void> changeServices() async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    final result = await _fetchServices(state.startDate, state.endDate);
    _handleFetchServices(result);
  }
}
