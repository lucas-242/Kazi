import 'package:bloc/bloc.dart';
import 'package:my_services/models/service.dart';
import 'package:my_services/repositories/services_repository/services_repository.dart';
import 'package:my_services/services/auth_service/auth_service.dart';
import 'package:my_services/shared/utils/service_helper.dart';
import 'package:my_services/shared/utils/base_cubit.dart';
import 'package:my_services/shared/utils/base_state.dart';

import '../../../shared/errors/errors.dart';
import '../../../models/service_type.dart';
import '../../../repositories/service_type_repository/service_type_repository.dart';
import '../../../models/enums.dart';

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

  void onInit() async {
    final result =
        await Future.wait<dynamic>([_fetchServiceTypes(), _fetchServices()]);

    _handleFetchServices(result[1]);
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

  Future<List<Service>> _fetchServices() async {
    try {
      final today = DateTime.now();
      final date = DateTime(today.year, today.month, today.day);
      final result = await _serviceProvidedRepository.get(
        _authService.user!.uid,
        date,
      );
      return result;
    } on AppError catch (exception) {
      onAppError(exception);
      rethrow;
    } catch (exception) {
      unexpectedError();
      rethrow;
    }
  }

  Future<void> onRefresh() async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      final result = await _fetchServices();
      _handleFetchServices(result);
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError();
    }
  }

  Future<void> _handleFetchServices(List<Service> fetchResult) async {
    final newStatus =
        fetchResult.isEmpty ? BaseStateStatus.noData : BaseStateStatus.success;

    final types = await _fetchServiceTypes();
    var services = ServiceHelper.addServiceTypeToServices(fetchResult, types);
    services = _orderServices(services, state.selectedOrderBy);

    emit(state.copyWith(status: newStatus, services: services));
  }

  Future<List<Service>> deleteService(Service service) async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      await _serviceProvidedRepository.delete(service.id);
      final newList = await _fetchServices();
      final newStatus =
          newList.isEmpty ? BaseStateStatus.noData : BaseStateStatus.success;

      emit(state.copyWith(status: newStatus, services: newList));
      return newList;
    } on AppError catch (exception) {
      onAppError(exception);
      rethrow;
    } catch (exception) {
      unexpectedError();
      rethrow;
    }
  }

  void onChangeOrderBy(OrderBy orderBy) {
    final services = _orderServices(state.services, orderBy);
    emit(state.copyWith(services: services, selectedOrderBy: orderBy));
  }

  List<Service> _orderServices(List<Service> services, OrderBy orderBy) {
    switch (orderBy) {
      case OrderBy.dateAsc:
        services.sort((a, b) => a.date.compareTo(b.date));
        break;
      case OrderBy.dateDesc:
        services.sort((a, b) => b.date.compareTo(a.date));
        break;
      case OrderBy.typeAsc:
        services.sort((a, b) => a.type!.name.compareTo(b.type!.name));
        break;
      case OrderBy.typeDesc:
        services.sort((a, b) => b.type!.name.compareTo(a.type!.name));
        break;
      case OrderBy.valueAsc:
        services.sort((a, b) => a.value.compareTo(b.value));
        break;
      case OrderBy.valueDesc:
        services.sort((a, b) => b.value.compareTo(a.value));
        break;
    }
    return services;
  }

  Future<void> changeServices() async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    final result = await _fetchServices();
    _handleFetchServices(result);
  }
}
