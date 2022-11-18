import 'package:bloc/bloc.dart';
import 'package:my_services/models/service_provided.dart';
import 'package:my_services/repositories/service_provided_repository/service_provided_repository.dart';
import 'package:my_services/services/auth_service/auth_service.dart';
import 'package:my_services/shared/models/base_cubit.dart';
import 'package:my_services/shared/models/base_state.dart';

import '../../../core/errors/app_error.dart';
import '../../../repositories/service_type_repository/service_type_repository.dart';
import '../../../services/cache_service/cache_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> with BaseCubit {
  final ServiceProvidedRepository _serviceProvidedRepository;
  final ServiceTypeRepository _serviceTypeRepository;
  final AuthService _authService;
  final CacheService _cacheService;

  HomeCubit(
    this._serviceProvidedRepository,
    this._serviceTypeRepository,
    this._authService,
    this._cacheService,
  ) : super(HomeState(
            status: BaseStateStatus.loading, userId: _authService.user!.uid));

  void onInit() async {
    if (_cacheService.serviceProvidedList.isEmpty ||
        _cacheService.serviceTypeList.isEmpty) {
      final result =
          await Future.wait<dynamic>([_fetchServiceTypes(), _fetchServices()]);

      final newStatus =
          result[1].isEmpty ? BaseStateStatus.noData : BaseStateStatus.success;

      emit(state.copyWith(
        status: newStatus,
        serviceProvidedList: _generateServiceWithServiceTypes(result[1]),
      ));
    }
  }

  Future<void> _fetchServiceTypes() async {
    try {
      final result = await _serviceTypeRepository.get(_authService.user!.uid);
      _cacheService.serviceTypeList = result;
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError();
    }
  }

  Future<List<ServiceProvided>> _fetchServices() async {
    try {
      final today = DateTime.now();
      final date = DateTime(today.year, today.month, today.day);
      final result = await _serviceProvidedRepository.get(
        _authService.user!.uid,
        dateTime: date,
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

      emit(state.copyWith(status: newStatus, serviceProvidedList: result));
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError();
    }
  }

  List<ServiceProvided> _generateServiceWithServiceTypes(
      List<ServiceProvided> serviceProvidedList) {
    final result = <ServiceProvided>[];
    for (var service in serviceProvidedList) {
      result.add(_fillServiceWithServiceType(service));
    }
    return result;
  }

  ServiceProvided _fillServiceWithServiceType(ServiceProvided serviceProvided) {
    return serviceProvided.copyWith(
        type: _cacheService.serviceTypeList
            .firstWhere((st) => st.id == serviceProvided.typeId));
  }

  Future<void> deleteServiceProvided(ServiceProvided serviceType) async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      await _serviceProvidedRepository.delete(serviceType.id);
      final newList = _generateNewListWithoutDeletedService(serviceType);
      _cacheService.serviceProvidedList = newList;

      emit(state.copyWith(
        status: BaseStateStatus.success,
        serviceProvidedList: newList,
      ));
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError();
    }
  }

  List<ServiceProvided> _generateNewListWithoutDeletedService(
      ServiceProvided serviceType) {
    final newList = state.serviceProvidedList
      ..removeWhere((element) => element.id == serviceType.id);

    return newList;
  }

  void changeServiceProvidedList(List<ServiceProvided> serviceProvidedList) {
    emit(state.copyWith(
      serviceProvidedList:
          _generateServiceWithServiceTypes(serviceProvidedList),
    ));
  }
}
