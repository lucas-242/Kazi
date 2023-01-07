part of 'settings_cubit.dart';

class SettingsState extends BaseState with EquatableMixin {
  List<ServiceType> serviceTypeList;
  ServiceType serviceType;
  String userId;

  SettingsState(
      {required this.userId,
      ServiceType? serviceType,
      List<ServiceType>? serviceTypeList,
      required super.status,
      super.callbackMessage})
      : serviceType = serviceType ?? ServiceType(userId: userId),
        serviceTypeList = serviceTypeList ?? [];

  @override
  SettingsState copyWith({
    List<ServiceType>? serviceTypes,
    ServiceType? serviceType,
    BaseStateStatus? status,
    String? callbackMessage,
  }) {
    return SettingsState(
      status: status ?? this.status,
      serviceType: serviceType ?? this.serviceType,
      serviceTypeList: serviceTypes ?? this.serviceTypeList,
      callbackMessage: callbackMessage ?? this.callbackMessage,
      userId: userId,
    );
  }

  @override
  List<Object?> get props =>
      [serviceTypeList, serviceType, userId, status, callbackMessage];
}
