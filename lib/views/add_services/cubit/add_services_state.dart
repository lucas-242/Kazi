part of 'add_services_cubit.dart';

class AddServicesState extends BaseState {
  ServiceProvided serviceProvided;
  String userId;

  AddServicesState({
    required super.status,
    ServiceProvided? serviceProvided,
    required this.userId,
    super.callbackMessage,
  }) : serviceProvided = serviceProvided ?? ServiceProvided(userId: userId);

  @override
  AddServicesState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
    ServiceProvided? serviceProvided,
    List<ServiceProvided>? serviceProvidedListUpdated,
  }) {
    return AddServicesState(
      status: status ?? this.status,
      callbackMessage: callbackMessage ?? this.callbackMessage,
      serviceProvided: serviceProvided ?? this.serviceProvided,
      userId: userId,
    );
  }
}
