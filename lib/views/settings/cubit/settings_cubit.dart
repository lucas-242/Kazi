import 'package:bloc/bloc.dart';
import 'package:my_services/services/cache_service/cache_service.dart';
import 'package:my_services/shared/models/base_cubit.dart';

import '../../../core/errors/app_error.dart';
import '../../../models/service_type.dart';
import '../../../repositories/service_provided_repository/service_provided_repository.dart';
import '../../../repositories/service_type_repository/service_type_repository.dart';
import '../../../services/auth_service/auth_service.dart';
import '../../../shared/models/base_state.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> with BaseCubit {
  final ServiceTypeRepository _serviceTypeRepository;
  final ServiceProvidedRepository _serviceRepository;
  final AuthService _authService;
  final CacheService _cacheService;

  SettingsCubit(this._serviceTypeRepository, this._serviceRepository,
      this._authService, this._cacheService)
      : super(
          SettingsState(
            serviceTypeList: _cacheService.serviceTypes,
            userId: _authService.user!.uid,
            status: BaseStateStatus.success,
          ),
        );

  void onInit() {
    final status = state.serviceTypeList.isEmpty
        ? BaseStateStatus.noData
        : BaseStateStatus.success;

    emit(state.copyWith(status: status));
  }

  Future<void> getServiceTypes() async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      final result = await _serviceTypeRepository.get(_authService.user!.uid);
      final newStatus =
          result.isEmpty ? BaseStateStatus.noData : BaseStateStatus.success;

      emit(state.copyWith(status: newStatus, serviceTypeList: result));
      _saveOnCache();
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError();
    }
  }

  Future<void> addServiceType() async {
    try {
      _checkServiceValidity();
      emit(state.copyWith(status: BaseStateStatus.loading));
      final result = await _serviceTypeRepository.add(state.serviceType);
      final newList = state.serviceTypeList..add(result);
      emit(state.copyWith(
          status: BaseStateStatus.success,
          serviceTypeList: newList,
          serviceType: ServiceType(userId: _authService.user!.uid)));
      _saveOnCache();
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError();
    }
  }

  Future<void> updateServiceType() async {
    try {
      _checkServiceValidity();
      emit(state.copyWith(status: BaseStateStatus.loading));
      await _serviceTypeRepository.update(state.serviceType);
      final newList = _generateNewListWithModifiedServiceType();

      emit(state.copyWith(
          status: BaseStateStatus.success,
          serviceTypeList: newList,
          serviceType: ServiceType(userId: _authService.user!.uid)));
      _saveOnCache();
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError();
    }
  }

  List<ServiceType> _generateNewListWithModifiedServiceType() {
    final index = state.serviceTypeList
        .indexWhere((element) => element.id == state.serviceType.id);
    final newList = state.serviceTypeList..[index] = state.serviceType;
    return newList;
  }

  Future<void> deleteServiceType(ServiceType serviceType) async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      await _checkServiceTypeIsInUse(serviceType.id);
      await _serviceTypeRepository.delete(serviceType.id);
      final newList = _generateNewListWithoutRemovedServiceType(serviceType);

      emit(state.copyWith(
        status: BaseStateStatus.success,
        serviceTypeList: newList,
      ));

      _saveOnCache();
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError();
    }
  }

  List<ServiceType> _generateNewListWithoutRemovedServiceType(
      ServiceType serviceType) {
    final newList = state.serviceTypeList
      ..removeWhere((element) => element.id == serviceType.id);

    return newList;
  }

  void eraseServiceType() {
    emit(state.copyWith(
        serviceType: ServiceType(userId: _authService.user!.uid)));
  }

  void changeServiceType(ServiceType serviceType) {
    emit(state.copyWith(serviceType: serviceType));
  }

  void changeServiceTypeName(String value) {
    emit(state.copyWith(serviceType: state.serviceType.copyWith(name: value)));
  }

  void changeServiceTypeDefaultValue(String value) {
    final finalValue = double.tryParse(value);
    emit(state.copyWith(
        serviceType: state.serviceType.copyWith(defaultValue: finalValue)));
  }

  void changeServiceTypeDiscountPercent(String value) {
    final finalValue = double.tryParse(value);
    emit(state.copyWith(
        serviceType: state.serviceType.copyWith(discountPercent: finalValue)));
  }

  void _checkServiceValidity() {
    if (state.serviceType.name == '' ||
        state.serviceTypeList
            .map((e) => e.name)
            .contains(state.serviceType.name)) {
      return;
    }
  }

  Future<void> _checkServiceTypeIsInUse(String typeId) async {
    final userId = _authService.user!.uid;
    final count = await _serviceRepository.count(userId, typeId);

    if (count > 0) {
      throw ClientError(
        'O tipo de serviço não pode ser deletado pois está em uso',
        'Triggered by _checkServiceTypeIsInUse on SettingsCubit.',
      );
    }
  }

  void _saveOnCache() {
    _cacheService.serviceTypes = state.serviceTypeList;
  }
}
