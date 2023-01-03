import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../shared/utils/base_cubit.dart';
import '../../../shared/utils/form_validator.dart';

import '../../../shared/errors/errors.dart';
import '../../../models/service_type.dart';
import '../../../repositories/services_repository/services_repository.dart';
import '../../../repositories/service_type_repository/service_type_repository.dart';
import '../../../services/auth_service/auth_service.dart';
import '../../../shared/utils/base_state.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> with BaseCubit, FormValidator {
  final ServiceTypeRepository _serviceTypeRepository;
  final ServicesRepository _serviceRepository;
  final AuthService _authService;

  SettingsCubit(
      this._serviceTypeRepository, this._serviceRepository, this._authService)
      : super(
          SettingsState(
            userId: _authService.user!.uid,
            status: BaseStateStatus.loading,
          ),
        );

  Future<void> onInit() async {
    try {
      final types = await _fetchServiceTypes();

      final status =
          types.isEmpty ? BaseStateStatus.noData : BaseStateStatus.success;

      emit(state.copyWith(status: status, serviceTypeList: types));
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  Future<List<ServiceType>> _fetchServiceTypes() async {
    final result = await _serviceTypeRepository.get(_authService.user!.uid);
    return result;
  }

  Future<void> getServiceTypes() async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      final result = await _fetchServiceTypes();
      final newStatus =
          result.isEmpty ? BaseStateStatus.noData : BaseStateStatus.success;

      emit(state.copyWith(status: newStatus, serviceTypeList: result));
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  Future<void> addServiceType() async {
    try {
      _checkServiceValidity();
      emit(state.copyWith(status: BaseStateStatus.loading));
      final result = await _serviceTypeRepository.add(state.serviceType);
      final newList = List<ServiceType>.from(state.serviceTypeList)
        ..add(result);
      emit(state.copyWith(
          status: BaseStateStatus.success,
          serviceTypeList: newList,
          serviceType: ServiceType(userId: _authService.user!.uid)));
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  Future<void> updateServiceType() async {
    try {
      _checkServiceValidity();
      emit(state.copyWith(status: BaseStateStatus.loading));
      await _serviceTypeRepository.update(state.serviceType);
      final newList = await _fetchServiceTypes();

      emit(state.copyWith(
          status: BaseStateStatus.success,
          serviceTypeList: newList,
          serviceType: ServiceType(userId: _authService.user!.uid)));
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  Future<void> deleteServiceType(ServiceType serviceType) async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      await _checkServiceTypeIsInUse(serviceType.id);
      await _serviceTypeRepository.delete(serviceType.id);
      final newList = await _fetchServiceTypes();

      emit(state.copyWith(
        status: BaseStateStatus.success,
        serviceTypeList: newList,
      ));
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
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
    if (state.serviceType.name.isEmpty) {
      throw ClientError('O tipo de serviço não pode ser vazio',
          trace: 'Triggered by _checkServiceValidity on SettingsCubit.');
    }
    if (state.serviceTypeList
        .map((e) => e.name)
        .contains(state.serviceType.name)) {
      throw ClientError('O tipo de serviço já existe',
          trace: 'Triggered by _checkServiceValidity on SettingsCubit.');
    }
  }

  Future<void> _checkServiceTypeIsInUse(String typeId) async {
    final userId = _authService.user!.uid;
    final count = await _serviceRepository.count(userId, typeId);
    if (count > 0) {
      throw ClientError(
        'O tipo de serviço não pode ser deletado pois está em uso',
        trace: 'Triggered by _checkServiceTypeIsInUse on SettingsCubit.',
      );
    }
  }

  Future<void> signOut() async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      await _authService.signOut();
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }
}