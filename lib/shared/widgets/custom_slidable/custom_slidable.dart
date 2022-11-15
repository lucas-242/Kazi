import '../../themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CustomSlidable extends StatelessWidget {
  final bool leftPanel;
  final bool rightPanel;
  final void Function()? onLeftSlide;
  final void Function()? onRightSlide;
  final Widget child;

  const CustomSlidable({
    Key? key,
    required this.leftPanel,
    required this.rightPanel,
    this.onLeftSlide,
    this.onRightSlide,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      startActionPane: leftPanel
          ? ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) =>
                      onLeftSlide != null ? onLeftSlide!() : null,
                  backgroundColor: context.colorsScheme.primaryContainer,
                  foregroundColor: context.colorsScheme.onPrimaryContainer,
                  icon: Icons.edit,
                  label: 'Editar',
                ),
              ],
            )
          : null,
      endActionPane: rightPanel
          ? ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) =>
                      onRightSlide != null ? onRightSlide!() : null,
                  backgroundColor: context.colorsScheme.primaryContainer,
                  foregroundColor: context.colorsScheme.onPrimaryContainer,
                  icon: Icons.delete,
                  label: 'Deletar',
                ),
              ],
            )
          : null,
      child: child,
    );
  }
}
