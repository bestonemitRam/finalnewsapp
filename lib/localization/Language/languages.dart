import 'package:flutter/material.dart';

abstract class Languages {
  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get appName;
  String get labelChangeLanguage;
  String get labelSelectLanguage;
  String get home;
  String get language;
  String get appTheme;
  String get notification;
  String get profile;
  String get addNews;
  String get login;
  String get logout;
  String get watchVideo;
  String get contact;
  String get setting;
}
