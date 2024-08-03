import 'package:shortnews/view/uitl/appimage.dart';

class LanguageModel {
  final String flag;
  final String name;
  final String languageCode;
  final String flagImage;

  LanguageModel(
    this.flag,
    this.name,
    this.languageCode,
    this.flagImage,
  );

  static List<LanguageModel> languageList()
   {
    return <LanguageModel>[
      // LanguageModel("🇺🇸", "English", 'en'),
      LanguageModel(
        "Hi! I'am in ShotNews App ",
        "English",
        'en',
        '',
      ), // english
      LanguageModel(
        "नमस्ते! मैं शॉर्ट न्यूज़ ऐप में हूं",
        "हिंदी",
        'hi',
        '',
      ), //swedish
    ];
  }
}
