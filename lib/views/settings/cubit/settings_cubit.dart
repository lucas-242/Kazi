import 'package:bloc/bloc.dart';

import '../../../core/errors/app_error.dart';
import '../../../models/service_type.dart';
import '../../../repositories/service_type_repository/service_type_repository.dart';
import '../../../services/auth_service/auth_service.dart';
import '../../../shared/widgets/base_state/base_state.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  ServiceTypeRepository serviceTypeRepository;
  AuthService authService;

  SettingsCubit(this.serviceTypeRepository, this.authService)
      : super(
          SettingsState(
              userId: authService.user!.uid, status: BaseStateStatus.loading),
        );

  Future<void> getServiceTypes() async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      final result = await serviceTypeRepository.get(authService.user!.uid);
      final newStatus =
          result.isEmpty ? BaseStateStatus.noData : BaseStateStatus.success;

      emit(state.copyWith(status: newStatus, serviceTypeList: result));
    } on AppError catch (exception) {
      _onAppError(exception);
    } catch (exception) {
      _unexpectedError();
    }
  }

  Future<void> addServiceType() async {
    try {
      _checkServiceValidity();
      emit(state.copyWith(status: BaseStateStatus.loading));
      final result = await serviceTypeRepository.add(state.serviceType);
      final newList = state.serviceTypeList..add(result);
      emit(state.copyWith(
          status: BaseStateStatus.success,
          serviceTypeList: newList,
          serviceType: ServiceType(userId: authService.user!.uid)));
    } on AppError catch (exception) {
      _onAppError(exception);
    } catch (exception) {
      _unexpectedError();
    }
  }

  Future<void> updateServiceType() async {
    try {
      _checkServiceValidity();
      emit(state.copyWith(status: BaseStateStatus.loading));
      await serviceTypeRepository.update(state.serviceType);
      final newList = _generateNewListWithModifiedServiceType();

      emit(state.copyWith(
          status: BaseStateStatus.success,
          serviceTypeList: newList,
          serviceType: ServiceType(userId: authService.user!.uid)));
    } on AppError catch (exception) {
      _onAppError(exception);
    } catch (exception) {
      _unexpectedError();
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
      await serviceTypeRepository.delete(serviceType.id);
      final newList = _generateNewListWithoutRemovedServiceType(serviceType);

      emit(state.copyWith(
        status: BaseStateStatus.success,
        serviceTypeList: newList,
      ));
    } on AppError catch (exception) {
      _onAppError(exception);
    } catch (exception) {
      _unexpectedError();
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
        serviceType: ServiceType(userId: authService.user!.uid)));
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
    if (state.serviceType.name == '' &&
        state.serviceTypeList
            .map((e) => e.name)
            .contains(state.serviceType.name)) {
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
