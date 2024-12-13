part of 'service_form_cubit.dart';

class ServiceFormState extends BaseState with EquatableMixin {
  final Service service;
  final List<ServiceType> serviceTypes;
  final int quantity;
  final String userId;

  List<DropdownItem> get dropdownItems {
    final result = serviceTypes
        .map((e) => DropdownItem(value: e.id, label: e.name))
        .toList()
      ..sort(((a, b) => a.label.compareTo(b.label)));

    return result;
  }

  DropdownItem? get selectedDropdownItem {
    if (service.type == null) return null;

    final result =
        DropdownItem(value: service.type!.id, label: service.type!.name);

    return result;
  }

  ServiceFormState({
    required super.status,
    Service? service,
    required this.userId,
    super.callbackMessage,
    List<ServiceType>? serviceTypes,
    int? quantity,
  })  : service = service ?? Service(userId: userId),
        serviceTypes = serviceTypes ?? const [],
        quantity = quantity ?? 1;

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
