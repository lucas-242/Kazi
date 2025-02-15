import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart' as google_ad;

class AdWidget extends StatelessWidget {

  const AdWidget({super.key, required this.ad, this.height = 60});
  final google_ad.AdWithView? ad;
  final double? height;

  @override
  Widget build(BuildContext context) {
    if (ad == null) {
      return Container();
    }

    return SizedBox(
      height: height,
      child: google_ad.AdWidget(
        ad: ad!..load(),
        key: UniqueKey(),
      ),
    );
  }
}
