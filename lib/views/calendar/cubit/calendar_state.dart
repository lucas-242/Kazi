part of 'calendar_cubit.dart';

class CalendarState extends BaseState {
  DateTime selectedDate;
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
    ServiceProvided? serviceProvided,
    super.callbackMessage,
    DateTime? selectedDate,
  })  : selectedDate = selectedDate ?? DateTime.now(),
        services = services ?? [];

  @override
  CalendarState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
    List<ServiceProvided>? services,
  }) {
    return CalendarState(
      status: status ?? this.status,
      callbackMessage: callbackMessage ?? this.callbackMessage,
      services: services ?? this.services,
    );
  }
}
