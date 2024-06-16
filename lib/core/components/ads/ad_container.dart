import 'package:flutter/material.dart';
import 'package:kazi/core/environment/environment.dart';
import 'package:kazi/core/utils/ad_utils.dart';

import 'widgets/ad_widget.dart';

class AdContainer extends StatelessWidget {
  const AdContainer({super.key, required this.child});
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
