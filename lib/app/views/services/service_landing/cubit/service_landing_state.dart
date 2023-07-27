part of 'service_landing_cubit.dart';

class ServiceLandingState extends BaseState with EquatableMixin {

  ServiceLandingState({
    required super.status,
    List<Service>? services,
    super.callbackMessage,
    required this.startDate,
    required this.endDate,
    this.fastSearch = FastSearch.month,
    this.selectedOrderBy = OrderBy.alphabetical,
    this.didFiltersChange = false,
  }) : services = services ?? [];
  final DateTime startDate;
  final DateTime endDate;
  final FastSearch fastSearch;
  final OrderBy selectedOrderBy;
  final List<Service> services;
  final bool didFiltersChange;

  double get totalValue => services.fold<double>(0, (a, b) => a + b.value);

  double get totalWithDiscount =>
      services.fold<double>(0, (a, b) => a + b.valueWithDiscount);

  double get totalDiscounted =>
      services.fold<double>(0, (a, b) => a + b.valueDiscounted);

  @override
  ServiceLandingState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
    List<Service>? services,
    DateTime? startDate,
    DateTime? endDate,
    FastSearch? fastSearch,
    OrderBy? selectedOrderBy,
    bool? didFiltersChange,
  }) {
    return ServiceLandingState(
      status: status ?? this.status,
      callbackMessage: callbackMessage ?? this.callbackMessage,
      services: services ?? this.services,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      fastSearch: fastSearch ?? this.fastSearch,
      selectedOrderBy: selectedOrderBy ?? this.selectedOrderBy,
      didFiltersChange: didFiltersChange ?? this.didFiltersChange,
    );
  }

  @override
  List<Object?> get props => [
        startDate,
        endDate,
        fastSearch,
        selectedOrderBy,
        services,
        didFiltersChange,
        status,
        callbackMessage,
      ];
}
