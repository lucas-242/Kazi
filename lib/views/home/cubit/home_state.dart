part of 'home_cubit.dart';

class HomeState extends BaseState {
  List<ServiceProvided> serviceProvidedList;
  String userId;

  double get totalValue {
    return serviceProvidedList.fold<double>(0, (a, b) => a + b.value);
  }

  double get totalWithDiscount {
    return serviceProvidedList.fold<double>(
        0, (a, b) => a + b.valueWithDiscount);
  }

  double get totalDiscounted {
    return serviceProvidedList.fold<double>(0, (a, b) => a + b.valueDiscounted);
  }

  HomeState({
    required super.status,
    List<ServiceProvided>? serviceProvidedList,
    ServiceProvided? serviceProvided,
    required this.userId,
    super.callbackMessage,
  }) : serviceProvidedList = serviceProvidedList ?? [];

  @override
  HomeState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
    List<ServiceProvided>? serviceProvidedList,
  }) {
    return HomeState(
      status: status ?? this.status,
      callbackMessage: callbackMessage ?? this.callbackMessage,
      serviceProvidedList: serviceProvidedList ?? this.serviceProvidedList,
      userId: userId,
    );
  }
}
