part of 'home_cubit.dart';

class HomeState extends BaseState {
  List<ServiceProvided> services;
  OrderBy selectedOrderBy;

  double get totalValue {
    return services.fold<double>(0, (a, b) => a + b.value);
  }

  double get totalWithDiscount {
    return services.fold<double>(0, (a, b) => a + b.valueWithDiscount);
  }

  double get totalDiscounted {
    return services.fold<double>(0, (a, b) => a + b.valueDiscounted);
  }

  HomeState({
    required super.status,
    List<ServiceProvided>? services,
    ServiceProvided? serviceProvided,
    super.callbackMessage,
    OrderBy? selectedOrderBy,
  })  : selectedOrderBy = selectedOrderBy ?? OrderBy.typeAsc,
        services = services ?? [];

  @override
  HomeState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
    List<ServiceProvided>? services,
    OrderBy? selectedOrderBy,
  }) {
    return HomeState(
      status: status ?? this.status,
      callbackMessage: callbackMessage ?? this.callbackMessage,
      services: services ?? this.services,
      selectedOrderBy: selectedOrderBy ?? this.selectedOrderBy,
    );
  }
}