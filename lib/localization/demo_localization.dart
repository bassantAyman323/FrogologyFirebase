import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'demolocalizationDelegate.dart';

class DemoLocalization {
  final Locale locale;

  DemoLocalization(this.locale);

  static DemoLocalization of(BuildContext context) {
    return Localizations.of<DemoLocalization>(context, DemoLocalization);
  }

  static const LocalizationsDelegate<DemoLocalization> delegate =
      DemoLocalizationsDelegate();
  Map<String, String> _localizedValues;

  Future load() async {
    String jsonStringValues =
        await rootBundle.loadString('lib/lang/${locale.languageCode}.json');
    Map<String, dynamic> mappedjson = json.decode(jsonStringValues);

    _localizedValues =
        mappedjson.map((key, value) => MapEntry(key, value.toString()));
  }

  String translate(String key) {
    return _localizedValues[key];
  }

  bool get isEnLocale => locale.languageCode == "en";
}
