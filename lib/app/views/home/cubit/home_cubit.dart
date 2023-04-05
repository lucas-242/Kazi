import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_services/app/models/service.dart';
import 'package:my_services/app/repositories/services_repository/services_repository.dart';
import 'package:my_services/app/services/auth_service/auth_service.dart';
import 'package:my_services/app/services/time_service/time_service.dart';
import 'package:my_services/app/shared/utils/service_helper.dart';
import 'package:my_services/app/shared/utils/base_cubit.dart';
import 'package:my_services/app/shared/utils/base_state.dart';

import 'package:my_services/app/shared/errors/errors.dart';
import 'package:my_services/app/models/service_type.dart';
import 'package:my_services/app/repositories/service_type_repository/service_type_repository.dart';
import 'package:my_services/app/models/enums.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> with BaseCubit {
  final ServicesRepository _serviceProvidedRepository;
  final ServiceTypeRepository _serviceTypeRepository;
  final AuthService _authService;
  final TimeService _timeService;

  HomeCubit(
    this._serviceProvidedRepository,
    this._serviceTypeRepository,
    this._authService,
    this._timeService,
  ) : super(HomeState(status: BaseStateStatus.loading));

  Future<void> onInit() async {
    try {
      final result = await Future.wait<dynamic>([
        _getServiceTypes(),
        _getServices(),
      ]);

      await _handleServices(result[1]);
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

  Future<List<Service>> _getServices() async {
    final today = _timeService.nowWithoutTime;
    final result = await _serviceProvidedRepository.get(
      _authService.user!.uid,
      today,
    );
    return result;
  }

  Future<void> onRefresh() async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      final result = await _getServices();
      _handleServices(result);
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  Future<void> _handleServices(List<Service> services) async {
    try {
      final types = await _getServiceTypes();
      var newServices = ServiceHelper.addServiceTypeToServices(services, types);
      newServices =
          ServiceHelper.orderServices(newServices, state.selectedOrderBy);

      final newStatus =
          services.isEmpty ? BaseStateStatus.noData : BaseStateStatus.success;

      emit(state.copyWith(status: newStatus, services: newServices));
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  Future<void> onChangeServices() async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      final result = await _getServices();
      _handleServices(result);
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }
}
