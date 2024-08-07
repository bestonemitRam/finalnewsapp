import 'dart:io';

class AppStringFile {
  static String fromLanguageCode = "fromLanguageCode";
  static String toLanguageCode = "toLanguageCode";
  static String app = "App";
  static const String onboardingScreen = "OnboardingScreen";
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-2762223750022353/8377023082";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/2934735716";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-7319269804560504/6941421099";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/4411468910";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String USER_ID = '';
  static String USER_EMAIL = 'USER_EMAIL';
  static String USER_ADDRESS = "USER_ADDRESS";
  static String USER_TOKEN = "USER_TOKEN";
  static String USER_NAME = "USER_NAME";
   static final String forceFully = "forceFully";
  static final String Version = "Version";
  static final String appUpdate = "appUpdate";
  static final String updateUrl = "updateUrl";
  static final String updateMessage = "updateMessage";
}
