import 'package:flutter/material.dart';

import '../../environment/environment.dart';
import '../../utils/ad_helper.dart';
import 'widgets/ad_widget.dart';

class AdBlock extends StatelessWidget {
  final Widget child;

  const AdBlock({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AdWidget(
          ad: AdHelper.getBannerAd(Environment.instance.adHomeServiceListKey),
        ),
        const Divider(),
        child
      ],
    );
  }
}
