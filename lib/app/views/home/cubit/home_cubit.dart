import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kazi/app/models/enums.dart';
import 'package:kazi/app/models/service.dart';
import 'package:kazi/app/models/service_type.dart';
import 'package:kazi/app/repositories/service_type_repository/service_type_repository.dart';
import 'package:kazi/app/repositories/services_repository/services_repository.dart';
import 'package:kazi/app/services/auth_service/auth_service.dart';
import 'package:kazi/app/services/services_service/services_service.dart';
import 'package:kazi/app/shared/errors/errors.dart';
import 'package:kazi/app/shared/utils/base_cubit.dart';
import 'package:kazi/app/shared/utils/base_state.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> with BaseCubit {

  HomeCubit(
    this._serviceProvidedRepository,
    this._serviceTypeRepository,
    this._authService,
    this._servicesService,
  ) : super(HomeState(status: BaseStateStatus.loading));
  final ServicesRepository _serviceProvidedRepository;
  final ServiceTypeRepository _serviceTypeRepository;
  final AuthService _authService;
  final ServicesService _servicesService;

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
    final today = _servicesService.now;
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
      var newServices =
          _servicesService.addServiceTypeToServices(services, types);
      newServices =
          _servicesService.orderServices(newServices, state.selectedOrderBy);

      final newStatus =
          services.isEmpty ? BaseStateStatus.noData : BaseStateStatus.success;

      emit(state.copyWith(status: newStatus, services: newServices));
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }
}
