import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kazi/app/core/auth/auth.dart';
import 'package:kazi/app/core/errors/errors.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/utils/base_cubit.dart';
import 'package:kazi/app/core/utils/base_state.dart';
import 'package:kazi/app/data/repositories/service_type_repository/service_type_repository.dart';
import 'package:kazi/app/models/service_type.dart';

part 'service_types_state.dart';

class ServiceTypesCubit extends Cubit<ServiceTypesState> with BaseCubit {
  ServiceTypesCubit(this._serviceTypeRepository, this._authService)
      : super(
          ServiceTypesState(
            userId: _authService.user!.uid,
            status: BaseStateStatus.loading,
          ),
        );
  final ServiceTypeRepository _serviceTypeRepository;
  final Auth _authService;

  Future<void> onInit() async {
    try {
      final types = await _fetchServiceTypes();

      final status =
          types.isEmpty ? BaseStateStatus.noData : BaseStateStatus.initial;

      emit(state.copyWith(status: status, serviceTypes: types));
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  Future<List<ServiceType>> _fetchServiceTypes() async {
    final result = await _serviceTypeRepository.get();
    return result;
  }

  Future<void> getServiceTypes() async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      final result = await _fetchServiceTypes();
      final newStatus =
          result.isEmpty ? BaseStateStatus.noData : BaseStateStatus.initial;

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
          serviceType: ServiceType.toCreate(userId: _authService.user!.uid)));
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
          serviceType: ServiceType.toCreate(userId: _authService.user!.uid)));
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  Future<void> deleteServiceType(ServiceType serviceType) async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      await _serviceTypeRepository.delete(serviceType.id);
      final newList = await _fetchServiceTypes();

      emit(state.copyWith(
        status: BaseStateStatus.success,
        serviceTypes: newList,
      ));
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  void eraseServiceType() {
    emit(state.copyWith(
        serviceType: ServiceType.toCreate(userId: _authService.user!.uid)));
  }

  void changeServiceType(ServiceType serviceType) {
    emit(state.copyWith(serviceType: serviceType));
  }

  void changeServiceTypeName(String value) {
    emit(state.copyWith(serviceType: state.serviceType.copyWith(name: value)));
  }

  void changeServiceTypeDefaultValue(double value) => emit(state.copyWith(
      serviceType: state.serviceType.copyWith(defaultValue: value)));

  void changeServiceTypeDiscountPercent(double value) => emit(state.copyWith(
      serviceType: state.serviceType.copyWith(discountPercent: value)));

  void _checkServiceValidity([int? idToExclude]) {
    if (state.serviceType.name.isEmpty) {
      throw ClientError(
          AppLocalizations.current
              .requiredProperty(AppLocalizations.current.serviceType),
          trace: 'Triggered by _checkServiceValidity on SettingsCubit.');
    }
    if (state.serviceTypes
        .where((type) => type.id != idToExclude)
        .map((e) => e.name)
        .contains(state.serviceType.name)) {
      throw ClientError(
          AppLocalizations.current
              .alreadyExists(AppLocalizations.current.serviceType),
          trace: 'Triggered by _checkServiceValidity on SettingsCubit.');
    }
  }
}
