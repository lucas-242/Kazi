import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kazi/app/core/errors/errors.dart';
import 'package:kazi/app/core/utils/base_cubit.dart';
import 'package:kazi/app/core/utils/base_state.dart';
import 'package:kazi/app/data/repositories/services_repository/services_repository.dart';
import 'package:kazi/app/models/enums/fast_search.dart';
import 'package:kazi/app/models/enums/order_by.dart';
import 'package:kazi/app/models/service.dart';
import 'package:kazi/app/models/services_filter.dart';
import 'package:kazi/app/services/services_service/services_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> with BaseCubit {
  HomeCubit(
    this._servicesRepository,
    this._servicesService,
  ) : super(HomeState(status: BaseStateStatus.loading));
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
    final result = await _servicesRepository
        .get(const ServicesFilter(fastSearch: FastSearch.today));
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
