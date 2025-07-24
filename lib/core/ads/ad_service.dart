import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  static final AdService _instance = AdService._internal();
  factory AdService() => _instance;
  AdService._internal();

  BannerAd? bannerAd;

  Future<void> init() async {
    await MobileAds.instance.initialize();
  }

  void loadBannerAd(
    AdSize size,
    String adUnitId,
    void Function(Ad) onAdLoaded,
  ) {
    bannerAd = BannerAd(
      size: size,
      adUnitId: adUnitId,
      listener: BannerAdListener(
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
      request: const AdRequest(),
    )..load();
  }

  void disposeAd() {
    bannerAd?.dispose();
  }
}
