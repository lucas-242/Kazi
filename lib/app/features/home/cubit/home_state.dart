part of 'home_cubit.dart';

class HomeState extends BaseState with EquatableMixin {
  HomeState({
    required super.status,
    List<Service>? services,
    super.callbackMessage,
    OrderBy? selectedOrderBy,
  })  : selectedOrderBy = selectedOrderBy ?? OrderBy.dateDesc,
        services = services ?? [];
  List<Service> services;
  OrderBy selectedOrderBy;

  double get totalBalance =>
      services.fold<double>(0, (a, b) => a + b.finalValue);

  double get totalDiscounted =>
      services.fold<double>(0, (a, b) => a + b.discountValue);

  double get totalValue => services.fold<double>(0, (a, b) => a + b.value);

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
