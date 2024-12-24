import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kazi/app/shared/utils/log_utils.dart';

abstract class AdHelper {
  static BannerAd? getBannerAd(String adUnitId) {
    if (adUnitId.isEmpty) {
      Log.error('Can\'t load banner ad - AdUnitId is empty.');
      return null;
    }

    return _buildBannerAd(adUnitId: adUnitId, size: AdSize.largeBanner);
  }

  static BannerAd _buildBannerAd({
    required String adUnitId,
    AdSize size = AdSize.banner,
  }) {
    return BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: size,
      listener: BannerAdListener(
        onAdFailedToLoad: (ad, error) {
          Log.error(error);
          ad.dispose();
        },
      ),
    );
  }
}
