part of 'service_landing_cubit.dart';

class ServiceLandingState extends BaseState with EquatableMixin {
  DateTime startDate;
  DateTime endDate;
  FastSearch selectedFastSearch;
  OrderBy selectedOrderBy;
  List<Service> services;

  double get totalValue {
    return services.fold<double>(0, (a, b) => a + b.value);
  }

  double get totalWithDiscount {
    return services.fold<double>(0, (a, b) => a + b.valueWithDiscount);
  }

  double get totalDiscounted {
    return services.fold<double>(0, (a, b) => a + b.valueDiscounted);
  }

  ServiceLandingState({
    required super.status,
    List<Service>? services,
    super.callbackMessage,
    required this.startDate,
    required this.endDate,
    FastSearch? selectedFastSearch,
    OrderBy? selectedOrderBy,
  })  : services = services ?? [],
        selectedOrderBy = selectedOrderBy ?? OrderBy.typeAsc,
        selectedFastSearch = selectedFastSearch ?? FastSearch.today;

  @override
  ServiceLandingState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
    List<Service>? services,
    DateTime? startDate,
    DateTime? endDate,
    FastSearch? selectedFastSearch,
    OrderBy? selectedOrderBy,
  }) {
    return ServiceLandingState(
      status: status ?? this.status,
      callbackMessage: callbackMessage ?? this.callbackMessage,
      services: services ?? this.services,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      selectedFastSearch: selectedFastSearch ?? this.selectedFastSearch,
      selectedOrderBy: selectedOrderBy ?? this.selectedOrderBy,
    );
  }

  @override
  List<Object?> get props => [
        startDate,
        endDate,
        selectedFastSearch,
        selectedOrderBy,
        services,
        status,
        callbackMessage
      ];
}
