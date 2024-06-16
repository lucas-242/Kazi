import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kazi/core/utils/base_cubit.dart';
import 'package:kazi/core/utils/base_state.dart';
import 'package:kazi/domain/repositories/services_repository.dart';
import 'package:kazi/domain/services/services_service.dart';
import 'package:kazi_core/kazi_core.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> with BaseCubit {
  HomeCubit(this._servicesRepository, this._servicesService)
      : super(HomeState(status: BaseStateStatus.loading));

  final ServicesRepository _servicesRepository;
  final ServicesService _servicesService;

  Future<void> onInit() async {
    try {
      final result = await _getServices();

      await _handleServices(result);
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  Future<List<Service>> _getServices() async {
    final dates = _servicesService.getRangeDateByFastSearch(FastSearch.today);
    final result = await _servicesRepository.get(ServicesFilter(
        scheduledToStartAt: dates.$1, scheduledToEndAt: dates.$2));
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
      final newServices =
          _servicesService.orderServices(services, state.selectedOrderBy);

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
