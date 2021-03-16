import 'package:bellbirdmvp/Screens/languageChange.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String ENGLISH = 'en';

const String FARSI = 'ur';
const String HINDI = 'hi';

const LANGUAGE_CODE = 'languageCode';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setString(LANGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  Locale _temp;

  switch (languageCode) {
    case ENGLISH:
      _temp = Locale(languageCode, 'US');
      print(languageCode);
      print('djfioadjioadjfiodjfioajdiofjasdiojasiodjf');

      break;
    case FARSI:
      _temp = Locale(languageCode, 'PK');
      print(languageCode);

      break;
    case HINDI:
      _temp = Locale(languageCode, 'IN');
      print(languageCode);

      break;
    default:
      _temp = Locale(ENGLISH, 'US');
  }

  return _temp;
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LANGUAGE_CODE) ?? ENGLISH;
  return _locale(languageCode);
}
