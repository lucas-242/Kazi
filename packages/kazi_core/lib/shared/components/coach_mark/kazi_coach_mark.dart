import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:kazi_core/shared/components/buttons/kazi_text_button.dart';
import 'package:kazi_core/shared/l10n/generated/l10n.dart';
import 'package:kazi_core/shared/themes/themes.dart';

/// A one-off hint anchored to the thing it is talking about.
///
/// Deliberately not a dialog: it dims the screen only enough to lead the eye,
/// cuts the anchor out of the dim and rings it, and dismisses on any tap. A
/// hint that takes the whole screen stops being a hint and becomes an
/// interruption.
///
/// Shown through [show], which owns a single overlay entry — so two hints can
/// never stack, whatever the callers do.
abstract final class KaziCoachMark {
  static OverlayEntry? _entry;
  static Object? _owner;

  static bool get isShowing => _entry != null;

  /// Anchors a bubble to the widget behind [anchorKey].
  ///
  /// Does nothing when another hint is already up, or when the anchor is not
  /// laid out — a hint pointing at nothing is worse than no hint.
  ///
  /// [owner] identifies the caller, so that [hide] can only remove the mark
  /// its own caller put up. [onLost] runs when the anchor stops being
  /// measurable under the mark — it was dismissed by the layout, not by the
  /// user, so the caller can offer the hint again.
  ///
  /// [anchorRadius] is the anchor's **own** corner radius, which the ring
  /// repeats; null rings it as a stadium, which is what a circle, a pill and a
  /// round icon button all want.
  static void show(
    BuildContext context, {
    required Object owner,
    required GlobalKey anchorKey,
    required String title,
    required String message,
    double? anchorRadius,
    VoidCallback? onDismiss,
    VoidCallback? onLost,
  }) {
    if (_entry != null) return;
    if (boundsOf(anchorKey) == null) return;

    final overlay = Overlay.maybeOf(context, rootOverlay: true);
    if (overlay == null) return;

    void remove() {
      _entry?.remove();
      _entry = null;
      _owner = null;
    }

    _owner = owner;
    _entry = OverlayEntry(
      builder: (_) => _CoachMarkOverlay(
        anchorKey: anchorKey,
        title: title,
        message: message,
        anchorRadius: anchorRadius,
        onDismiss: () {
          remove();
          onDismiss?.call();
        },
        onLost: () {
          remove();
          onLost?.call();
        },
      ),
    );

    overlay.insert(_entry!);
  }

  /// Removes the hint without running any callback, when it belongs to
  /// [owner]. A screen being torn down must not take down the hint another
  /// screen is showing.
  static void hide({required Object owner}) {
    if (_owner != owner) return;
    _entry?.remove();
    _entry = null;
    _owner = null;
  }

  /// The anchor's bounds in global coordinates, or null when it is not laid
  /// out.
  static Rect? boundsOf(GlobalKey key) {
    final render = key.currentContext?.findRenderObject();
    if (render is! RenderBox || !render.hasSize || !render.attached) {
      return null;
    }
    return render.localToGlobal(Offset.zero) & render.size;
  }
}

class _CoachMarkOverlay extends StatefulWidget {
  const _CoachMarkOverlay({
    required this.anchorKey,
    required this.title,
    required this.message,
    required this.anchorRadius,
    required this.onDismiss,
    required this.onLost,
  });

  final GlobalKey anchorKey;
  final String title;
  final String message;
  final double? anchorRadius;
  final VoidCallback onDismiss;
  final VoidCallback onLost;

  @override
  State<_CoachMarkOverlay> createState() => _CoachMarkOverlayState();
}

class _CoachMarkOverlayState extends State<_CoachMarkOverlay> {
  /// How far the spotlight extends past the anchor on each side.
  static const double _spotlightPadding = 8;

  /// Gap between the spotlight and the bubble.
  static const double _bubbleGap = KaziInsets.sm;

  late Rect _anchor;

