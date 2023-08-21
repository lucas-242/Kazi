part of 'service_form_cubit.dart';

class ServiceFormState extends BaseState with EquatableMixin {
  ServiceFormState({
    required super.status,
    Service? service,
    required this.userId,
    super.callbackMessage,
    List<ServiceType>? serviceTypes,
    int? quantity,
  })  : service = service ?? Service.toCreate(employeeId: userId),
        serviceTypes = serviceTypes ?? [],
        quantity = quantity ?? 1;
  Service service;
  List<ServiceType> serviceTypes;
  int quantity;
  int userId;

  List<DropdownItem> get dropdownItems {
    final result = serviceTypes
        .map((e) => DropdownItem(value: e.id, label: e.name))
        .toList()
      ..sort(((a, b) => a.label.compareTo(b.label)));

    return result;
  }

  DropdownItem? get selectedDropdownItem {
    if (service.serviceType == null) return null;

    final result = DropdownItem(
        value: service.serviceType!.id, label: service.serviceType!.name);

    return result;
  }

  @override
  ServiceFormState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
    Service? service,
    List<ServiceType>? serviceTypes,
    int? quantity,
  }) {
    return ServiceFormState(
      status: status ?? this.status,
      callbackMessage: callbackMessage ?? this.callbackMessage,
      service: service ?? this.service,
      serviceTypes: serviceTypes ?? this.serviceTypes,
      quantity: quantity ?? this.quantity,
      userId: userId,
    );
  }

  @override
  List<Object?> get props =>
      [service, serviceTypes, quantity, userId, status, callbackMessage];
}
