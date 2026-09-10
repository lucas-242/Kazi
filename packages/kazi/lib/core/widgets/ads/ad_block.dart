import 'package:flutter/material.dart';
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
/// disposed. See README.md.
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

class _AdBlockState extends State<AdBlock> {
  google_ad.BannerAd? _ad;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    final ad = AdHelper.getBannerAd(
      Environment.instance.adKeyServiceList,
      onLoaded: () {
        if (mounted) setState(() => _isLoaded = true);
      },
      onFailed: () {
        if (mounted) setState(() => _ad = null);
      },
    );
    _ad = ad;
    ad?.load();
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ad = _ad;

    // Nothing until it renders: an empty slot reads as a broken row, and a
    // sized box reserved for an ad that never loads is dead space.
    if (ad == null || !_isLoaded) {
      return widget.child;
    }

    return Column(
      children: [
        widget.child,
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
