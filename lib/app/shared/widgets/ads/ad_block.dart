import 'package:flutter/material.dart';

import '../../environment/environment.dart';
import '../../utils/ad_helper.dart';
import 'ad_widget.dart';

class AdBlock extends StatelessWidget {
  final Widget child;
  final bool showDate;

  const AdBlock({super.key, required this.child, required this.showDate});

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
