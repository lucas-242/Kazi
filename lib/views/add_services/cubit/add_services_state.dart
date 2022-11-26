part of 'add_services_cubit.dart';

class AddServicesState extends BaseState {
  ServiceProvided service;
  List<ServiceType> serviceTypes;
  int quantity;
  String userId;

  List<DropdownItem> get dropdownItems {
    final result = serviceTypes
        .map((e) => DropdownItem(value: e.id, text: e.name))
        .toList()
      ..sort(((a, b) => a.text.compareTo(b.text)));

    return result;
  }

  DropdownItem? get selectedDropdownItem {
    if (service.type == null) return null;

    final result =
        DropdownItem(value: service.type!.id, text: service.type!.name);

    return result;
  }

  AddServicesState({
    required super.status,
    ServiceProvided? service,
    required this.userId,
    super.callbackMessage,
    List<ServiceType>? serviceTypes,
    int? quantity,
  })  : service = service ?? ServiceProvided(userId: userId),
        serviceTypes = serviceTypes ?? [],
        quantity = quantity ?? 1;

  @override
  AddServicesState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
    ServiceProvided? service,
    List<ServiceType>? serviceTypes,
    int? quantity,
  }) {
    return AddServicesState(
      status: status ?? this.status,
      callbackMessage: callbackMessage ?? this.callbackMessage,
      service: service ?? this.service,
      serviceTypes: serviceTypes ?? this.serviceTypes,
      quantity: quantity ?? this.quantity,
      userId: userId,
    );
  }
}
