import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService _instance;
  static SharedPreferences preferences;
  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService();
    }

    return _instance;
  }

  static initalize() async {
    if (_instance == null) {
      _instance = LocalStorageService();
      if (preferences == null) {
        preferences = await SharedPreferences.getInstance();
      }
    }
  }


}
