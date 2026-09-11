import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:kazi_core/shared/themes/themes.dart';

/// The outline of a categorized list row: a thick leading edge in the
/// category's colour and a hairline on the three remaining sides, both drawn
/// as one rounded rectangle.
///
/// A `Row` of a 3 dp block next to the content squares the leading edge off
/// against the card's own corner. Here the leading edge is part of the border,
/// so it follows the curve and mitres into the hairline exactly the way a CSS
/// `border-left` on a `border-radius` box does. See `themes/README.md`.
///
/// Meant for `Material.shape` / `ShapeDecoration`. A null [categoryColor]
/// renders the neutral "no category" edge, so callers can pass an optional
/// colour straight through.
class KaziCategoryBorder extends ShapeBorder {
  const KaziCategoryBorder({
    required this.color,
    required this.categoryColor,
    this.radius = const Radius.circular(KaziRadii.sm),
    this.width = 1,
    this.categoryWidth = KaziCategoryBorder.defaultCategoryWidth,
  });

  static const double defaultCategoryWidth = 3;

  /// The hairline on the top, trailing and bottom sides.
  final Color color;

  /// The leading edge. Null renders it in [color], so a row with no category
  /// reads as an ordinary card — pass `colors.surfaceStrong` instead to keep
  /// the neutral mark the list rows use.
  final Color? categoryColor;

  final Radius radius;
  final double width;
  final double categoryWidth;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsetsDirectional.only(
        start: categoryWidth,
        top: width,
        end: width,
        bottom: width,
      );

  RRect _outer(Rect rect) => RRect.fromRectAndRadius(rect, radius);

  RRect _inner(Rect rect) {
    Radius corner(double horizontal) => Radius.elliptical(
          math.max(0, radius.x - horizontal),
          math.max(0, radius.y - width),
        );

    return RRect.fromRectAndCorners(
      Rect.fromLTRB(
        rect.left + categoryWidth,
        rect.top + width,
        rect.right - width,
        rect.bottom - width,
      ),
      topLeft: corner(categoryWidth),
      bottomLeft: corner(categoryWidth),
      topRight: corner(width),
      bottomRight: corner(width),
    );
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      Path()..addRRect(_outer(rect));

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      Path()..addRRect(_inner(rect));

  /// Everything on the leading side of the ray leaving [origin] along
  /// [direction], as a polygon big enough to cover [rect].
  Path _mitre(Offset origin, Offset direction, Rect rect) {
    final far = rect.longestSide * 2;
    final along = direction / direction.distance;
    final toLeading = Offset(-along.dy, along.dx) * far;
    final start = origin - along * far;
    final end = origin + along * far;

    return Path()
      ..moveTo(start.dx, start.dy)
      ..lineTo(end.dx, end.dy)
      ..lineTo(end.dx + toLeading.dx, end.dy + toLeading.dy)
      ..lineTo(start.dx + toLeading.dx, start.dy + toLeading.dy)
      ..close();
  }

  /// The hairline and leading regions per geometry, at the origin. Rows in a
  /// list share a handful of sizes, and the boolean path operations would
  /// otherwise run again on every frame a swipe or a splash repaints the row.
  static final _regions = <(Size, Radius, double, double), (Path, Path)>{};
  static const _maxCachedRegions = 32;

  (Path, Path) _regionsFor(Size size) {
    final key = (size, radius, width, categoryWidth);
    final cached = _regions[key];
    if (cached != null) return cached;

    final rect = Offset.zero & size;
    final ring = Path.combine(
      PathOperation.difference,
      getOuterPath(rect),
      getInnerPath(rect),
    );

    // A corner is mitred on the ray leaving it in the direction of the two
    // widths that meet there, so the leading edge keeps its full thickness
    // well into the arc instead of being cut off where the straight run ends.
    final leading = Path.combine(
      PathOperation.intersect,
      _mitre(rect.topLeft, Offset(categoryWidth, width), rect),
      _mitre(rect.bottomLeft, Offset(-categoryWidth, width), rect),
    );

    if (_regions.length >= _maxCachedRegions) {
      _regions.remove(_regions.keys.first);
    }
    return _regions[key] = (
      Path.combine(PathOperation.difference, ring, leading),
      Path.combine(PathOperation.intersect, ring, leading),
    );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (rect.isEmpty) return;

    final (hairline, leading) = _regionsFor(rect.size);
    canvas
      ..save()
      ..translate(rect.left, rect.top)
      ..drawPath(hairline, Paint()..color = color)
      ..drawPath(leading, Paint()..color = categoryColor ?? color)
      ..restore();
  }

  @override
  ShapeBorder scale(double t) => KaziCategoryBorder(
        color: color,
        categoryColor: categoryColor,
        radius: radius * t,
        width: width * t,
        categoryWidth: categoryWidth * t,
      );

  @override
  bool operator ==(Object other) =>
      other is KaziCategoryBorder &&
      other.color == color &&
      other.categoryColor == categoryColor &&
      other.radius == radius &&
      other.width == width &&
      other.categoryWidth == categoryWidth;

  @override
  int get hashCode =>
      Object.hash(color, categoryColor, radius, width, categoryWidth);
}
