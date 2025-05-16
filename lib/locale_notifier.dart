import 'package:flutter/material.dart';

class LocaleNotifier extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void setLocale(String languageCode) {
    _locale = Locale(languageCode);
    notifyListeners();
  }
}
