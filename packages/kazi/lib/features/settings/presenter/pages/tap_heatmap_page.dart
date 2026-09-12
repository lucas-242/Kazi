import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kazi/core/services/data/analytics/tap_heatmap_recorder.dart';
import 'package:kazi/core/widgets/sub_nav_bar.dart';
import 'package:kazi/injector.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

/// Debug-only view of the taps captured in this session.
///
/// It shows what this device *sent*, never what real users did: aggregating
/// across people needs a PostHog read key, which cannot ship in a client. See
/// `core/services/data/analytics/README.md`.
class TapHeatmapPage extends ConsumerStatefulWidget {
  const TapHeatmapPage({super.key});

  @override
  ConsumerState<TapHeatmapPage> createState() => _TapHeatmapPageState();
}

class _TapHeatmapPageState extends ConsumerState<TapHeatmapPage> {
  String? _screen;

  @override
  Widget build(BuildContext context) {
    // `read`: the recorder is not a notifier, so the refresh pill is what
    // brings in taps captured since this page opened.
    final recorder = ref.read(tapHeatmapRecorderProvider);

    final byScreen = <String, List<TapPoint>>{};
    for (final point in recorder.points) {
      (byScreen[point.screen] ??= []).add(point);
    }

    final screens = byScreen.keys.toList()..sort();
    final selected = screens.contains(_screen) ? _screen : screens.firstOrNull;
    final points = selected == null ? const <TapPoint>[] : byScreen[selected]!;

    return Scaffold(
      body: KaziSafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SubNavBar(
              title: 'Tap heatmap',
              pills: [
                KaziCircularButton.plain(
                  onTap: () => setState(() {}),
                  semantics: 'Refresh',
                  child: const Icon(Icons.refresh, size: 18),
                ),
              ],
            ),
            if (selected == null)
              _EmptyState(isCapturing: recorder.isCapturing)
            else ...[
              _ScreenPicker(
                screens: screens,
                selected: selected,
                countOf: (screen) => byScreen[screen]!.length,
                onSelected: (screen) => setState(() => _screen = screen),
              ),
              KaziSpacings.verticalSm,
              _HeatCanvas(points: points),
              KaziSpacings.verticalSm,
              _TargetRanking(points: points),
            ],
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.isCapturing});

  final bool isCapturing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: KaziInsets.xxLg),
      child: Column(
        children: [
          Icon(Icons.blur_on, size: 48, color: context.colors.textMuted),
          KaziSpacings.verticalSm,
          Text(
            isCapturing
                ? 'No taps captured yet. Go use the app and come back.'
                : 'Capture is off for this session — either the Remote Config '
                      'switch is off, this session was sampled out, or '
                      'analytics consent is withheld.',
            textAlign: TextAlign.center,
            style: KaziTextStyles.bodyMedium.copyWith(
              color: context.colors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScreenPicker extends StatelessWidget {
  const _ScreenPicker({
    required this.screens,
    required this.selected,
    required this.countOf,
    required this.onSelected,
  });

  final List<String> screens;
  final String selected;
  final int Function(String screen) countOf;
  final void Function(String screen) onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Wrap(
      spacing: KaziInsets.xxs,
      runSpacing: KaziInsets.xxs,
      children: [
        for (final screen in screens)
          Material(
            color: screen == selected ? colors.brand.fill : colors.card,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: KaziRadii.mdBorder,
              side: BorderSide(color: colors.border),
            ),
            child: InkWell(
              onTap: () => onSelected(screen),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: KaziInsets.xs,
                  vertical: KaziInsets.xxs,
                ),
                child: Text(
                  '$screen · ${countOf(screen)}',
                  style: KaziTextStyles.bodySmall.copyWith(
                    color: screen == selected
                        ? colors.brand.onFill
                        : colors.text,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _HeatCanvas extends StatelessWidget {
  const _HeatCanvas({required this.points});

  final List<TapPoint> points;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AspectRatio(
      // The device's own proportions, so a position reads where it was tapped.
      aspectRatio: context.width / context.height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surfaceMuted,
          borderRadius: KaziRadii.mdBorder,
          border: Border.all(color: colors.border),
        ),
        child: ClipRRect(
          borderRadius: KaziRadii.mdBorder,
          child: CustomPaint(
            painter: _HeatPainter(
              points: points,
              cold: colors.info.fill,
              warm: colors.warning.fill,
              hot: colors.danger.fill,
            ),
            child: const SizedBox.expand(),
          ),
        ),
      ),
    );
  }
}

class _HeatPainter extends CustomPainter {
  const _HeatPainter({
    required this.points,
    required this.cold,
    required this.warm,
    required this.hot,
  });

  /// Taps within this fraction of the surface share a cell, and a cell's share
  /// of the busiest one is what picks its colour.
  static const double _cell = 0.06;

  final List<TapPoint> points;
  final Color cold;
  final Color warm;
  final Color hot;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;

    final counts = <(int, int), int>{};
    for (final point in points) {
      final cell = ((point.x / _cell).floor(), (point.y / _cell).floor());
      counts[cell] = (counts[cell] ?? 0) + 1;
    }

    final busiest = counts.values.reduce(max);
    final radius = size.shortestSide * _cell * 1.6;

    for (final entry in counts.entries) {
      final intensity = entry.value / busiest;
      canvas.drawCircle(
        Offset(
          (entry.key.$1 + 0.5) * _cell * size.width,
          (entry.key.$2 + 0.5) * _cell * size.height,
        ),
        radius,
        Paint()
          ..color = _heatOf(intensity).withValues(alpha: 0.3 + 0.5 * intensity)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
      );
    }
  }

  Color _heatOf(double intensity) {
    if (intensity < 0.34) return cold;
    if (intensity < 0.67) return warm;
    return hot;
  }

  @override
  bool shouldRepaint(_HeatPainter oldDelegate) =>
      oldDelegate.points != points || oldDelegate.hot != hot;
}

class _TargetRanking extends StatelessWidget {
  const _TargetRanking({required this.points});

  final List<TapPoint> points;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final counts = <String, int>{};
    for (final point in points) {
      counts[point.target] = (counts[point.target] ?? 0) + 1;
    }
    final ranked = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Targets', style: context.text.titleMedium),
        KaziSpacings.verticalXxs,
        for (final entry in ranked)
          Padding(
            padding: const EdgeInsets.only(bottom: KaziInsets.xxs),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    entry.key,
                    style: KaziTextStyles.bodyMedium.copyWith(
                      color: entry.key == TapHeatmapRecorder.noTarget
                          ? colors.textMuted
                          : colors.text,
                    ),
                  ),
                ),
                Text('${entry.value}', style: KaziTextStyles.bodyMedium),
              ],
            ),
          ),
      ],
    );
  }
}
