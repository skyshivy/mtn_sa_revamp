import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mtn_sa_revamp/files/localization/br_sa.dart';
import 'package:mtn_sa_revamp/files/localization/en_us.dart';

class LocalizationService extends Translations {
  // Default locale
  static final locale = Locale('en', 'US');

  // fallbackLocale saves the day when the locale gets in trouble
  static final fallbackLocale = Locale('ar', 'BR');

  // Your supported language here
  static final langs = [
    'English',
    'Burmese',
  ];

  // Supported locales (same order as above)
  static final locales = [
    Locale('en', 'US'),
    Locale('br', 'BR'),
  ];

  // Keys and their translations
  // Translations are defined with `en` and `fr` variable above
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'br_BR': brBR,
      };

  // Use the following method to update your locale
  // Gets locale from language, and updates the locale
  void changeLocale(bool isEnglish) {
    if (isEnglish) {
      final locale = _getLocaleFromLanguage(langs[0]);
      Get.updateLocale(locale!);
    } else {
      final locale = _getLocaleFromLanguage(langs[1]);
      Get.updateLocale(locale!);
    }
  }

  // Finds language in `langs` list and returns it as Locale
  Locale? _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale;
  }
}
