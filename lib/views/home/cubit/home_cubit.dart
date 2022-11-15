import 'package:bloc/bloc.dart';
import 'package:my_services/models/service_provided.dart';
import 'package:my_services/repositories/service_provided_repository/service_provided_repository.dart';
import 'package:my_services/services/auth_service/auth_service.dart';
import 'package:my_services/shared/widgets/base_state/base_state.dart';

import '../../../core/errors/app_error.dart';
import '../../../repositories/service_type_repository/service_type_repository.dart';
import '../../../services/cache_service/cache_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
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
    await Future.wait([getServiceTypes(), getServices()]);
    _fillServicesWithServiceTypes();
  }

  Future<void> getServiceTypes() async {
    try {
      final result = await _serviceTypeRepository.get(_authService.user!.uid);
      _cacheService.serviceTypeList = result;
    } on AppError catch (exception) {
      _onAppError(exception);
    } catch (exception) {
      _unexpectedError();
    }
  }

  Future<void> getServices() async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      final today = DateTime.now();
      final date = DateTime(today.year, today.month);
      final result = await _serviceProvidedRepository.get(
        _authService.user!.uid,
        dateTime: date,
      );
      final newStatus =
          result.isEmpty ? BaseStateStatus.noData : BaseStateStatus.success;

      emit(state.copyWith(status: newStatus, serviceProvidedList: result));
    } on AppError catch (exception) {
      _onAppError(exception);
    } catch (exception) {
      _unexpectedError();
    }
  }

  void _fillServicesWithServiceTypes() {
    for (var sp in state.serviceProvidedList) {
      sp.copyWith(
          type: _cacheService.serviceTypeList
              .firstWhere((st) => st.id == sp.typeId));
    }
  }

  Future<void> addServiceProvided() async {
    try {
      _checkServiceValidity();
      emit(state.copyWith(status: BaseStateStatus.loading));
      final result =
          await _serviceProvidedRepository.add(state.serviceProvided);
      final newList = state.serviceProvidedList..add(result);
      emit(state.copyWith(
          status: BaseStateStatus.success,
          serviceProvidedList: newList,
          serviceProvided: ServiceProvided(userId: _authService.user!.uid)));
    } on AppError catch (exception) {
      _onAppError(exception);
    } catch (exception) {
      _unexpectedError();
    }
  }

  Future<void> updateServiceProvided() async {
    try {
      _checkServiceValidity();
      emit(state.copyWith(status: BaseStateStatus.loading));
      await _serviceProvidedRepository.update(state.serviceProvided);
      final newList = _generateNewListWithModifiedServiceProvided();

      emit(state.copyWith(
          status: BaseStateStatus.success,
          serviceProvidedList: newList,
          serviceProvided: ServiceProvided(userId: _authService.user!.uid)));
    } on AppError catch (exception) {
      _onAppError(exception);
    } catch (exception) {
      _unexpectedError();
    }
  }

  List<ServiceProvided> _generateNewListWithModifiedServiceProvided() {
    final index = state.serviceProvidedList
        .indexWhere((element) => element.id == state.serviceProvided.id);
    final newList = state.serviceProvidedList..[index] = state.serviceProvided;
    return newList;
  }

  Future<void> deleteServiceProvided(ServiceProvided serviceType) async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      await _serviceProvidedRepository.delete(serviceType.id);
      final newList =
          _generateNewListWithoutRemovedServiceProvided(serviceType);

      emit(state.copyWith(
        status: BaseStateStatus.success,
        serviceProvidedList: newList,
      ));
    } on AppError catch (exception) {
      _onAppError(exception);
    } catch (exception) {
      _unexpectedError();
    }
  }

  List<ServiceProvided> _generateNewListWithoutRemovedServiceProvided(
      ServiceProvided serviceType) {
    final newList = state.serviceProvidedList
      ..removeWhere((element) => element.id == serviceType.id);

    return newList;
  }

  void eraseServiceProvided() {
    emit(state.copyWith(
        serviceProvided: ServiceProvided(userId: _authService.user!.uid)));
  }

  void changeServiceProvided(ServiceProvided serviceType) {
    emit(state.copyWith(serviceProvided: serviceType));
  }

  void changeServiceDescription(String value) {
    emit(state.copyWith(
        serviceProvided: state.serviceProvided.copyWith(description: value)));
  }

  void changeServiceTypeId(String value) {
    emit(state.copyWith(
        serviceProvided: state.serviceProvided.copyWith(typeId: value)));
  }

  void changeServiceValue(String value) {
    final finalValue = double.tryParse(value);
    emit(state.copyWith(
        serviceProvided: state.serviceProvided.copyWith(value: finalValue)));
  }

  void changeServiceDate(DateTime? value) {
    emit(state.copyWith(
        serviceProvided: state.serviceProvided.copyWith(date: value)));
  }

  void _checkServiceValidity() {
    if (state.serviceProvided.typeId == '') {
      return;
    }
  }

  void _onAppError(AppError error) {
    emit(state.copyWith(
      callbackMessage: error.message,
      status: BaseStateStatus.error,
    ));
  }

  void _unexpectedError() {
    emit.call(state.copyWith(
      callbackMessage: 'Erro inesperado',
      status: BaseStateStatus.error,
    ));
  }
}
