import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kazi/app/models/service_type.dart';
import 'package:kazi/app/repositories/service_type_repository/service_type_repository.dart';
import 'package:kazi/app/repositories/services_repository/services_repository.dart';
import 'package:kazi/app/services/auth_service/auth_service.dart';
import 'package:kazi/app/shared/errors/errors.dart';
import 'package:kazi/app/shared/l10n/generated/l10n.dart';
import 'package:kazi/app/shared/utils/base_cubit.dart';
import 'package:kazi/app/shared/utils/base_state.dart';
import 'package:kazi/app/shared/utils/form_validator.dart';

part 'service_types_state.dart';

class ServiceTypesCubit extends Cubit<ServiceTypesState>
    with BaseCubit, FormValidator {

  ServiceTypesCubit(
      this._serviceTypeRepository, this._serviceRepository, this._authService,)
      : super(
          ServiceTypesState(
            userId: _authService.user!.uid,
            status: BaseStateStatus.loading,
          ),
        );
  final ServiceTypeRepository _serviceTypeRepository;
  final ServicesRepository _serviceRepository;
  final AuthService _authService;

  Future<void> onInit() async {
    try {
      final types = await _fetchServiceTypes();

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

  Future<List<ServiceType>> _fetchServiceTypes() async {
    final result = await _serviceTypeRepository.get(_authService.user!.uid);
    return result;
  }

  Future<void> getServiceTypes() async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      final result = await _fetchServiceTypes();
      final newStatus = result.isEmpty
          ? BaseStateStatus.noData
          : BaseStateStatus.readyToUserInput;

      emit(state.copyWith(status: newStatus, serviceTypes: result));
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
      final newList = List<ServiceType>.from(state.serviceTypes)..add(result);
      emit(state.copyWith(
          status: BaseStateStatus.success,
          serviceTypes: newList,
          serviceType: ServiceType(userId: _authService.user!.uid),),);
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  Future<void> updateServiceType() async {
    try {
      _checkServiceValidity(state.serviceType.id);
      emit(state.copyWith(status: BaseStateStatus.loading));
      await _serviceTypeRepository.update(state.serviceType);
      final newList = await _fetchServiceTypes();

      emit(state.copyWith(
          status: BaseStateStatus.success,
          serviceTypes: newList,
          serviceType: ServiceType(userId: _authService.user!.uid),),);
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
        serviceTypes: newList,
      ),);
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  void eraseServiceType() {
    emit(state.copyWith(
        serviceType: ServiceType(userId: _authService.user!.uid),),);
  }

  void changeServiceType(ServiceType serviceType) {
    emit(state.copyWith(serviceType: serviceType));
  }

  void changeServiceTypeName(String value) {
    emit(state.copyWith(serviceType: state.serviceType.copyWith(name: value)));
  }

  void changeServiceTypeDefaultValue(double value) => emit(state.copyWith(
      serviceType: state.serviceType.copyWith(defaultValue: value),),);

  void changeServiceTypeDiscountPercent(double value) => emit(state.copyWith(
      serviceType: state.serviceType.copyWith(discountPercent: value),),);

  void _checkServiceValidity([String? idToExclude]) {
    if (state.serviceType.name.isEmpty) {
      throw ClientError(
          AppLocalizations.current
              .requiredProperty(AppLocalizations.current.serviceType),
          trace: 'Triggered by _checkServiceValidity on SettingsCubit.',);
    }
    if (state.serviceTypes
        .where((type) => type.id != idToExclude)
        .map((e) => e.name)
        .contains(state.serviceType.name)) {
      throw ClientError(
          AppLocalizations.current
              .alreadyExists(AppLocalizations.current.serviceType),
          trace: 'Triggered by _checkServiceValidity on SettingsCubit.',);
    }
  }

  Future<void> _checkServiceTypeIsInUse(String typeId) async {
    final userId = _authService.user!.uid;
    final count = await _serviceRepository.count(userId, typeId);
    if (count > 0) {
      throw ClientError(
        AppLocalizations.current.cantDeleteServiceType,
        trace: 'Triggered by _checkServiceTypeIsInUse on SettingsCubit.',
      );
    }
  }
}
