import 'package:bloc/bloc.dart';
import 'package:my_services/models/service_provided.dart';
import 'package:my_services/repositories/service_provided_repository/service_provided_repository.dart';
import 'package:my_services/shared/models/base_cubit.dart';
import 'package:my_services/shared/models/base_state.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../services/cache_service/cache_service.dart';

part 'service_list_state.dart';

class ServiceListCubit extends Cubit<ServiceListState> with BaseCubit {
  final ServiceProvidedRepository _serviceProvidedRepository;
  final CacheService _cacheService;

  ServiceListCubit(
    this._serviceProvidedRepository,
    this._cacheService,
  ) : super(ServiceListState(status: BaseStateStatus.success));

  Future<List<ServiceProvided>> deleteService(
      ServiceProvided service, List<ServiceProvided> services) async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      await _serviceProvidedRepository.delete(service.id);
      final newList = _removeDeletedService(service, services);
      _cacheService.serviceProvidedList = newList;

      emit(state.copyWith(status: BaseStateStatus.success));
      return newList;
    } on AppError catch (exception) {
      onAppError(exception);
      rethrow;
    } catch (exception) {
      unexpectedError();
      rethrow;
    }
  }

  List<ServiceProvided> _removeDeletedService(
    ServiceProvided service,
    List<ServiceProvided> services,
  ) {
    final newList = services
      ..removeWhere((element) => element.id == service.id);

    return newList;
  }

  double getTotalValue(List<ServiceProvided> services) {
    return services.fold<double>(0, (a, b) => a + b.value);
  }

  double getTotalWithDiscount(List<ServiceProvided> services) {
    return services.fold<double>(0, (a, b) => a + b.valueWithDiscount);
  }

  double getTotalDiscounted(List<ServiceProvided> services) {
    return services.fold<double>(0, (a, b) => a + b.valueDiscounted);
  }
}
