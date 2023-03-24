import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_services/app/models/service.dart';
import 'package:my_services/app/repositories/services_repository/services_repository.dart';
import 'package:my_services/app/services/auth_service/auth_service.dart';
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

  HomeCubit(
    this._serviceProvidedRepository,
    this._serviceTypeRepository,
    this._authService,
  ) : super(HomeState(status: BaseStateStatus.loading));

  Future<void> onInit() async {
    try {
      final result =
          await Future.wait<dynamic>([_fetchServiceTypes(), _fetchServices()]);

      _handleFetchServices(result[1]);
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

  Future<List<Service>> _fetchServices() async {
    final today = DateTime.now();
    final date = DateTime(today.year, today.month, today.day);
    final result = await _serviceProvidedRepository.get(
      _authService.user!.uid,
      date,
    );
    return result;
  }

  Future<void> onRefresh() async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      final result = await _fetchServices();
      _handleFetchServices(result);
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  Future<void> _handleFetchServices(List<Service> fetchResult) async {
    try {
      final types = await _fetchServiceTypes();
      var services = ServiceHelper.addServiceTypeToServices(fetchResult, types);
      services = ServiceHelper.orderServices(services, state.selectedOrderBy);

      final newStatus = fetchResult.isEmpty
          ? BaseStateStatus.noData
          : BaseStateStatus.success;

      emit(state.copyWith(status: newStatus, services: services));
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  Future<void> deleteService(Service service) async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      await _serviceProvidedRepository.delete(service.id);
      final newList = await _fetchServices();
      final newStatus =
          newList.isEmpty ? BaseStateStatus.noData : BaseStateStatus.success;

      emit(state.copyWith(status: newStatus, services: newList));
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  void onChangeOrderBy(OrderBy orderBy) {
    final services = ServiceHelper.orderServices(state.services, orderBy);
    emit(state.copyWith(services: services, selectedOrderBy: orderBy));
  }

  Future<void> onChangeServices() async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      final result = await _fetchServices();
      _handleFetchServices(result);
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  Future<void> signOut() async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      await _authService.signOut();
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }
}
