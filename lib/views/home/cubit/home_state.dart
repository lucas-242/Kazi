part of 'home_cubit.dart';

class HomeState extends BaseState {
  List<ServiceProvided> serviceProvidedList;
  ServiceProvided serviceProvided;
  String userId;

  HomeState({
    required super.status,
    List<ServiceProvided>? serviceProvidedList,
    ServiceProvided? serviceProvided,
    required this.userId,
    super.callbackMessage,
  })  : serviceProvided = serviceProvided ?? ServiceProvided(userId: userId),
        serviceProvidedList = serviceProvidedList ?? [];

  @override
  HomeState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
    List<ServiceProvided>? serviceProvidedList,
    ServiceProvided? serviceProvided,
  }) {
    return HomeState(
      status: status ?? this.status,
      callbackMessage: callbackMessage ?? this.callbackMessage,
      serviceProvided: serviceProvided ?? this.serviceProvided,
      serviceProvidedList: serviceProvidedList ?? this.serviceProvidedList,
      userId: userId,
    );
  }
}