  @override
  void initState() {
    super.initState();
    _anchor = KaziCoachMark.boundsOf(widget.anchorKey)!;
    _trackAnchor();
  }

  /// The anchor moves — a tab switch, a scroll, a keyboard. Re-measuring every
  /// frame is what keeps the ring on the widget instead of on where it was
  /// when the hint opened.
  void _trackAnchor() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final bounds = KaziCoachMark.boundsOf(widget.anchorKey);
      if (bounds == null) {
        widget.onLost();
        return;
      }

      if (bounds != _anchor) setState(() => _anchor = bounds);
      _trackAnchor();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final size = MediaQuery.sizeOf(context);
    final padding = MediaQuery.paddingOf(context);
    final spotlight = _anchor.inflate(_spotlightPadding);
    // Concentric with the anchor's own corners, rather than the same number:
    // a ring 8px out from a 8px corner curves over 16.
    final radius = widget.anchorRadius != null
        ? widget.anchorRadius! + _spotlightPadding
        : math.min(spotlight.width, spotlight.height) / 2;

    final spaceAbove = spotlight.top - padding.top;
    final spaceBelow = size.height - spotlight.bottom - padding.bottom;
    final showAbove = spaceAbove > spaceBelow;

    return Semantics(
      container: true,
      liveRegion: true,
      label: '${widget.title}. ${widget.message}',
      child: GestureDetector(
        onTap: widget.onDismiss,
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _SpotlightPainter(
                  spotlight: spotlight,
                  radius: radius,
                  scrim: colors.scrim,
                  ring: colors.brand.fill,
                ),
              ),
            ),
            Positioned(
              left: KaziInsets.md,
              right: KaziInsets.md,
              top: showAbove ? null : spotlight.bottom + _bubbleGap,
              bottom: showAbove
                  ? size.height - spotlight.top + _bubbleGap
                  : null,
              child: _Bubble(
                title: widget.title,
                message: widget.message,
                onDismiss: widget.onDismiss,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Dims everything but the anchor, and outlines it. The anchor itself is never
/// painted over — the point of the hint is that the user can see what it is
/// pointing at.
class _SpotlightPainter extends CustomPainter {
  const _SpotlightPainter({
    required this.spotlight,
    required this.radius,
    required this.scrim,
    required this.ring,
  });

  final Rect spotlight;
  final double radius;
  final Color scrim;
  final Color ring;

  static const double _ringWidth = 2;
  static const double _glowWidth = 8;

  RRect get _hole =>
      RRect.fromRectAndRadius(spotlight, Radius.circular(radius));

  @override
  void paint(Canvas canvas, Size size) {
    final hole = _hole;

    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRect(Offset.zero & size),
        Path()..addRRect(hole),
      ),
      Paint()..color = scrim,
    );

    canvas
      ..drawRRect(
        hole.inflate(_glowWidth / 2),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = _glowWidth
          ..color = ring.withValues(alpha: 0.32),
      )
      ..drawRRect(
        hole,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = _ringWidth
          ..color = ring,
      );
  }

  @override
  bool shouldRepaint(_SpotlightPainter oldDelegate) =>
      oldDelegate.spotlight != spotlight ||
      oldDelegate.radius != radius ||
      oldDelegate.scrim != scrim ||
      oldDelegate.ring != ring;
}

class _Bubble extends StatelessWidget {
  const _Bubble({
    required this.title,
    required this.message,
    required this.onDismiss,
  });

  final String title;
  final String message;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Material(
      color: colors.card,
      borderRadius: KaziRadii.mdBorder,
      child: Padding(
        padding: const EdgeInsets.all(KaziInsets.sm),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: KaziTextStyles.titleSmall.copyWith(color: colors.text),
            ),
            KaziSpacings.verticalXxs,
            Text(
              message,
              style: KaziTextStyles.bodySmall.copyWith(
                color: colors.textMuted,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: KaziTextButton(
                onTap: onDismiss,
                color: colors.brand.text,
                child: Text(KaziLocalizations.current.hintGotIt),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
