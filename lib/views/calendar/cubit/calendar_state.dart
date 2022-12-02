part of 'calendar_cubit.dart';

class CalendarState extends BaseState {
  DateTime startDate;
  DateTime endDate;
  FastSearch selectedFastSearch;
  OrderBy selectedOrderBy;
  List<ServiceProvided> services;

  double get totalValue {
    return services.fold<double>(0, (a, b) => a + b.value);
  }

  double get totalWithDiscount {
    return services.fold<double>(0, (a, b) => a + b.valueWithDiscount);
  }

  double get totalDiscounted {
    return services.fold<double>(0, (a, b) => a + b.valueDiscounted);
  }

  CalendarState({
    required super.status,
    List<ServiceProvided>? services,
    super.callbackMessage,
    DateTime? startDate,
    DateTime? endDate,
    FastSearch? selectedFastSearch,
    OrderBy? selectedOrderBy,
  })  : startDate = startDate ??
            DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day),
        endDate = endDate ??
            DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day),
        services = services ?? [],
        selectedOrderBy = selectedOrderBy ?? OrderBy.typeAsc,
        selectedFastSearch = selectedFastSearch ?? FastSearch.today;

  @override
  CalendarState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
    List<ServiceProvided>? services,
    DateTime? startDate,
    DateTime? endDate,
    FastSearch? selectedFastSearch,
    OrderBy? selectedOrderBy,
  }) {
    return CalendarState(
      status: status ?? this.status,
      callbackMessage: callbackMessage ?? this.callbackMessage,
      services: services ?? this.services,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      selectedFastSearch: selectedFastSearch ?? this.selectedFastSearch,
      selectedOrderBy: selectedOrderBy ?? this.selectedOrderBy,
    );
  }
}
