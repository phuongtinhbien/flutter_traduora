import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

const String TOKEN = "token";
const String EXPIRED_TOKEN_DATE = "expired_token_date";
const String PREFIX = "traduora";

class TraduoraStorageManager {
  static TraduoraStorageManager _instance;
  static SharedPreferences preferences;

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
        preferences = await SharedPreferences.getInstance();
      }
    }
  }

  static storeToken (String token){
    preferences.setString(TOKEN, token??"");
  }
  static String getToken (){
    return preferences.getString(TOKEN);
  }
  static storeExpiredDate (int date){
    preferences.setInt(EXPIRED_TOKEN_DATE, date);
  }

  static storeExportTranslation(String localeCode, Map<String, String> data){
    preferences.setString("${PREFIX}_${localeCode}", json.encode(data.toString()));
  }
  static Map<String, String> getTranslation(String localeCode){
    return json.decode(preferences.getString("${PREFIX}_${localeCode}"));
  }
}