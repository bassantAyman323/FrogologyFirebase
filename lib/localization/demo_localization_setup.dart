import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:graduationproj1/localization/demolocalizationDelegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'demo_localization.dart';
import 'package:flutter/material.dart';

class DemoLocaliztionSetUp {
  static const Iterable<Locale> supportedLocals = [
    Locale('en'),
    Locale('ar'),
    Locale('fr'),
  ];
  static const Iterable<LocalizationsDelegate<dynamic>> localizationDelegtes = [
    DemoLocalization.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static Locale localeResolutionCallback(
      Locale locale, Iterable<Locale> supportedLocales) {
    for (Locale supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode &&
          supportedLocale.countryCode == locale.countryCode) {
        return supportedLocale;
      }
    }
    return supportedLocales.first;
  }
}
