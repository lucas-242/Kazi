import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kazi/app/core/auth/auth.dart';
import 'package:kazi/app/core/errors/errors.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/utils/base_cubit.dart';
import 'package:kazi/app/core/utils/base_state.dart';
import 'package:kazi/app/data/repositories/service_type_repository/service_type_repository.dart';
import 'package:kazi/app/data/repositories/services_repository/services_repository.dart';
import 'package:kazi/app/models/dropdown_item.dart';
import 'package:kazi/app/models/service.dart';
import 'package:kazi/app/models/service_type.dart';

part 'service_form_state.dart';

class ServiceFormCubit extends Cubit<ServiceFormState> with BaseCubit {
  ServiceFormCubit(
    this._servicesRepository,
    this._serviceTypeRepository,
    this._authService,
  ) : super(ServiceFormState(
            status: BaseStateStatus.loading, userId: _authService.user!.id));
  final ServicesRepository _servicesRepository;
  final ServiceTypeRepository _serviceTypeRepository;
  final Auth _authService;

  Future<void> onInit([Service? service]) async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading, service: service));
      final types = await _getServiceTypes();

      final status =
          types.isEmpty ? BaseStateStatus.noData : BaseStateStatus.initial;

      emit(ServiceFormState(
        status: status,
        userId: _authService.user!.id,
        serviceTypes: types,
        service: service,
      ));
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  Future<List<ServiceType>> _getServiceTypes() async {
    final result = await _serviceTypeRepository.get();
    return result;
  }

  Future<void> addService() async {
    try {
      _checkServiceValidity();
      emit(state.copyWith(status: BaseStateStatus.loading));
      final newServices =
          await _servicesRepository.add(state.service, state.quantity);
      emit(state.copyWith(
        status: BaseStateStatus.success,
        quantity: 1,
        newServices: newServices,
        service: Service.toCreate(employeeId: _authService.user!.id),
      ));
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  void _checkServiceValidity() {
    if (state.service.serviceTypeId == 0) {
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
        service: Service.toCreate(employeeId: _authService.user!.id),
      ));
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
          serviceTypeId: dropdownItem.value,
          value: defaultValue,
          discountPercent: discountValue,
        ),
      ),
    );
  }

  double? _getDefaultValueToService(int serviceTypeId) {
    final serviceType =
        state.serviceTypes.firstWhere((st) => st.id == serviceTypeId);
    return serviceType.defaultValue;
  }

  double? _getDefaultDiscountToService(int serviceTypeId) {
    final serviceType =
        state.serviceTypes.firstWhere((st) => st.id == serviceTypeId);
    return serviceType.discountPercent;
  }

  void onChangeServiceValue(double value) {
    emit(state.copyWith(service: state.service.copyWith(value: value)));
  }

  void onChangeServicesQuantity(String value) {
    final finalValue = int.tryParse(value);
    emit(state.copyWith(quantity: finalValue));
  }

  void onChangeServiceDiscount(double value) {
    emit(state.copyWith(
        service: state.service.copyWith(discountPercent: value)));
  }

  void onChangeServiceDate(DateTime? value) {
    emit(state.copyWith(
        service: state.service
            .copyWith(scheduledToStartAt: value, scheduledToEndAt: value)));
  }
}
