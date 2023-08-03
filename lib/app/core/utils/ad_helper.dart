import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kazi/app/services/log_service/log_service.dart';
import 'package:kazi/injector_container.dart';

abstract class AdHelper {
  static BannerAd? getBannerAd(String adUnitId) {
    if (adUnitId.isEmpty) {
      serviceLocator
          .get<LogService>()
          .error(error: 'Can\'t load banner ad - AdUnitId is empty.');
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
          serviceLocator.get<LogService>().error(error: error);
          ad.dispose();
        },
      ),
    );
  }
}
