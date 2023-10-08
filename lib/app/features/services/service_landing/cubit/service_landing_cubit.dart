import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kazi/app/core/errors/errors.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/utils/base_cubit.dart';
import 'package:kazi/app/core/utils/base_state.dart';
import 'package:kazi/app/data/repositories/services_repository/services_repository.dart';
import 'package:kazi/app/models/enums/fast_search.dart';
import 'package:kazi/app/models/enums/order_by.dart';
import 'package:kazi/app/models/service.dart';
import 'package:kazi/app/models/services_filter.dart';
import 'package:kazi/app/services/services_service/services_service.dart';
import 'package:kazi/service_locator.dart';

part 'service_landing_state.dart';

class ServiceLandingCubit extends Cubit<ServiceLandingState> with BaseCubit {
  ServiceLandingCubit()
      : super(ServiceLandingState(
          status: BaseStateStatus.loading,
          startDate: ServiceLocator.get<ServicesService>().now,
          endDate: ServiceLocator.get<ServicesService>().now,
        ));
  final _serviceProvidedRepository = ServiceLocator.get<ServicesRepository>();
  final _servicesService = ServiceLocator.get<ServicesService>();

  Future<void> onInit() async {
    try {
      final dates = _servicesService.getRangeDateByFastSearch(state.fastSearch);
      final startDate = dates.$1;
      final endDate = dates.$2;
      final result = await _getServices(startDate, endDate);
      _handleGetServices(
        result: result,
        startDate: startDate,
        endDate: endDate,
      );
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  Future<List<Service>> _getServices(
      DateTime startDate, DateTime endDate) async {
    final result = await _serviceProvidedRepository.get(
      ServicesFilter(
        scheduledToStartAt: startDate,
        scheduledToEndAt: endDate,
        pageSize: 9999,
      ),
    );
    return result;
  }

  Future<void> _handleGetServices({
    required List<Service> result,
    String? callbackMessage,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final services =
        _servicesService.orderServices(result, state.selectedOrderBy);

    final newStatus =
        result.isEmpty ? BaseStateStatus.noData : BaseStateStatus.success;
    emit(state.copyWith(
      status: newStatus,
      services: services,
      startDate: startDate,
      endDate: endDate,
      callbackMessage: callbackMessage ?? '',
    ));
  }

  Future<void> onRefresh() async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      final dates = _servicesService.getRangeDateByFastSearch(state.fastSearch);
      final startDate = dates.$1;
      final endDate = dates.$2;
      final result = await _getServices(startDate, endDate);
      _handleGetServices(
        result: result,
        startDate: startDate,
        endDate: endDate,
      );
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
      final newList = state.services.where((s) => s.id != service.id).toList();
      _handleGetServices(
        result: newList,
        callbackMessage: AppLocalizations.current.serviceDeleted,
      );
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

      final dates = _servicesService.getRangeDateByFastSearch(fastSearch);
      final startDate = dates.$1;
      final endDate = dates.$2;

      emit(state.copyWith(
        status: BaseStateStatus.loading,
        fastSearch: fastSearch,
        startDate: startDate,
        endDate: endDate,
        didFiltersChange: true,
      ));
      final result = await _getServices(startDate, endDate);
      _handleGetServices(result: result);
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
      final result = await _getServices(startDate, endDate);
      _handleGetServices(
        result: result,
        startDate: startDate,
        endDate: endDate,
      );
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  Future<void> onCleanFilters() async {
    emit(ServiceLandingState(
      status: BaseStateStatus.loading,
      startDate: _servicesService.now,
      endDate: _servicesService.now,
    ));
    onInit();
  }

  void onChangeOrderBy(OrderBy orderBy) {
    final services = _servicesService.orderServices(state.services, orderBy);
    emit(state.copyWith(services: services, selectedOrderBy: orderBy));
  }

  Future<void> onChangeServices(List<Service>? newServices) async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      List<Service> result;
      if (newServices == null) {
        result = await _getServices(state.startDate, state.endDate);
      } else {
        result = List.from(state.services)..addAll(newServices);
      }
      _handleGetServices(result: result);
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }
}
