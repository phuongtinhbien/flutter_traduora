import 'package:shared_preferences/shared_preferences.dart';

class TraduoraStorageService {
  static TraduoraStorageService _instance;
  static SharedPreferences preferences;
  static Future<TraduoraStorageService> getInstance() async {
    if (_instance == null) {
      _instance = TraduoraStorageService();
    }

    return _instance;
  }

  static initalize() async {
    if (_instance == null) {
      _instance = TraduoraStorageService();
      if (preferences == null) {
        preferences = await SharedPreferences.getInstance();
      }
    }
  }


}
