import 'package:flutter/material.dart';
import 'package:kazi/app/shared/environment/environment.dart';
import 'package:kazi/app/shared/utils/ad_helper.dart';

import 'widgets/ad_widget.dart';

class AdBlock extends StatelessWidget {

  const AdBlock({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AdWidget(
          ad: AdHelper.getBannerAd(
            Environment.instance.adKeyServiceList,
          ),
        ),
        const Divider(),
        child,
      ],
    );
  }
}
