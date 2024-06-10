import 'package:flutter/material.dart';
import 'package:kazi/app/core/environment/environment.dart';
import 'package:kazi/app/core/utils/ad_utils.dart';

import 'widgets/ad_widget.dart';

class AdBlock extends StatelessWidget {
  const AdBlock({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AdWidget(
          ad: AdUtils.getBannerAd(Environment.instance.adHomeServiceListKey),
        ),
        const Divider(),
        child
      ],
    );
  }
}
