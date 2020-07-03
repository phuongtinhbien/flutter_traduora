import 'dart:collection';

import 'package:flutter_traduora/src/traduora_helper.dart';

class TraduoraManager {

  static String defaultLocale;
  static String systemLocale = 'en_US';
  static HashMap<String, String> currentTranslation = new HashMap();


  static Map<String, LibraryLoader> _deferredLibraries = {
    'en': () => new Future.value(null),
    'vi_VN': () => new Future.value(null),
  };


  static Future<bool> initializeMessages(String localeName) async {
    var availableLocale = TraduoraHelper.verifiedLocale(
        localeName,
            (locale) => _deferredLibraries[locale] != null,
        onFailure: (_) => null);
    if (availableLocale == null) {
      return new Future.value(false);
    }
    var lib = _deferredLibraries[availableLocale];
    await (lib == null ? new Future.value(false) : lib());


    //TODO change value curent at hashmap
    return new Future.value(true);
  }


}