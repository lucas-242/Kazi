part of 'custom_app_bar_cubit.dart';

class CustomAppBarState extends BaseState with EquatableMixin {
  final items = [
    DropdownItem(
      value: CustomAppBarOptions.order.toString(),
      label: AppLocalizations.current.orderBy,
    ),
    DropdownItem(
      value: CustomAppBarOptions.logout.toString(),
      label: AppLocalizations.current.logout,
    ),
  ];

  final DropdownItem? selectedMenuItem;
  final AppUser user;

  CustomAppBarState({
    super.status = BaseStateStatus.success,
    this.selectedMenuItem,
    required this.user,
  });

  @override
  List<Object> get props => [items, user];

  @override
  CustomAppBarState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
    DropdownItem? selectedMenuItem,
    AppUser? user,
  }) {
    return CustomAppBarState(
      status: status ?? this.status,
      selectedMenuItem: selectedMenuItem ?? this.selectedMenuItem,
      user: user ?? this.user,
    );
  }
}
