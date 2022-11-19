part of 'home_cubit.dart';

class HomeState extends BaseState {
  List<ServiceProvided> services;

  HomeState({
    required super.status,
    List<ServiceProvided>? services,
    ServiceProvided? serviceProvided,
    super.callbackMessage,
  }) : services = services ?? [];

  @override
  HomeState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
    List<ServiceProvided>? services,
  }) {
    return HomeState(
      status: status ?? this.status,
      callbackMessage: callbackMessage ?? this.callbackMessage,
      services: services ?? this.services,
    );
  }
}
