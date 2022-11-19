import 'package:bloc/bloc.dart';
import 'package:my_services/shared/models/base_cubit.dart';

import '../../../core/errors/app_error.dart';
import '../../../models/service_provided.dart';
import '../../../repositories/service_provided_repository/service_provided_repository.dart';
import '../../../services/auth_service/auth_service.dart';
import '../../../services/cache_service/cache_service.dart';
import '../../../shared/models/dropdown_item.dart';
import '../../../shared/models/base_state.dart';

part 'add_services_state.dart';

class AddServicesCubit extends Cubit<AddServicesState> with BaseCubit {
  final ServiceProvidedRepository _serviceProvidedRepository;
  final AuthService _authService;
  final CacheService _cacheService;

  AddServicesCubit(
    this._serviceProvidedRepository,
    this._authService,
    this._cacheService,
  ) : super(AddServicesState(
            status: BaseStateStatus.success, userId: _authService.user!.uid));

  Future<void> addServiceProvided() async {
    try {
      _checkServiceValidity();
      emit(state.copyWith(status: BaseStateStatus.loading));
      var result = await _serviceProvidedRepository.add(state.serviceProvided);
      result = _fillServiceWithServiceType(result);
      final newList = _cacheService.services..add(result);
      _cacheService.services = newList;
      emit(state.copyWith(
          status: BaseStateStatus.success,
          serviceProvidedListUpdated: newList,
          serviceProvided: ServiceProvided(userId: _authService.user!.uid)));
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError();
    }
  }

  ServiceProvided _fillServiceWithServiceType(ServiceProvided serviceProvided) {
    return serviceProvided.copyWith(
        type: _cacheService.serviceTypes
            .firstWhere((st) => st.id == serviceProvided.typeId));
  }

  Future<void> updateServiceProvided() async {
    try {
      _checkServiceValidity();
      emit(state.copyWith(status: BaseStateStatus.loading));
      await _serviceProvidedRepository.update(state.serviceProvided);
      final newList = _generateNewListWithUpdatedService();
      _cacheService.services = newList;

      emit(state.copyWith(
          status: BaseStateStatus.success,
          serviceProvidedListUpdated: newList,
          serviceProvided: ServiceProvided(userId: _authService.user!.uid)));
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError();
    }
  }

  List<ServiceProvided> _generateNewListWithUpdatedService() {
    final index = _cacheService.services
        .indexWhere((element) => element.id == state.serviceProvided.id);
    final newList = _cacheService.services..[index] = state.serviceProvided;
    return newList;
  }

  void onChangeServiceProvided(ServiceProvided serviceType) {
    emit(state.copyWith(serviceProvided: serviceType));
  }

  void onChangeServiceDescription(String value) {
    emit(state.copyWith(
        serviceProvided: state.serviceProvided.copyWith(description: value)));
  }

  void onChangeServiceType(DropdownItem dropdownItem) {
    final defaultValue = _getDefaultValueToService(dropdownItem.value);
    final discountValue = _getDefaultDiscountToService(dropdownItem.value);
    emit(
      state.copyWith(
        serviceProvided: state.serviceProvided.copyWith(
          typeId: dropdownItem.value,
          value: defaultValue,
          discountPercent: discountValue,
        ),
      ),
    );
  }

  double? _getDefaultValueToService(String serviceTypeId) {
    final serviceType =
        _cacheService.serviceTypes.firstWhere((st) => st.id == serviceTypeId);
    return serviceType.defaultValue;
  }

  double? _getDefaultDiscountToService(String serviceTypeId) {
    final serviceType =
        _cacheService.serviceTypes.firstWhere((st) => st.id == serviceTypeId);
    return serviceType.discountPercent;
  }

  void onChangeServiceValue(String value) {
    final finalValue = double.tryParse(value);
    emit(state.copyWith(
        serviceProvided: state.serviceProvided.copyWith(value: finalValue)));
  }

  void onChangeServiceDiscount(String value) {
    final finalValue = double.tryParse(value);
    emit(state.copyWith(
        serviceProvided:
            state.serviceProvided.copyWith(discountPercent: finalValue)));
  }

  void onChangeServiceDate(DateTime? value) {
    emit(state.copyWith(
        serviceProvided: state.serviceProvided.copyWith(date: value)));
  }

  List<DropdownItem> get dropdownItems {
    final result = _cacheService.serviceTypes
        .map((e) => DropdownItem(value: e.id, text: e.name))
        .toList();

    return result;
  }

  DropdownItem? get selectedDropdownItem {
    if (state.serviceProvided.type == null) return null;

    final result = DropdownItem(
        value: state.serviceProvided.type!.id,
        text: state.serviceProvided.type!.name);

    return result;
  }

  List<ServiceProvided> get serviceProvidedList => _cacheService.services;

  void _checkServiceValidity() {
    if (state.serviceProvided.typeId == '') {
      return;
    }
  }
}
