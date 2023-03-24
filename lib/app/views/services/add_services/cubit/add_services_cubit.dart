import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/utils/base_cubit.dart';
import 'package:my_services/app/shared/utils/form_validator.dart';

import 'package:my_services/app/shared/errors/errors.dart';
import 'package:my_services/app/models/service.dart';
import 'package:my_services/app/models/service_type.dart';
import 'package:my_services/app/repositories/services_repository/services_repository.dart';
import 'package:my_services/app/repositories/service_type_repository/service_type_repository.dart';
import 'package:my_services/app/services/auth_service/auth_service.dart';
import 'package:my_services/app/models/dropdown_item.dart';
import 'package:my_services/app/shared/utils/base_state.dart';

part 'add_services_state.dart';

class AddServicesCubit extends Cubit<AddServicesState>
    with BaseCubit, FormValidator {
  final ServicesRepository _servicesRepository;
  final ServiceTypeRepository _serviceTypeRepository;
  final AuthService _authService;

  AddServicesCubit(
    this._servicesRepository,
    this._serviceTypeRepository,
    this._authService,
  ) : super(AddServicesState(
            status: BaseStateStatus.loading, userId: _authService.user!.uid));

  Future<void> onInit() async {
    try {
      final types = await _getServiceTypes();

      final status = types.isEmpty
          ? BaseStateStatus.noData
          : BaseStateStatus.readyToUserInput;

      emit(state.copyWith(status: status, serviceTypes: types));
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  Future<List<ServiceType>> _getServiceTypes() async {
    final result = await _serviceTypeRepository.get(_authService.user!.uid);
    return result;
  }

  Future<void> addService() async {
    try {
      _checkServiceValidity();
      emit(state.copyWith(status: BaseStateStatus.loading));
      await _servicesRepository.add(state.service, state.quantity);
      emit(state.copyWith(
          status: BaseStateStatus.success,
          quantity: 1,
          service: Service(userId: _authService.user!.uid)));
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  void _checkServiceValidity() {
    if (state.service.typeId.isEmpty) {
      throw ClientError(
        AppLocalizations.current
            .requiredProperty(AppLocalizations.current.serviceType),
        trace: 'Triggered by _checkServiceValidity on AddServicesCubit.',
      );
    }
  }

  Future<void> updateService() async {
    try {
      _checkServiceValidity();
      emit(state.copyWith(status: BaseStateStatus.loading));
      await _servicesRepository.update(state.service);
      emit(state.copyWith(
          status: BaseStateStatus.success,
          quantity: 1,
          service: Service(userId: _authService.user!.uid)));
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  void onChangeService(Service service) {
    emit(state.copyWith(service: service));
  }

  void onChangeServiceDescription(String value) {
    emit(state.copyWith(service: state.service.copyWith(description: value)));
  }

  void onChangeServiceType(DropdownItem dropdownItem) {
    final defaultValue = _getDefaultValueToService(dropdownItem.value);
    final discountValue = _getDefaultDiscountToService(dropdownItem.value);
    emit(
      state.copyWith(
        service: state.service.copyWith(
          typeId: dropdownItem.value,
          value: defaultValue,
          discountPercent: discountValue,
        ),
      ),
    );
  }

  double? _getDefaultValueToService(String serviceTypeId) {
    final serviceType =
        state.serviceTypes.firstWhere((st) => st.id == serviceTypeId);
    return serviceType.defaultValue;
  }

  double? _getDefaultDiscountToService(String serviceTypeId) {
    final serviceType =
        state.serviceTypes.firstWhere((st) => st.id == serviceTypeId);
    return serviceType.discountPercent;
  }

  void onChangeServiceValue(String value) {
    final finalValue = double.tryParse(value);
    emit(state.copyWith(service: state.service.copyWith(value: finalValue)));
  }

  void onChangeServicesQuantity(String value) {
    final finalValue = int.tryParse(value);
    emit(state.copyWith(quantity: finalValue));
  }

  void onChangeServiceDiscount(String value) {
    final finalValue = double.tryParse(value);
    emit(state.copyWith(
        service: state.service.copyWith(discountPercent: finalValue)));
  }

  void onChangeServiceDate(DateTime? value) {
    emit(state.copyWith(service: state.service.copyWith(date: value)));
  }
}
