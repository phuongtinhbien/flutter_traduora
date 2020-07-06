import 'dart:convert';

import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String TOKEN = "token";
const String EXPIRED_TOKEN_DATE = "expired_token_date";
const String PREFIX = "traduora";
const String TRADUORA_STORAGE_KEY = "traduora_storage_key";

class TraduoraStorageManager {
  static TraduoraStorageManager _instance;
  static LocalStorage preferences;

  static Future<TraduoraStorageManager> getInstance() async {
    if (_instance == null) {
      _instance = TraduoraStorageManager();
    }

    return _instance;
  }

  static initalize() async {
    if (_instance == null) {
      _instance = TraduoraStorageManager();
      if (preferences == null) {
        preferences = new LocalStorage("traduora_storage_key");
        await preferences.ready;
      }
    }
  }

  static storeToken(String token) {
    preferences.setItem(TOKEN, token ?? "");
  }

  static String getToken() {
    return preferences.getItem(TOKEN)??"";
  }

  static storeExpiredDate(int date) {
    preferences.setItem(EXPIRED_TOKEN_DATE, date);
  }

  static int getExpiredDate() {
    return preferences.getItem(EXPIRED_TOKEN_DATE)?? 0;
  }

  static storeExportTranslation(String localeCode, data) {
    preferences.setItem("${PREFIX}_${localeCode}", data);
  }

  static dynamic getTranslation(String localeCode) {
    final value = preferences.getItem("${PREFIX}_${localeCode}");
    if (value != null) {
      return value;
    }
    return null;
  }
}
