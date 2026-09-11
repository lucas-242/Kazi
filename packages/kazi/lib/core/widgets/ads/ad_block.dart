import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart' as google_ad;
import 'package:kazi/core/environment/environment.dart';
import 'package:kazi/core/utils/ad_helper.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

/// A list row followed by its banner ad.
///
/// Owns the [google_ad.BannerAd] lifecycle: one ad is created and loaded per
/// mounted block and disposed with it. Building the ad inside `build` instead
/// would issue a fresh request every time the row is scrolled back into view —
/// AdMob reads that as invalid traffic, and the discarded ads never get
/// disposed. The ad is requested and shown only while the list is at rest.
/// See README.md.
class AdBlock extends StatefulWidget {
  const AdBlock({
    super.key,
    required this.child,
    required this.padding,
    this.borderRadius = KaziRadii.smBorder,
  });

  final Widget child;

  /// Around the banner. Only the side the list does not already space, so the
  /// banner sits as far from the row above as from the row below.
  final EdgeInsets padding;

  /// The corner radius of the cards in the list the banner sits in.
  final BorderRadius borderRadius;

  @override
  State<AdBlock> createState() => _AdBlockState();
}

class _AdBlockState extends State<AdBlock> with AutomaticKeepAliveClientMixin {
  google_ad.BannerAd? _ad;
  bool _hasRequested = false;
  bool _isLoaded = false;
  bool _isShown = false;
  ValueListenable<bool>? _isScrolling;

  /// In a lazy list a row scrolled out of view is disposed, and would request
  /// a fresh ad when it scrolls back — the pattern described above.
  @override
  bool get wantKeepAlive => true;

  bool get _isAtRest => !(_isScrolling?.value ?? false);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final isScrolling = Scrollable.maybeOf(
      context,
    )?.position.isScrollingNotifier;
    if (isScrolling == _isScrolling) return;

    _isScrolling?.removeListener(_onScrollActivityChanged);
    _isScrolling = isScrolling?..addListener(_onScrollActivityChanged);
    if (_isAtRest) _load();
  }

  void _onScrollActivityChanged() {
    if (!_isAtRest) return;
    _load();
    if (_isLoaded) _show();
  }

  void _load() {
    if (_hasRequested) return;
    _hasRequested = true;

    final ad = AdHelper.getBannerAd(
      Environment.instance.adKeyServiceList,
      onLoaded: () {
        if (!mounted) return;
        _isLoaded = true;
        if (_isAtRest) _show();
      },
      onFailed: () {
        if (mounted) setState(() => _ad = null);
      },
    );
    _ad = ad;
    ad?.load();
  }

  void _show() {
    if (_isShown || !mounted) return;
    // A scroll can come to rest during layout, where setState is not allowed.
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) => _show());
      return;
    }
    setState(() => _isShown = true);
  }

  @override
  void dispose() {
    _isScrolling?.removeListener(_onScrollActivityChanged);
    _ad?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ad = _ad;

    // Nothing until it renders: an empty slot reads as a broken row, and a
    // sized box reserved for an ad that never loads is dead space. A column
    // either way, so the row is not remounted when the banner arrives.
    return Column(
      children: [
        widget.child,
        if (ad != null && _isShown)
          Padding(
            padding: widget.padding,
            child: ClipRRect(
              borderRadius: widget.borderRadius,
              child: SizedBox(
                width: ad.size.width.toDouble(),
                height: ad.size.height.toDouble(),
                child: google_ad.AdWidget(ad: ad),
              ),
            ),
          ),
      ],
    );
  }
}
