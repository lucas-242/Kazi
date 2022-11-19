part of 'service_list_cubit.dart';

class ServiceListState extends BaseState {
  ServiceListState({
    required super.status,
    super.callbackMessage,
  });

  @override
  ServiceListState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
  }) {
    return ServiceListState(
      status: status ?? this.status,
      callbackMessage: callbackMessage ?? this.callbackMessage,
    );
  }
}
