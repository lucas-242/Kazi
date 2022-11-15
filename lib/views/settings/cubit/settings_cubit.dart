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

      emit(state.copyWith(
        status: newStatus,
        serviceTypeList: result,
      ));
    } on AppError catch (exception) {
      emit(state.copyWith(
        callbackMessage: exception.message,
        status: BaseStateStatus.error,
      ));
    } catch (exception) {
      emit.call(state.copyWith(
        callbackMessage: 'Erro inesperado',
        status: BaseStateStatus.error,
      ));
    }
  }

  Future<void> addServiceType() async {
    try {
      //TODO: Create useCase
      if (state.serviceType.name == '' &&
          state.serviceTypeList
              .map((e) => e.name)
              .contains(state.serviceType.name)) {
        return;
      }

      emit(state.copyWith(status: BaseStateStatus.loading));
      final result = await serviceTypeRepository.add(state.serviceType);
      final newList = state.serviceTypeList..add(result);
      emit(state.copyWith(
          status: BaseStateStatus.success,
          serviceTypeList: newList,
          serviceType: ServiceType(userId: authService.user!.uid)));
    } on AppError catch (exception) {
      emit(state.copyWith(
        callbackMessage: exception.message,
        status: BaseStateStatus.error,
      ));
    } catch (exception) {
      emit(state.copyWith(
        callbackMessage: 'Erro inesperado',
        status: BaseStateStatus.error,
      ));
    }
  }

  Future<void> updateServiceType() async {
    try {
      //TODO: Create useCase
      if (state.serviceType.name == '' &&
          state.serviceTypeList
              .map((e) => e.name)
              .contains(state.serviceType.name)) {
        return;
      }

      emit(state.copyWith(status: BaseStateStatus.loading));

      await serviceTypeRepository.update(state.serviceType);
      final index = state.serviceTypeList
          .indexWhere((element) => element.id == state.serviceType.id);
      final newList = state.serviceTypeList..[index] = state.serviceType;

      emit(state.copyWith(
          status: BaseStateStatus.success,
          serviceTypeList: newList,
          serviceType: ServiceType(userId: authService.user!.uid)));
    } on AppError catch (exception) {
      emit(state.copyWith(
        callbackMessage: exception.message,
        status: BaseStateStatus.error,
      ));
    } catch (exception) {
      emit(state.copyWith(
        callbackMessage: 'Erro inesperado',
        status: BaseStateStatus.error,
      ));
    }
  }

  Future<void> deleteServiceType(ServiceType serviceType) async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      await serviceTypeRepository.delete(serviceType.id);
      final newList = state.serviceTypeList
        ..removeWhere((element) => element.id == serviceType.id);
      emit(state.copyWith(
        status: BaseStateStatus.success,
        serviceTypeList: newList,
      ));
    } on AppError catch (exception) {
      emit(state.copyWith(
        callbackMessage: exception.message,
        status: BaseStateStatus.error,
      ));
    } catch (exception) {
      emit(state.copyWith(
        callbackMessage: 'Erro inesperado',
        status: BaseStateStatus.error,
      ));
    }
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
}
