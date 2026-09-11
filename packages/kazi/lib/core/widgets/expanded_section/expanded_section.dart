import 'package:flutter/material.dart';

class ExpandedSection extends StatefulWidget {
  const ExpandedSection({
    super.key,
    this.isExpanded = false,
    required this.child,
  });
  final Widget child;
  final bool isExpanded;

  @override
  State<ExpandedSection> createState() => _ExpandedSectionState();
}

class _ExpandedSectionState extends State<ExpandedSection>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  /// False until the first expansion: a section that was never opened has no
  /// child to build and lay out at zero height.
  bool _hasBeenExpanded = false;

  @override
  void initState() {
    super.initState();
    _hasBeenExpanded = widget.isExpanded;
    prepareAnimations();
  }

  void prepareAnimations() {
    expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      // Starts where it already is, and animates only on a change: in a lazy
      // list a section is built anew each time it scrolls back in, and growing
      // it then moves the list under the reader and away from its end.
      value: widget.isExpanded ? 1 : 0,
    );
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck() {
    if (widget.isExpanded) {
      _hasBeenExpanded = true;
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void didUpdateWidget(ExpandedSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) _runExpandCheck();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      alignment: Alignment.bottomCenter,
      sizeFactor: animation,
      child: _hasBeenExpanded ? widget.child : null,
    );
  }
}
