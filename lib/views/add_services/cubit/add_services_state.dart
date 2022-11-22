part of 'add_services_cubit.dart';

class AddServicesState extends BaseState {
  ServiceProvided service;
  int quantity;
  String userId;

  AddServicesState({
    required super.status,
    ServiceProvided? service,
    required this.userId,
    super.callbackMessage,
    int? quantity,
  })  : service = service ?? ServiceProvided(userId: userId),
        quantity = quantity ?? 1;

  @override
  AddServicesState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
    ServiceProvided? service,
    List<ServiceProvided>? serviceProvidedListUpdated,
    int? quantity,
  }) {
    return AddServicesState(
      status: status ?? this.status,
      callbackMessage: callbackMessage ?? this.callbackMessage,
      service: service ?? this.service,
      quantity: quantity ?? this.quantity,
      userId: userId,
    );
  }
}
