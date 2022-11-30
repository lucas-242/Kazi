import 'package:bloc/bloc.dart';
import 'package:my_services/shared/models/base_cubit.dart';

import '../../../core/errors/app_error.dart';
import '../../../models/service_provided.dart';
import '../../../models/service_type.dart';
import '../../../repositories/service_provided_repository/service_provided_repository.dart';
import '../../../repositories/service_type_repository/service_type_repository.dart';
import '../../../services/auth_service/auth_service.dart';
import '../../../shared/models/dropdown_item.dart';
import '../../../shared/models/base_state.dart';

part 'add_services_state.dart';

class AddServicesCubit extends Cubit<AddServicesState> with BaseCubit {
  final ServiceProvidedRepository _serviceProvidedRepository;
  final ServiceTypeRepository _serviceTypeRepository;
  final AuthService _authService;

  AddServicesCubit(
    this._serviceProvidedRepository,
    this._serviceTypeRepository,
    this._authService,
  ) : super(AddServicesState(
            status: BaseStateStatus.loading, userId: _authService.user!.uid));

  Future<void> onInit() async {
    final types = await _fetchServiceTypes();

    final status =
        types.isEmpty ? BaseStateStatus.noData : BaseStateStatus.success;

    emit(state.copyWith(status: status, serviceTypes: types));
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

  Future<void> addServiceProvided() async {
    try {
      _checkServiceValidity();
      emit(state.copyWith(status: BaseStateStatus.loading));
      await _serviceProvidedRepository.add(state.service, state.quantity);
      emit(state.copyWith(
          status: BaseStateStatus.success,
          quantity: 1,
          service: ServiceProvided(userId: _authService.user!.uid)));
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError();
    }
  }

  Future<void> updateServiceProvided() async {
    try {
      _checkServiceValidity();
      emit(state.copyWith(status: BaseStateStatus.loading));
      await _serviceProvidedRepository.update(state.service);
      emit(state.copyWith(
          status: BaseStateStatus.success,
          quantity: 1,
          service: ServiceProvided(userId: _authService.user!.uid)));
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError();
    }
  }

  void onChangeServiceProvided(ServiceProvided serviceType) {
    emit(state.copyWith(service: serviceType));
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

  void _checkServiceValidity() {
    if (state.service.typeId == '') {
      throw ClientError(
        'O tipo de serviço precisa ser preenchido',
        'Triggered by _checkServiceValidity on AddServicesCubit.',
      );
    }
  }
}
