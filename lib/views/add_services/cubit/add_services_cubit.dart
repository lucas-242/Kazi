import 'package:bloc/bloc.dart';
import 'package:my_services/shared/helpers/service_helper.dart';
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

  void onInit() {
    final status = dropdownItems.isEmpty
        ? BaseStateStatus.noData
        : BaseStateStatus.success;

    emit(state.copyWith(status: status));
  }

  Future<void> addServiceProvided() async {
    try {
      _checkServiceValidity();
      emit(state.copyWith(status: BaseStateStatus.loading));
      var result =
          await _serviceProvidedRepository.add(state.service, state.quantity);
      result = _fillServiceListWithServiceType(result);
      final newList =
          ServiceHelper.mergeServices(_cacheService.services, result);
      _cacheService.services = newList;
      emit(state.copyWith(
          status: BaseStateStatus.success,
          serviceProvidedListUpdated: newList,
          quantity: 1,
          service: ServiceProvided(userId: _authService.user!.uid)));
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError();
    }
  }

  List<ServiceProvided> _fillServiceListWithServiceType(
      List<ServiceProvided> services) {
    final result = <ServiceProvided>[];
    for (var service in services) {
      result.add(_fillServiceWithServiceType(service));
    }
    return result;
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
      await _serviceProvidedRepository.update(state.service);
      final newList = _generateNewListWithUpdatedService();
      _cacheService.services = newList;

      emit(state.copyWith(
          status: BaseStateStatus.success,
          serviceProvidedListUpdated: newList,
          quantity: 1,
          service: ServiceProvided(userId: _authService.user!.uid)));
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError();
    }
  }

  List<ServiceProvided> _generateNewListWithUpdatedService() {
    final index = _cacheService.services
        .indexWhere((element) => element.id == state.service.id);
    final newList = _cacheService.services..[index] = state.service;
    return newList;
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

  List<DropdownItem> get dropdownItems {
    final result = _cacheService.serviceTypes
        .map((e) => DropdownItem(value: e.id, text: e.name))
        .toList();

    return result;
  }

  DropdownItem? get selectedDropdownItem {
    if (state.service.type == null) return null;

    final result = DropdownItem(
        value: state.service.type!.id, text: state.service.type!.name);

    return result;
  }

  List<ServiceProvided> get serviceProvidedList => _cacheService.services;

  void _checkServiceValidity() {
    if (state.service.typeId == '') {
      throw ClientError(
        'O tipo de serviço precisa ser preenchido',
        'Triggered by _checkServiceValidity on AddServicesCubit.',
      );
    }
  }
}
