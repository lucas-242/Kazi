import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_services/app/models/dropdown_item.dart';
import 'package:my_services/app/models/enums.dart';
import 'package:my_services/app/shared/widgets/custom_app_bar/cubit/custom_app_bar_cubit.dart';

import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/themes/themes.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final bool showOrderBy;
  final VoidCallback? onSelectedOrderBy;

  const CustomAppBar({
    Key? key,
    this.showOrderBy = false,
    this.onSelectedOrderBy,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size(0.0, 75.0);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CustomAppBarCubit>();

    return AppBar(
      toolbarHeight: preferredSize.height,
      centerTitle: true,
      automaticallyImplyLeading: false,
      foregroundColor: context.colorsScheme.onSurface,
      title: Row(
        children: [
          const SizedBox(width: 10),
          ClipOval(
            child: Container(
              color: context.colorsScheme.background,
              height: 48,
              width: 48,
              child: const Center(
                child: Text('🦆'),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            AppLocalizations.current.hi(cubit.state.user.shortName),
            style: context.headlineSmall,
          ),
        ],
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(25),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: PopupMenuButton<DropdownItem>(
            onSelected: (item) {
              cubit.onChangeSelectedMenuItem(item);
              if (item.value == CustomAppBarOptions.order.toString()) {
                onSelectedOrderBy?.call();
              } else if (item.value == CustomAppBarOptions.logout.toString()) {
                cubit.signOut();
              }
            },
            splashRadius: 10,
            position: PopupMenuPosition.under,
            itemBuilder: (BuildContext context) => cubit.state.items
                .skipWhile((item) =>
                    !showOrderBy &&
                    item.value == CustomAppBarOptions.order.toString())
                .map((item) => PopupMenuItem<DropdownItem>(
                      value: item,
                      child: Text(item.label),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
