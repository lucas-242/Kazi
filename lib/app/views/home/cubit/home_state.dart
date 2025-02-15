part of 'home_cubit.dart';

class HomeState extends BaseState with EquatableMixin {

  HomeState({
    required super.status,
    List<Service>? services,
    super.callbackMessage,
    OrderBy? selectedOrderBy,
  })  : selectedOrderBy = selectedOrderBy ?? OrderBy.dateDesc,
        services = services ?? const [];
  final List<Service> services;
  final OrderBy selectedOrderBy;

  double get totalValue {
    return services.fold<double>(0, (a, b) => a + b.value);
  }

  double get totalWithDiscount {
    return services.fold<double>(0, (a, b) => a + b.valueWithDiscount);
  }

  double get totalDiscounted {
    return services.fold<double>(0, (a, b) => a + b.valueDiscounted);
  }

  @override
  HomeState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
    List<Service>? services,
    OrderBy? selectedOrderBy,
  }) {
    return HomeState(
      status: status ?? this.status,
      callbackMessage: callbackMessage ?? this.callbackMessage,
      services: services ?? this.services,
      selectedOrderBy: selectedOrderBy ?? this.selectedOrderBy,
    );
  }

  @override
  List<Object?> get props =>
      [services, selectedOrderBy, status, callbackMessage];
}
